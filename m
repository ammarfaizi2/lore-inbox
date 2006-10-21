Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWJUJ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWJUJ6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 05:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422627AbWJUJ6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 05:58:04 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:49488 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030385AbWJUJ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 05:58:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ls09TJXNyKDO7rwBhl1buqe4fKVXQFWGVpBvqzCrnF/Ivu0LCFKWV1W1YC+LZM1tOvXBanwX5SB/QRrgBuWjaiGG4G9dkHwAU77/Gjj1re3q50OHafM1Ax+zaveqCRtJyWh6Q9YKGgyrd+cKiq9pMD/xI4QjQIsde5aFDjLCAgY=
Message-ID: <e5bfff550610210258x2f69fda2y9aab6167a5f54797@mail.gmail.com>
Date: Sat, 21 Oct 2006 11:58:01 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: sam@ravnborg.org
Subject: [PATCH] kconfig: sync main view with search dialog current menu
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When changing current menu in search dialog update also main view

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 scripts/kconfig/qconf.cc |    5 ++++-
 scripts/kconfig/qconf.h  |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 393f374..eec81b0 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1176,7 +1176,7 @@ void ConfigInfoView::contentsContextMenu
 	Parent::contentsContextMenuEvent(e);
 }

-ConfigSearchWindow::ConfigSearchWindow(QWidget* parent, const char *name)
+ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow* parent,
const char *name)
 	: Parent(parent, name), result(NULL)
 {
 	setCaption("Search Config");
@@ -1200,6 +1200,9 @@ ConfigSearchWindow::ConfigSearchWindow(Q
 	info = new ConfigInfoView(split, name);
 	connect(list->list, SIGNAL(menuChanged(struct menu *)),
 		info, SLOT(setInfo(struct menu *)));
+	connect(list->list, SIGNAL(menuChanged(struct menu *)),
+		parent, SLOT(setMenuLink(struct menu *)));
+
 	layout1->addWidget(split);

 	if (name) {
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 6a9e3b1..8d11f3c 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -279,7 +279,7 @@ class ConfigSearchWindow : public QDialo
 	Q_OBJECT
 	typedef class QDialog Parent;
 public:
-	ConfigSearchWindow(QWidget* parent, const char *name = 0);
+	ConfigSearchWindow(ConfigMainWindow* parent, const char *name = 0);

 public slots:
 	void saveSettings(void);
-- 
1.4.3.ge193
