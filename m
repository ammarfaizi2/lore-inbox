Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWJERND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWJERND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWJERNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:13:02 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:47203 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751421AbWJERNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:13:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SzJ/fEmkk2GrqeNZsB3AmbTMZ0BqEojTJbxGRDgB1VQ/WS/65xPZRIUC5lwbQOLO4WLOXgml7YqQZtvMMDo97Jnw8pEVrocbTk2iiJDOnNSrj0yk0sSKSM5Faq1uFvNq57x1xbXAOA7seCZqNM1KM/8hX/xisaxNeA2ikmQ34IA=
Message-ID: <e5bfff550610051012r659089f3ofec6aedb7be05e02@mail.gmail.com>
Date: Thu, 5 Oct 2006 19:12:59 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: sam@ravnborg.org, zippel@linux-m68k.org
Subject: [PATCH 0/1] kconfig: sync main view with search dialog current menu
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

I've found handy this 'jump to context behaviour.

Please consider for applying.

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
1.4.2.1.gbc1a5
