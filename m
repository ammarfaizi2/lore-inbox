Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289135AbSA1H4A>; Mon, 28 Jan 2002 02:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288668AbSA1Hzu>; Mon, 28 Jan 2002 02:55:50 -0500
Received: from [195.66.192.167] ([195.66.192.167]:51207 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288288AbSA1Hze>; Mon, 28 Jan 2002 02:55:34 -0500
Message-Id: <200201280750.g0S7oGE21742@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: [PATCH] KERN_INFO for devfs
Date: Mon, 28 Jan 2002 09:50:18 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for devfs.
--
vda

diff --recursive -u linux-2.4.13-orig/fs/devfs/base.c linux-2.4.13-new/fs/devfs/base.c
--- linux-2.4.13-orig/fs/devfs/base.c	Thu Oct 11 04:23:24 2001
+++ linux-2.4.13-new/fs/devfs/base.c	Thu Nov  8 23:42:11 2001
@@ -3289,13 +3289,13 @@
 {
     int err;

-    printk ("%s: v%s Richard Gooch (rgooch@atnf.csiro.au)\n",
-	    DEVFS_NAME, DEVFS_VERSION);
+    printk (KERN_INFO DEVFS_NAME ": v" DEVFS_VERSION
+	" Richard Gooch (rgooch@atnf.csiro.au)\n");
 #ifdef CONFIG_DEVFS_DEBUG
     devfs_debug = devfs_debug_init;
-    printk ("%s: devfs_debug: 0x%0x\n", DEVFS_NAME, devfs_debug);
+    printk (KERN_INFO DEVFS_NAME ": devfs_debug: 0x%0x\n", devfs_debug);
 #endif
-    printk ("%s: boot_options: 0x%0x\n", DEVFS_NAME, boot_options);
+    printk (KERN_INFO DEVFS_NAME ": boot_options: 0x%0x\n", boot_options);
     err = register_filesystem (&devfs_fs_type);
     if (!err)
     {
