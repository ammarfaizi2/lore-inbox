Return-Path: <linux-kernel-owner+w=401wt.eu-S1030437AbXAKOJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbXAKOJh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbXAKOJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:09:37 -0500
Received: from sa6.bezeqint.net ([192.115.104.20]:46107 "EHLO sa6.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030437AbXAKOJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:09:36 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc4] qconf Reloate Search Command
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Date: Thu, 11 Jan 2007 16:04:09 +0200
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZPkpF4MwIxfJble"
Message-Id: <200701111604.09343.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ZPkpF4MwIxfJble
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!

[ I'm not subscribed to this list so please CC me on your replies. ]

This is a patch that relocates the qconf search command to the "Edit"->"Find" 
menu option.

This is per the discussion on my qconf search dialog patch.

The patch was tested against kernel 2.6.20-rc4.

Enjoy!

Regards,

	Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

Chuck Norris wrote a complete Perl 6 implementation in a day but then
destroyed all evidence with his bare hands, so no one will know his secrets.

--Boundary-00=_ZPkpF4MwIxfJble
Content-Type: text/x-diff;
  charset="us-ascii";
  name="relocate-search-02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="relocate-search-02.diff"

--- linux-2.6.20-rc4/scripts/kconfig/qconf.cc.orig	2007-01-11 15:51:29.232975750 +0200
+++ linux-2.6.20-rc4/scripts/kconfig/qconf.cc	2007-01-11 16:01:02.897667032 +0200
@@ -1323,7 +1323,7 @@
 	conf_changed();
 	QAction *saveAsAction = new QAction("Save As...", "Save &As...", 0, this);
 	  connect(saveAsAction, SIGNAL(activated()), SLOT(saveConfigAs()));
-	QAction *searchAction = new QAction("Search", "&Search", CTRL+Key_F, this);
+	QAction *searchAction = new QAction("Find", "&Find", CTRL+Key_F, this);
 	  connect(searchAction, SIGNAL(activated()), SLOT(searchConfig()));
 	QAction *singleViewAction = new QAction("Single View", QPixmap(xpm_single_view), "Split View", 0, this);
 	  connect(singleViewAction, SIGNAL(activated()), SLOT(showSingleView()));
@@ -1380,10 +1380,13 @@
 	saveAction->addTo(config);
 	saveAsAction->addTo(config);
 	config->insertSeparator();
-	searchAction->addTo(config);
-	config->insertSeparator();
 	quitAction->addTo(config);
 
+	// create edit menu
+	QPopupMenu* editMenu = new QPopupMenu(this);
+	menu->insertItem("&Edit", editMenu);
+	searchAction->addTo(editMenu);
+
 	// create options menu
 	QPopupMenu* optionMenu = new QPopupMenu(this);
 	menu->insertItem("&Option", optionMenu);

--Boundary-00=_ZPkpF4MwIxfJble--
