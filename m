Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbSLTWgt>; Fri, 20 Dec 2002 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSLTWgt>; Fri, 20 Dec 2002 17:36:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29959 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266274AbSLTWgs>;
	Fri, 20 Dec 2002 17:36:48 -0500
Date: Fri, 20 Dec 2002 14:41:49 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] allow dm-ioctl.ko to be used
Message-ID: <20021220224148.GA13612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess no one runs the dm code as a module :)

Here's a small patch that allows dm-ioctl.ko to be loaded.  It is
against the latest 2.5.52-bk tree.  Joe, please add this to the next set
of patches you send out.

thanks,

greg k-h


===== drivers/md/Makefile 1.10 vs edited =====
--- 1.10/drivers/md/Makefile	Sat Dec 14 04:38:56 2002
+++ edited/drivers/md/Makefile	Fri Dec 20 14:35:41 2002
@@ -2,7 +2,7 @@
 # Makefile for the kernel software RAID and LVM drivers.
 #
 
-export-objs	:= md.o xor.o dm-table.o dm-target.o
+export-objs	:= md.o xor.o dm-table.o dm-target.o dm.o
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o
 
===== drivers/md/dm-table.c 1.5 vs edited =====
--- 1.5/drivers/md/dm-table.c	Mon Dec 16 01:40:44 2002
+++ edited/drivers/md/dm-table.c	Fri Dec 20 14:35:28 2002
@@ -752,3 +752,11 @@
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
 EXPORT_SYMBOL(dm_table_event);
+EXPORT_SYMBOL(dm_table_add_target);
+EXPORT_SYMBOL(dm_table_complete);
+EXPORT_SYMBOL(dm_table_get_num_targets);
+EXPORT_SYMBOL(dm_table_put);
+EXPORT_SYMBOL(dm_table_create);
+EXPORT_SYMBOL(dm_table_get_target);
+EXPORT_SYMBOL(dm_table_get_devices);
+EXPORT_SYMBOL(dm_table_add_wait_queue);
===== drivers/md/dm.c 1.14 vs edited =====
--- 1.14/drivers/md/dm.c	Mon Dec 16 01:42:31 2002
+++ edited/drivers/md/dm.c	Fri Dec 20 14:35:28 2002
@@ -863,3 +863,13 @@
 MODULE_DESCRIPTION(DM_NAME " driver");
 MODULE_AUTHOR("Joe Thornber <thornber@sistina.com>");
 MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(dm_create);
+EXPORT_SYMBOL(dm_get);
+EXPORT_SYMBOL(dm_put);
+EXPORT_SYMBOL(dm_disk);
+EXPORT_SYMBOL(dm_get_table);
+EXPORT_SYMBOL(dm_suspended);
+EXPORT_SYMBOL(dm_suspend);
+EXPORT_SYMBOL(dm_resume);
+EXPORT_SYMBOL(dm_swap_table);
