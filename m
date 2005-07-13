Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVGMRcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVGMRcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMR34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:29:56 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:32450 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261704AbVGMR2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:28:50 -0400
Subject: [PATCH 15/19] Kconfig I18n: xconfig
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:28:44 +0200
Message-Id: <1121275725.2975.43.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Full I18N support for xconfig.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/qconf.cc |   93 +++++++++++++++++++++++------------------------
 1 files changed, 47 insertions(+), 46 deletions(-)

diff -puN scripts/kconfig/qconf.cc~kconfig-i18n-15-qconfig-i18n scripts/kconfig/qconf.cc
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/qconf.cc~kconfig-i18n-15-qconfig-i18n	2005-07-13 18:32:19.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/qconf.cc	2005-07-13 18:36:41.000000000 +0200
@@ -192,7 +192,7 @@ void ConfigItem::updateMenu(void)
 
 	sym = menu->sym;
 	prop = menu->prompt;
-	prompt = QString::fromLocal8Bit(menu_get_prompt(menu));
+	prompt = _(menu_get_prompt(menu));
 
 	if (prop) switch (prop->type) {
 	case P_MENU:
@@ -286,7 +286,7 @@ void ConfigItem::updateMenu(void)
 		break;
 	}
 	if (!sym_has_value(sym) && visible)
-		prompt += " (NEW)";
+		prompt += _(" (NEW)");
 set_prompt:
 	setText(promptColIdx, prompt);
 }
@@ -415,7 +415,7 @@ ConfigList::ConfigList(ConfigView* p, Co
 
 	for (i = 0; i < colNr; i++)
 		colMap[i] = colRevMap[i] = -1;
-	addColumn(promptColIdx, "Option");
+	addColumn(promptColIdx, _("Option"));
 
 	reinit();
 }
@@ -429,14 +429,14 @@ void ConfigList::reinit(void)
 	removeColumn(nameColIdx);
 
 	if (showName)
-		addColumn(nameColIdx, "Name");
+		addColumn(nameColIdx, _("Name"));
 	if (showRange) {
 		addColumn(noColIdx, "N");
 		addColumn(modColIdx, "M");
 		addColumn(yesColIdx, "Y");
 	}
 	if (showData)
-		addColumn(dataColIdx, "Value");
+		addColumn(dataColIdx, _("Value"));
 
 	updateListAll();
 }
@@ -860,50 +860,50 @@ ConfigMainWindow::ConfigMainWindow(void)
 	configList->setFocus();
 
 	menu = menuBar();
-	toolBar = new QToolBar("Tools", this);
+	toolBar = new QToolBar(_("Tools"), this);
 
-	backAction = new QAction("Back", QPixmap(xpm_back), "Back", 0, this);
+	backAction = new QAction(_("Back"), QPixmap(xpm_back), _("Back"), 0, this);
 	  connect(backAction, SIGNAL(activated()), SLOT(goBack()));
 	  backAction->setEnabled(FALSE);
-	QAction *quitAction = new QAction("Quit", "&Quit", CTRL+Key_Q, this);
+	QAction *quitAction = new QAction(_("Quit"), _("&Quit"), CTRL+Key_Q, this);
 	  connect(quitAction, SIGNAL(activated()), SLOT(close()));
-	QAction *loadAction = new QAction("Load", QPixmap(xpm_load), "&Load", CTRL+Key_L, this);
+	QAction *loadAction = new QAction(_("Load"), QPixmap(xpm_load), _("&Load"), CTRL+Key_L, this);
 	  connect(loadAction, SIGNAL(activated()), SLOT(loadConfig()));
-	QAction *saveAction = new QAction("Save", QPixmap(xpm_save), "&Save", CTRL+Key_S, this);
+	QAction *saveAction = new QAction(_("Save"), QPixmap(xpm_save), _("&Save"), CTRL+Key_S, this);
 	  connect(saveAction, SIGNAL(activated()), SLOT(saveConfig()));
-	QAction *saveAsAction = new QAction("Save As...", "Save &As...", 0, this);
+	QAction *saveAsAction = new QAction(_("Save As..."), _("Save &As..."), 0, this);
 	  connect(saveAsAction, SIGNAL(activated()), SLOT(saveConfigAs()));
-	QAction *singleViewAction = new QAction("Single View", QPixmap(xpm_single_view), "Split View", 0, this);
+	QAction *singleViewAction = new QAction(_("Single View"), QPixmap(xpm_single_view), _("Split View"), 0, this);
 	  connect(singleViewAction, SIGNAL(activated()), SLOT(showSingleView()));
-	QAction *splitViewAction = new QAction("Split View", QPixmap(xpm_split_view), "Split View", 0, this);
+	QAction *splitViewAction = new QAction(_("Split View"), QPixmap(xpm_split_view), _("Split View"), 0, this);
 	  connect(splitViewAction, SIGNAL(activated()), SLOT(showSplitView()));
-	QAction *fullViewAction = new QAction("Full View", QPixmap(xpm_tree_view), "Full View", 0, this);
+	QAction *fullViewAction = new QAction(_("Full View"), QPixmap(xpm_tree_view), _("Full View"), 0, this);
 	  connect(fullViewAction, SIGNAL(activated()), SLOT(showFullView()));
 
-	QAction *showNameAction = new QAction(NULL, "Show Name", 0, this);
+	QAction *showNameAction = new QAction(NULL, _("Show Name"), 0, this);
 	  showNameAction->setToggleAction(TRUE);
 	  showNameAction->setOn(configList->showName);
 	  connect(showNameAction, SIGNAL(toggled(bool)), SLOT(setShowName(bool)));
-	QAction *showRangeAction = new QAction(NULL, "Show Range", 0, this);
+	QAction *showRangeAction = new QAction(NULL, _("Show Range"), 0, this);
 	  showRangeAction->setToggleAction(TRUE);
 	  showRangeAction->setOn(configList->showRange);
 	  connect(showRangeAction, SIGNAL(toggled(bool)), SLOT(setShowRange(bool)));
-	QAction *showDataAction = new QAction(NULL, "Show Data", 0, this);
+	QAction *showDataAction = new QAction(NULL, _("Show Data"), 0, this);
 	  showDataAction->setToggleAction(TRUE);
 	  showDataAction->setOn(configList->showData);
 	  connect(showDataAction, SIGNAL(toggled(bool)), SLOT(setShowData(bool)));
-	QAction *showAllAction = new QAction(NULL, "Show All Options", 0, this);
+	QAction *showAllAction = new QAction(NULL, _("Show All Options"), 0, this);
 	  showAllAction->setToggleAction(TRUE);
 	  showAllAction->setOn(configList->showAll);
 	  connect(showAllAction, SIGNAL(toggled(bool)), SLOT(setShowAll(bool)));
-	QAction *showDebugAction = new QAction(NULL, "Show Debug Info", 0, this);
+	QAction *showDebugAction = new QAction(NULL, _("Show Debug Info"), 0, this);
 	  showDebugAction->setToggleAction(TRUE);
 	  showDebugAction->setOn(showDebug);
 	  connect(showDebugAction, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
 
-	QAction *showIntroAction = new QAction(NULL, "Introduction", 0, this);
+	QAction *showIntroAction = new QAction(NULL, _("Introduction"), 0, this);
 	  connect(showIntroAction, SIGNAL(activated()), SLOT(showIntro()));
-	QAction *showAboutAction = new QAction(NULL, "About", 0, this);
+	QAction *showAboutAction = new QAction(NULL, _("About"), 0, this);
 	  connect(showAboutAction, SIGNAL(activated()), SLOT(showAbout()));
 
 	// init tool bar
@@ -918,7 +918,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 
 	// create config menu
 	QPopupMenu* config = new QPopupMenu(this);
-	menu->insertItem("&File", config);
+	menu->insertItem(_("&File"), config);
 	loadAction->addTo(config);
 	saveAction->addTo(config);
 	saveAsAction->addTo(config);
@@ -927,7 +927,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 
 	// create options menu
 	QPopupMenu* optionMenu = new QPopupMenu(this);
-	menu->insertItem("&Option", optionMenu);
+	menu->insertItem(_("&Option"), optionMenu);
 	showNameAction->addTo(optionMenu);
 	showRangeAction->addTo(optionMenu);
 	showDataAction->addTo(optionMenu);
@@ -938,7 +938,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	// create help menu
 	QPopupMenu* helpMenu = new QPopupMenu(this);
 	menu->insertSeparator();
-	menu->insertItem("&Help", helpMenu);
+	menu->insertItem(_("&Help"), helpMenu);
 	showIntroAction->addTo(helpMenu);
 	showAboutAction->addTo(helpMenu);
 
@@ -981,6 +981,7 @@ static QString print_filter(const QStrin
 {
 	QRegExp re("[<>&\"\\n]");
 	QString res = str;
+
 	for (int i = 0; (i = res.find(re, i)) >= 0;) {
 		switch (res[i].latin1()) {
 		case '<':
@@ -1050,13 +1051,13 @@ void ConfigMainWindow::setHelp(QListView
 		head += "<br><br>";
 
 		if (showDebug) {
-			debug += "type: ";
+			debug += _("type: ");
 			debug += print_filter(sym_type_name(sym->type));
 			if (sym_is_choice(sym))
-				debug += " (choice)";
+				debug += _(" (choice)");
 			debug += "<br>";
 			if (sym->rev_dep.expr) {
-				debug += "reverse dep: ";
+				debug += _("reverse dep: ");
 				expr_print(sym->rev_dep.expr, expr_print_help, &debug, E_NONE);
 				debug += "<br>";
 			}
@@ -1064,34 +1065,34 @@ void ConfigMainWindow::setHelp(QListView
 				switch (prop->type) {
 				case P_PROMPT:
 				case P_MENU:
-					debug += "prompt: ";
+					debug += _("prompt: ");
 					debug += print_filter(_(prop->text));
 					debug += "<br>";
 					break;
 				case P_DEFAULT:
-					debug += "default: ";
+					debug += _("default: ");
 					expr_print(prop->expr, expr_print_help, &debug, E_NONE);
 					debug += "<br>";
 					break;
 				case P_CHOICE:
 					if (sym_is_choice(sym)) {
-						debug += "choice: ";
+						debug += _("choice: ");
 						expr_print(prop->expr, expr_print_help, &debug, E_NONE);
 						debug += "<br>";
 					}
 					break;
 				case P_SELECT:
-					debug += "select: ";
+					debug += _("select: ");
 					expr_print(prop->expr, expr_print_help, &debug, E_NONE);
 					debug += "<br>";
 					break;
 				case P_RANGE:
-					debug += "range: ";
+					debug += _("range: ");
 					expr_print(prop->expr, expr_print_help, &debug, E_NONE);
 					debug += "<br>";
 					break;
 				default:
-					debug += "unknown property: ";
+					debug += _("unknown property: ");
 					debug += prop_get_type_name(prop->type);
 					debug += "<br>";
 				}
@@ -1118,7 +1119,7 @@ void ConfigMainWindow::setHelp(QListView
 		}
 	}
 	if (showDebug)
-		debug += QString().sprintf("defined at %s:%d<br><br>", menu->file->name, menu->lineno);
+		debug += QString().sprintf(_("defined at %s:%d<br><br>"), menu->file->name, menu->lineno);
 	helpText->setText(head + debug + help);
 }
 
@@ -1128,14 +1129,14 @@ void ConfigMainWindow::loadConfig(void)
 	if (s.isNull())
 		return;
 	if (conf_read(QFile::encodeName(s)))
-		QMessageBox::information(this, "qconf", "Unable to load configuration!");
+		QMessageBox::information(this, "qconf", _("Unable to load configuration!"));
 	ConfigView::updateListAll();
 }
 
 void ConfigMainWindow::saveConfig(void)
 {
 	if (conf_write(NULL))
-		QMessageBox::information(this, "qconf", "Unable to save configuration!");
+		QMessageBox::information(this, "qconf", _("Unable to save configuration!"));
 }
 
 void ConfigMainWindow::saveConfigAs(void)
@@ -1144,7 +1145,7 @@ void ConfigMainWindow::saveConfigAs(void
 	if (s.isNull())
 		return;
 	if (conf_write(QFile::encodeName(s)))
-		QMessageBox::information(this, "qconf", "Unable to save configuration!");
+		QMessageBox::information(this, "qconf", _("Unable to save configuration!"));
 }
 
 void ConfigMainWindow::changeMenu(struct menu *menu)
@@ -1280,11 +1281,11 @@ void ConfigMainWindow::closeEvent(QClose
 		e->accept();
 		return;
 	}
-	QMessageBox mb("qconf", "Save configuration?", QMessageBox::Warning,
+	QMessageBox mb("qconf", _("Save configuration?"), QMessageBox::Warning,
 			QMessageBox::Yes | QMessageBox::Default, QMessageBox::No, QMessageBox::Cancel | QMessageBox::Escape);
-	mb.setButtonText(QMessageBox::Yes, "&Save Changes");
-	mb.setButtonText(QMessageBox::No, "&Discard Changes");
-	mb.setButtonText(QMessageBox::Cancel, "Cancel Exit");
+	mb.setButtonText(QMessageBox::Yes, _("&Save Changes"));
+	mb.setButtonText(QMessageBox::No, _("&Discard Changes"));
+	mb.setButtonText(QMessageBox::Cancel, _("Cancel Exit"));
 	switch (mb.exec()) {
 	case QMessageBox::Yes:
 		conf_write(NULL);
@@ -1299,7 +1300,7 @@ void ConfigMainWindow::closeEvent(QClose
 
 void ConfigMainWindow::showIntro(void)
 {
-	static char str[] = "Welcome to the qconf graphical kernel configuration tool for Linux.\n\n"
+	static const QString str = _("Welcome to the qconf graphical kernel configuration tool for Linux.\n\n"
 		"For each option, a blank box indicates the feature is disabled, a check\n"
 		"indicates it is enabled, and a dot indicates that it is to be compiled\n"
 		"as a module.  Clicking on the box will cycle through the three states.\n\n"
@@ -1309,15 +1310,15 @@ void ConfigMainWindow::showIntro(void)
 		"options must be enabled to support the option you are interested in, you can\n"
 		"still view the help of a grayed-out option.\n\n"
 		"Toggling Show Debug Info under the Options menu will show the dependencies,\n"
-		"which you can then match by examining other options.\n\n";
+		"which you can then match by examining other options.\n\n");
 
 	QMessageBox::information(this, "qconf", str);
 }
 
 void ConfigMainWindow::showAbout(void)
 {
-	static char str[] = "qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.\n\n"
-		"Bug reports and feature request can also be entered at http://bugzilla.kernel.org/\n";
+	static const QString str = _("qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.\n\n"
+		"Bug reports and feature request can also be entered at http://bugzilla.kernel.org/\n");
 
 	QMessageBox::information(this, "qconf", str);
 }
@@ -1379,7 +1380,7 @@ static const char *progname;
 
 static void usage(void)
 {
-	printf("%s <config>\n", progname);
+	printf(_("%s <config>\n"), progname);
 	exit(0);
 }
 
_


