Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSKMVi2>; Wed, 13 Nov 2002 16:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSKMVi2>; Wed, 13 Nov 2002 16:38:28 -0500
Received: from mgw-dax2.ext.nokia.com ([63.78.179.217]:31409 "EHLO
	mgw-dax2.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S263986AbSKMViZ> convert rfc822-to-8bit; Wed, 13 Nov 2002 16:38:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: patch: qconf "help" menu
Date: Wed, 13 Nov 2002 13:44:19 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE01C758DE@mvebe001.americas.nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kconfig (qconf): bug ?
Thread-Index: AcKIK5ZvEiFlY0FeTzSdrC9+HAkRNADMPXWw
From: <Rod.VanMeter@nokia.com>
To: <zippel@linux-m68k.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Nov 2002 21:44:20.0286 (UTC) FILETIME=[D2B175E0:01C28B5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so I'm a moron.

The first time I upgraded from 2.4 to 2.5.47, it took me half
an hour to figure out how to turn the PS/2 mouse back on
(serial I/O was off, so I couldn't see it.  Doh!).

But I figure I'm not the only moron on the planet, so here's
a patch that adds a help system.  Simplest, most brain-dead
implementation possible; all inline strings, no internationalization,
etc.  I figure it was worth an hour of my time to save some
other morons' hours.

			--Rod

P.S. Apologies if Lookout barfs on the long lines.  Crossing
my fingers...too embarrassing for words to be using it...
#@!$ Nokia IM...


diff -Naur a/qconf.cc b/qconf.cc
--- a/qconf.cc	2002-11-13 13:31:53.000000000 -0800
+++ b/qconf.cc	2002-11-13 13:32:19.000000000 -0800
@@ -711,6 +711,15 @@
 	  showDebugAction->setOn(showDebug);
 	  connect(showDebugAction, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
 
+	QAction *showIntroAction = new QAction(NULL, "Introduction to qconf", 0, this);
+	  connect(showIntroAction, SIGNAL(activated()), SLOT(showIntro()));
+
+	QAction *showLicenseAction = new QAction(NULL, "License", 0, this);
+	  connect(showLicenseAction, SIGNAL(activated()), SLOT(showLicense()));
+
+	QAction *showAboutAction = new QAction(NULL, "About", 0, this);
+	  connect(showAboutAction, SIGNAL(activated()), SLOT(showAbout()));
+
 	// init tool bar
 	backAction->addTo(toolBar);
 	toolBar->addSeparator();
@@ -740,6 +749,13 @@
 	showAllAction->addTo(optionMenu);
 	showDebugAction->addTo(optionMenu);
 
+	// create help menu
+	QPopupMenu* helpMenu = new QPopupMenu(this);
+	menu->insertItem("&Help", helpMenu);
+	showIntroAction->addTo(helpMenu);
+	showAboutAction->addTo(helpMenu);
+	showLicenseAction->addTo(helpMenu);
+
 	connect(configList, SIGNAL(menuSelected(struct menu *)),
 		SLOT(changeMenu(struct menu *)));
 	connect(configList, SIGNAL(parentSelected()),
@@ -1026,6 +1042,43 @@
 	configList->reinit();
 }
 
+void ConfigView::showIntro(void)
+{
+  char *str = "Welcome to the qconf graphical kernel configuration tool\n\
+for Linux.\n\
+\n\
+For each option, a blank box indicates the feature is disabled, a check\n\
+indicates it is enabled, and a dot indicates that it is to be compiled\n\
+as a module.  Clicking on the box will cycle through the three states.\n\
+\n\
+If you do not see an option (e.g., a device driver) that you believe\n\
+should be present, try turning on Show All Options under the Options menu.\n\
+Although there is no cross reference yet to help you figure out what other\n\
+options must be enabled to support the option you are interested in, you can\n\
+still view the help of a grayed-out option.\n\
+\n\
+Toggling Show Debug Info under the Options menu will show the dependencies,\n\
+which you can then match by examining other options.";
+
+  QMessageBox::information(this, "qconf", str);
+}
+
+void ConfigView::showLicense(void)
+{
+  char *str = "qconf is released under the terms of the GNU GPL v2.0.\n\
+For more information, please see the source code or visit\n\
+http://www.fsf.org/licenses/licenses.html";
+
+  QMessageBox::information(this, "qconf", str);
+}
+
+void ConfigView::showAbout(void)
+{
+  char *str = "qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.";
+
+  QMessageBox::information(this, "qconf", str);
+}
+
 /*
  * ask for saving configuration before quitting
  * TODO ask only when something changed
diff -Naur a/qconf.h b/qconf.h
--- a/qconf.h	2002-11-13 13:31:33.000000000 -0800
+++ b/qconf.h	2002-11-13 13:32:23.000000000 -0800
@@ -187,6 +187,9 @@
 	void setShowRange(bool);
 	void setShowName(bool);
 	void setShowData(bool);
+	void showIntro(void);
+	void showLicense(void);
+	void showAbout(void);
 
 protected:
 	void closeEvent(QCloseEvent *e);
