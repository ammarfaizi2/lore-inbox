Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSA1VWM>; Mon, 28 Jan 2002 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSA1VWD>; Mon, 28 Jan 2002 16:22:03 -0500
Received: from [195.66.192.167] ([195.66.192.167]:23052 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286188AbSA1VVw>; Mon, 28 Jan 2002 16:21:52 -0500
Message-Id: <200201282120.g0SLKUE24961@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
Date: Mon, 28 Jan 2002 23:20:32 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200201280750.g0S7oGE21742@Port.imtp.ilyichevsk.odessa.ua> <200201281644.g0SGij202269@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200201281644.g0SGij202269@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --recursive -u linux-2.4.13-orig/fs/devfs/base.c
> > linux-2.4.13-new/fs/devfs/base.c
>
> This patch won't even remotely apply to 2.4.18-pre7. Please don't
> submit patches which were generated against old kernels unless you've
> verified that they apply to the latest kernel.

Didn't try but I'm sure you're right :-)

Diff against 2.4.18-pre6 will be attached as soon as diff will finish
(it's over NFS).

I changed "none" to "devfs" in do_mount("none", "/dev", "devfs", 0, ""):
"none is busy" is misleading at umount time :-)

Aha, it's ready!
--
vda


diff -u --recursive linux-2.4.18-pre6mhv_ll/fs/devfs/base.c 
linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c
--- linux-2.4.18-pre6mhv_ll/fs/devfs/base.c     Fri Jan 25 15:49:53 2002
+++ linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c       Mon Jan 28 23:05:44 
2002
@@ -3464,17 +3464,16 @@
 {
     int err;

-    printk ("%s: v%s Richard Gooch (rgooch@atnf.csiro.au)\n",
-           DEVFS_NAME, DEVFS_VERSION);
+    printk (KERN_INFO DEVFS_NAME ": v" DEVFS_VERSION " Richard Gooch 
(rgooch@atnf.csiro.au)\n");
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
@@ -3490,8 +3489,8 @@
     int err;

     if ( !(boot_options & OPTION_MOUNT) ) return;
-    err = do_mount ("none", "/dev", "devfs", 0, "");
-    if (err == 0) printk ("Mounted devfs on /dev\n");
+    err = do_mount ("devfs", "/dev", "devfs", 0, "");
+    if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
     else printk ("Warning: unable to mount devfs, err: %d\n", err);
 }   /*  End Function mount_devfs_fs  */
