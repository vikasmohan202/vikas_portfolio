import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

/// ---------- DATA (prefilled from your résumé) ----------
class PortfolioData {
  // Basics
  static const String name = "Vikas Mohan";
  static const String role = "Flutter Developer";
  static const String phone = "+91 9621040205";
  static const String email = "vikasmohan202@gmail.com";

  // Socials (add your actual links)
  static final Uri github = Uri.parse("https://github.com/your-username");
  static final Uri linkedIn = Uri.parse("https://www.linkedin.com/in/your-handle");
  static final Uri hashnode = Uri.parse("https://hashnode.com/@your-handle");

  // Summary
  static const String summary =
      "Experienced in Flutter, Dart, OOP, and Firebase. Built and deployed responsive, "
      "scalable apps on the Play Store.";

  // Skills
  static const List<String> frontend = ["Flutter", "Dart", "Android"];
  static const List<String> devops = ["Azure", "Firebase"];
  static const List<String> database = ["MySQL"];

  // Experience
  static final List<Experience> experiences = [
    Experience(
      title: "Flutter Developer",
      company: "CRMMonster (Remote)",
      period: "Jun 2023 – Present",
      bullets: [
        "Created CRMMonster app in Flutter.",
        "Integrated backend APIs for real-time data exchange.",
        "Implemented CRM features: customer management, task tracking.",
        "Contributed to successful deployment on Google Play.",
      ],
    ),
    Experience(
      title: "Flutter Developer",
      company: "Infomatics Software Solutions",
      period: "Dec 2022 – Jun 2023",
      bullets: [
        "Developed stock analysis app and integrated payment gateway.",
        "Built crypto mining app from scratch.",
        "Crafted user-friendly UI for seamless backend integration.",
      ],
    ),
  ];

  // Projects (add your real links)
  static final List<Project> projects = [
    Project(
      name: "Market Ring",
      tagline: "Instagram-like social app for traders using Flutter & Firebase",
      bullets: [
        "Share portfolios, connect with friends.",
        "Provider for state management.",
      ],
      link: Uri.parse("https://play.google.com/store/apps/details?id=your.marketring"),
    ),
    Project(
      name: "Ceptor",
      tagline: "Crypto mining app",
      bullets: [
        "Built with Flutter.",
        "Provider for state management.",
      ],
      link: Uri.parse("https://example.com/ceptor"),
    ),
  ];

  // Education
  static const Education education = Education(
    school: "AKTU, Lucknow",
    degree: "Bachelor of Technology",
    period: "Jul 2018 – Jul 2022",
  );

  // Certificates / Achievements (add real links)
  static final List<Certificate> certificates = [
    Certificate(
      title: "Udemy — Build 5 Apps Using Flutter and Firebase",
      link: Uri.parse("https://udemy.com/course/your-course-link"),
    ),
    Certificate(
      title: "Blogging on Hashnode",
      link: hashnode,
    ),
  ];
}

class Experience {
  final String title;
  final String company;
  final String period;
  final List<String> bullets;
  const Experience({
    required this.title,
    required this.company,
    required this.period,
    required this.bullets,
  });
}

class Project {
  final String name;
  final String tagline;
  final List<String> bullets;
  final Uri? link;
  const Project({
    required this.name,
    required this.tagline,
    required this.bullets,
    this.link,
  });
}

class Education {
  final String school;
  final String degree;
  final String period;
  const Education({
    required this.school,
    required this.degree,
    required this.period,
  });
}

class Certificate {
  final String title;
  final Uri? link;
  const Certificate({required this.title, this.link});
}

/// ---------- APP ----------
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vikas Mohan | Flutter Developer",
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const PortfolioHome(),
    );
  }

  ThemeData _buildTheme(Brightness b) {
    final seed = const Color(0xFF6750A4);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: b),
      useMaterial3: true,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1.2),
        headlineMedium: TextStyle(fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// ---------- HOME (Single-page with section nav) ----------
class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _scrollCtrl = ScrollController();
  final _sectionKeys = {
    "About": GlobalKey(),
    "Skills": GlobalKey(),
    "Experience": GlobalKey(),
    "Projects": GlobalKey(),
    "Education": GlobalKey(),
    "Contact": GlobalKey(),
  };

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollTo(String section) {
    final key = _sectionKeys[section];
    if (key == null) return;
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface,
            border: Border(
              bottom: BorderSide(color: cs.outlineVariant),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _Logo(name: PortfolioData.name),
                  const Spacer(),
                  _TopNav(
                    items: _sectionKeys.keys.toList(),
                    onTap: _scrollTo,
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: () => _launch(Uri.parse("mailto:${PortfolioData.email}")),
                    icon: const Icon(Icons.mail),
                    label: const Text("Hire Me"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollCtrl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroSection(onSeeWork: () => _scrollTo("Projects")),
            _Section(
              key: _sectionKeys["About"],
              title: "About",
              child: Text(
                PortfolioData.summary,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            _Section(
              key: _sectionKeys["Skills"],
              title: "Skills",
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SkillGroup("Frontend", PortfolioData.frontend),
                  _SkillGroup("DevOps", PortfolioData.devops),
                  _SkillGroup("Database", PortfolioData.database),
                ],
              ),
            ),
            _Section(
              key: _sectionKeys["Experience"],
              title: "Experience",
              child: Column(
                children: PortfolioData.experiences
                    .map((e) => _ExperienceTile(exp: e))
                    .toList(growable: false),
              ),
            ),
            _Section(
              key: _sectionKeys["Projects"],
              title: "Projects",
              child: LayoutBuilder(
                builder: (context, c) {
                  final isWide = c.maxWidth >= 900;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: PortfolioData.projects
                        .map((p) => SizedBox(
                              width: isWide ? (c.maxWidth - 16) / 2 : c.maxWidth,
                              child: _ProjectCard(project: p),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            _Section(
              key: _sectionKeys["Education"],
              title: "Education",
              child: _EducationTile(edu: PortfolioData.education),
            ),
            _Section(
              title: "Achievements & Certificates",
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: PortfolioData.certificates.map((c) {
                  return ActionChip(
                    label: Text(c.title),
                    onPressed: c.link == null ? null : () => _launch(c.link!),
                  );
                }).toList(),
              ),
            ),
            _Section(
              key: _sectionKeys["Contact"],
              title: "Contact",
              child: _ContactCard(),
            ),
            const SizedBox(height: 40),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

/// ---------- UI PARTS ----------
class _Logo extends StatelessWidget {
  final String name;
  const _Logo({required this.name});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            name.isNotEmpty ? name[0] : "V",
            style: TextStyle(
              color: cs.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _TopNav extends StatelessWidget {
  final List<String> items;
  final void Function(String) onTap;
  const _TopNav({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 800;
    if (isSmall) {
      return PopupMenuButton<String>(
        tooltip: "Sections",
        onSelected: onTap,
        itemBuilder: (ctx) => items.map((e) => PopupMenuItem(value: e, child: Text(e))).toList(),
        child: IconButton(icon: const Icon(Icons.menu), onPressed: null),
      );
    }
    return Row(
      children: items
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(onPressed: () => onTap(e), child: Text(e)),
              ))
          .toList(),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onSeeWork;
  const _HeroSection({required this.onSeeWork});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.surface],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: LayoutBuilder(builder: (context, c) {
        final isWide = c.maxWidth >= 900;
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Align(
            alignment: Alignment.center,
            child: Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: isWide ? 3 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText("Hi, I'm", style: t.titleLarge),
                      Text(
                        PortfolioData.name,
                        style: t.displayLarge?.copyWith(
                          fontSize: 56,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        PortfolioData.role,
                        style: t.headlineMedium?.copyWith(color: cs.primary),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        PortfolioData.summary,
                        style: t.titleMedium,
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          FilledButton.icon(
                            onPressed: onSeeWork,
                            icon: const Icon(Icons.work_outline),
                            label: const Text("See my work"),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => _launch(Uri.parse("mailto:${PortfolioData.email}")),
                            icon: const Icon(Icons.mail),
                            label: Text(PortfolioData.email),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => _launch(Uri.parse("tel:${PortfolioData.phone}")),
                            icon: const Icon(Icons.call),
                            label: Text(PortfolioData.phone),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          _LinkChip(icon: Icons.code, label: "GitHub", url: PortfolioData.github),
                          _LinkChip(
                              icon: Icons.business_center, label: "LinkedIn", url: PortfolioData.linkedIn),
                          _LinkChip(icon: Icons.article, label: "Hashnode", url: PortfolioData.hashnode),
                          _LinkChip(
                            icon: Icons.download,
                            label: "Download Résumé",
                            url: Uri.parse("assets/Vikas_Mohan_Resume.pdf"),
                            // Place your PDF in web/assets and link as above, or host externally.
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isWide) const SizedBox(width: 40),
                if (isWide)
                  const Expanded(
                    flex: 2,
                    child: _HeroBadge(),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.08),
              blurRadius: 24,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.phone_iphone, size: 72),
            SizedBox(height: 12),
            Text("Flutter • Firebase • OOP", style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: t.headlineMedium),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  const _SkillGroup(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          ...items.map((s) => Chip(label: Text(s))).toList(),
        ],
      ),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  final Experience exp;
  const _ExperienceTile({required this.exp});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.work_outline, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${exp.title} — ${exp.company}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(exp.period, style: TextStyle(color: cs.onSurfaceVariant)),
                const SizedBox(height: 8),
                ...exp.bullets.map((b) => _Bullet(text: b)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Icon(Icons.apps),
              const SizedBox(width: 8),
              Text(project.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              if (project.link != null)
                IconButton(
                  tooltip: "Open",
                  onPressed: () => _launch(project.link!),
                  icon: const Icon(Icons.open_in_new),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(project.tagline, style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 10),
          ...project.bullets.map((b) => _Bullet(text: b)),
          const SizedBox(height: 4),
        ]),
      ),
    );
  }
}

class _EducationTile extends StatelessWidget {
  final Education edu;
  const _EducationTile({required this.edu});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: cs.primaryContainer,
        child: const Icon(Icons.school),
      ),
      title: Text("${edu.degree} — ${edu.school}",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
      subtitle: Text(edu.period),
    );
  }
}

class _ContactCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeBoxInsetsAll(16),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          _ContactItem(icon: Icons.mail, label: PortfolioData.email, onTap: () {
            _launch(Uri.parse("mailto:${PortfolioData.email}?subject=Hi%20Vikas"));
          }),
          _ContactItem(icon: Icons.call, label: PortfolioData.phone, onTap: () {
            _launch(Uri.parse("tel:${PortfolioData.phone}"));
          }),
          _ContactItem(icon: Icons.code, label: "GitHub", onTap: () => _launch(PortfolioData.github)),
          _ContactItem(
              icon: Icons.business_center,
              label: "LinkedIn",
              onTap: () => _launch(PortfolioData.linkedIn)),
          _ContactItem(icon: Icons.article, label: "Hashnode", onTap: () => _launch(PortfolioData.hashnode)),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ContactItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: Center(
        child: Text(
          "© ${DateTime.now().year} ${PortfolioData.name} — Built with Flutter",
          style: TextStyle(color: cs.onSurfaceVariant),
        ),
      ),
    );
  }
}

/// ---------- HELPERS ----------
Future<void> _launch(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: "_blank",
  )) {
    debugPrint("Could not launch $url");
  }
}

// Small helper because EdgeInsets.all clashes with const inlined values in some analyzers.
class EdgeBoxInsetsAll extends EdgeInsets {
  const EdgeBoxInsetsAll(double value) : super.all(value);
}
class _LinkChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Uri url;

  const _LinkChip({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () => _launch(url),
    );
  }
}
