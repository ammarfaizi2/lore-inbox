Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVAHHpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVAHHpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVAHHo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:44:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:47493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261870AbVAHFsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:18 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163262985@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <110516326283@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.29, 2004/12/21 22:40:34-08:00, greg@kroah.com

sysfs: export the /sys/kernel subsystem for people to use.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject.h |    2 ++
 kernel/ksysfs.c         |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2005-01-07 15:40:24 -08:00
+++ b/include/linux/kobject.h	2005-01-07 15:40:24 -08:00
@@ -167,6 +167,8 @@
 	} \
 }
 
+/* The global /sys/kernel/ subsystem for people to chain off of */
+extern struct subsystem kernel_subsys;
 
 /**
  * Helpers for setting the kset of registered objects.
diff -Nru a/kernel/ksysfs.c b/kernel/ksysfs.c
--- a/kernel/ksysfs.c	2005-01-07 15:40:24 -08:00
+++ b/kernel/ksysfs.c	2005-01-07 15:40:24 -08:00
@@ -30,7 +30,8 @@
 KERNEL_ATTR_RO(hotplug_seqnum);
 #endif
 
-static decl_subsys(kernel, NULL, NULL);
+decl_subsys(kernel, NULL, NULL);
+EXPORT_SYMBOL_GPL(kernel_subsys);
 
 static struct attribute * kernel_attrs[] = {
 #ifdef CONFIG_HOTPLUG

