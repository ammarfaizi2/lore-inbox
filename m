Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293738AbSCKNqD>; Mon, 11 Mar 2002 08:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293735AbSCKNpx>; Mon, 11 Mar 2002 08:45:53 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21511 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293742AbSCKNpo>; Mon, 11 Mar 2002 08:45:44 -0500
Message-Id: <200203111343.g2BDhRq05326@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 devfs 
Date: Mon, 11 Mar 2002 15:42:40 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
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

diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/fs/devfs/base.c 
linux-new/fs/devfs/base.c
--- linux-2.4.19-pre2/fs/devfs/base.c	Mon Feb 25 17:38:08 2002
+++ linux-new/fs/devfs/base.c	Mon Mar 11 10:26:25 2002
@@ -3463,18 +3463,17 @@
 static int __init init_devfs_fs (void)
 {
     int err;
-
-    printk ("%s: v%s Richard Gooch (rgooch@atnf.csiro.au)\n",
-	    DEVFS_NAME, DEVFS_VERSION);
+    printk (KERN_INFO DEVFS_NAME ": v" DEVFS_VERSION
+            " Richard Gooch (rgooch@atnf.csiro.au)\n");
     devfsd_buf_cache = kmem_cache_create ("devfsd_event",
 					  sizeof (struct devfsd_buf_entry),
 					  0, 0, NULL, NULL);
     if (!devfsd_buf_cache) OOPS ("(): unable to allocate event slab\n");
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
