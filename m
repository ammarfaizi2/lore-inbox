Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUIPK7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUIPK7D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUIPK5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:57:46 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:38615 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267904AbUIPK5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:57:21 -0400
Subject: [PATCH] Suspend2 Merge: Driver model patches 2/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095332331.3855.161.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 20:58:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This simple helper adds support for finding a class given its name. I
use this to locate the frame buffer drivers and move them to the
keep-alive tree while suspending other drivers.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/drivers/base/class.c software-suspend-linux-2.6.9-rc1-rev3/drivers/base/class.c
--- linux-2.6.9-rc1/drivers/base/class.c	2004-09-07 21:58:30.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/base/class.c	2004-09-09 19:36:24.000000000 +1000
@@ -460,6 +460,20 @@
 	kobject_put(&class_dev->kobj);
 }
 
+struct class * class_find(char * name)
+{
+	struct class * this_class;
+
+	if (!name)
+		return NULL;
+
+	list_for_each_entry(this_class, &class_subsys.kset.list, subsys.kset.kobj.entry) {
+		if (!(strcmp(this_class->name, name)))
+			return this_class;
+	}
+
+	return NULL;
+}
 
 int class_interface_register(struct class_interface *class_intf)
 {
@@ -542,3 +556,5 @@
 
 EXPORT_SYMBOL(class_interface_register);
 EXPORT_SYMBOL(class_interface_unregister);
+
+EXPORT_SYMBOL(class_find);
diff -ruN linux-2.6.9-rc1/include/linux/device.h software-suspend-linux-2.6.9-rc1-rev3/include/linux/device.h
--- linux-2.6.9-rc1/include/linux/device.h	2004-09-07 21:58:59.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/include/linux/device.h	2004-09-09 19:36:24.000000000 +1000
@@ -163,6 +163,7 @@
 
 extern struct class * class_get(struct class *);
 extern void class_put(struct class *);
+extern struct class * class_find(char * name);
 
 
 struct class_attribute {

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

