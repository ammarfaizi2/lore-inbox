Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161437AbWI2Gdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbWI2Gdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161442AbWI2Gdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:33:38 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:1687 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161437AbWI2Gdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:33:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:User-Agent:Cc:MIME-Version:Content-Disposition:Date:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=qPRZ+w2vC4+s8mKBrUt9VfPZlAQUm9TxOu1bnjNwl7508ci5f2ZnjmPI1sdpJMmsmFG14DvjFbTdp/avT3b1IftDBETdbOR/8RYRGiooxauTBdWo00yDWwte+5GDeFGsRUtxyAPguMBg9NQHQtmjhhcEAEDNhJhAL2YLeyxxcyI=  ;
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.18-git] RTC class uses subsys_init
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 28 Sep 2006 23:33:33 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200609282333.34224.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RESEND] 

This makes RTC core components use "subsys_init" instead of "module_init",
as appropriate for subsystem infrastructure.  This is mostly useful for
statically linking drivers in other parts of the tree that may provide an
RTC interface as a secondary functionality (e.g. part of a multifunction
chip); they won't need to worry so much about drivers/Makefile link order.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: linux/drivers/rtc/class.c
===================================================================
--- linux.orig/drivers/rtc/class.c	2006-07-30 16:08:47.000000000 -0700
+++ linux/drivers/rtc/class.c	2006-07-30 16:15:50.000000000 -0700
@@ -142,9 +142,9 @@
 	class_destroy(rtc_class);
 }
 
-module_init(rtc_init);
+subsys_initcall(rtc_init);
 module_exit(rtc_exit);
 
-MODULE_AUTHOR("Alessandro Zummo <a.zummo@towerteh.it>");
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("RTC class support");
 MODULE_LICENSE("GPL");
Index: linux/drivers/rtc/rtc-dev.c
===================================================================
--- linux.orig/drivers/rtc/rtc-dev.c	2006-07-30 16:08:47.000000000 -0700
+++ linux/drivers/rtc/rtc-dev.c	2006-07-30 16:15:50.000000000 -0700
@@ -496,7 +496,7 @@
 	unregister_chrdev_region(rtc_devt, RTC_DEV_MAX);
 }
 
-module_init(rtc_dev_init);
+subsys_initcall(rtc_dev_init);
 module_exit(rtc_dev_exit);
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
Index: linux/drivers/rtc/rtc-proc.c
===================================================================
--- linux.orig/drivers/rtc/rtc-proc.c	2006-07-30 16:08:47.000000000 -0700
+++ linux/drivers/rtc/rtc-proc.c	2006-07-30 16:15:50.000000000 -0700
@@ -156,7 +156,7 @@
 	class_interface_unregister(&rtc_proc_interface);
 }
 
-module_init(rtc_proc_init);
+subsys_initcall(rtc_proc_init);
 module_exit(rtc_proc_exit);
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
Index: linux/drivers/rtc/rtc-sysfs.c
===================================================================
--- linux.orig/drivers/rtc/rtc-sysfs.c	2006-07-30 16:08:47.000000000 -0700
+++ linux/drivers/rtc/rtc-sysfs.c	2006-07-30 16:15:50.000000000 -0700
@@ -116,7 +116,7 @@
 	class_interface_unregister(&rtc_sysfs_interface);
 }
 
-module_init(rtc_sysfs_init);
+subsys_init(rtc_sysfs_init);
 module_exit(rtc_sysfs_exit);
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
