Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVL3B7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVL3B7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVL3B7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:59:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750757AbVL3B7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:59:19 -0500
Date: Thu, 29 Dec 2005 20:59:08 -0500
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix gcc4.1 build failure on xconfig
Message-ID: <20051230015908.GA19635@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/kconfig/qconf.h:25: error: extra qualification ‘ConfigSettings::’ on member ‘readSizes’
scripts/kconfig/qconf.h:26: error: extra qualification ‘ConfigSettings::’ on member ‘writeSizes’
scripts/kconfig/qconf.h:127: error: extra qualification ‘ConfigList::’ on member ‘updateMenuList’

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/scripts/kconfig/qconf.h~	2005-12-29 20:57:36.000000000 -0500
+++ linux-2.6/scripts/kconfig/qconf.h	2005-12-29 20:57:55.000000000 -0500
@@ -22,8 +22,8 @@ public:
 
 #if QT_VERSION >= 300
 	void readListSettings();
-	QValueList<int> ConfigSettings::readSizes(const QString& key, bool *ok);
-	bool ConfigSettings::writeSizes(const QString& key, const QValueList<int>& value);
+	QValueList<int> readSizes(const QString& key, bool *ok);
+	bool writeSizes(const QString& key, const QValueList<int>& value);
 #endif
 
 	bool showAll;
@@ -124,7 +124,7 @@ public:
 	void setParentMenu(void);
 
 	template <class P>
-	void ConfigList::updateMenuList(P*, struct menu*);
+	void updateMenuList(P*, struct menu*);
 
 	bool updateAll;
 
