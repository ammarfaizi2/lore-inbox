Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSFOJZA>; Sat, 15 Jun 2002 05:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSFOJY7>; Sat, 15 Jun 2002 05:24:59 -0400
Received: from stingr.net ([212.193.32.15]:17289 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S315214AbSFOJY4>;
	Sat, 15 Jun 2002 05:24:56 -0400
Date: Sat, 15 Jun 2002 13:24:56 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Misc cleanups
Message-ID: <20020615092456.GC26527@stingr.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know I should'nt do this too :)

Some fixes to make gcc less complaining during the build process
one export symbol to make wan/comx.o happy

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.539  
#	drivers/char/ip2/i2ellis.h	1.2     -> 1.4    
#	    fs/proc/Makefile	1.2     -> 1.3    
#	drivers/char/mxser.c	1.10    -> 1.11   
#	        fs/dnotify.c	1.3     -> 1.4    
#	     fs/proc/inode.c	1.5     -> 1.6    
#	arch/i386/kernel/dmi_scan.c	1.21    -> 1.22   
#	drivers/char/tpqic02.c	1.8     -> 1.9    
#	      fs/namespace.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/12	stingray@boxster.stingr.net	1.538
# Misc. fixes
# --------------------------------------------
# 02/06/15	stingray@proxy.sgu.ru	1.539
# Another misc cleanups ...
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Sat Jun 15 13:20:28 2002
+++ b/arch/i386/kernel/dmi_scan.c	Sat Jun 15 13:20:28 2002
@@ -191,7 +191,8 @@
  *	rule needs to be improved to match specific BIOS revisions with
  *	corruption problems
  */ 
- 
+
+#if 0 
 static __init int disable_ide_dma(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_BLK_DEV_IDE
@@ -204,6 +205,7 @@
 #endif	
 	return 0;
 }
+#endif
 
 /* 
  * Reboot options and system auto-detection code provided by
diff -Nru a/drivers/char/ip2/i2ellis.h b/drivers/char/ip2/i2ellis.h
--- a/drivers/char/ip2/i2ellis.h	Sat Jun 15 13:20:28 2002
+++ b/drivers/char/ip2/i2ellis.h	Sat Jun 15 13:20:28 2002
@@ -568,6 +568,7 @@
 // the board again (step 1 not needed).
 
 static void iiEllisInit(void);
+static void iiEllisCleanup(void);
 static int iiSetAddress(i2eBordStrPtr, int, delayFunc_t );
 static int iiReset(i2eBordStrPtr);
 static int iiResetDelay(i2eBordStrPtr);
diff -Nru a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c	Sat Jun 15 13:20:28 2002
+++ b/drivers/char/mxser.c	Sat Jun 15 13:20:28 2002
@@ -653,7 +653,7 @@
 		n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
 		index = 0;
 		for (b = 0; b < n; b++) {
-			while (pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev)) 
+			while ((pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev)))
 			{
 				if (pci_enable_device(pdev))
 					continue;
diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Sat Jun 15 13:20:28 2002
+++ b/drivers/char/tpqic02.c	Sat Jun 15 13:20:28 2002
@@ -1815,7 +1815,6 @@
 static ssize_t qic02_tape_read(struct file *filp, char *buf, size_t count,
 			       loff_t * ppos)
 {
-	int err;
 	kdev_t dev = filp->f_dentry->d_inode->i_rdev;
 	unsigned short flags = filp->f_flags;
 	unsigned long bytes_todo, bytes_done, total_bytes_done = 0;
@@ -2009,7 +2008,6 @@
 static ssize_t qic02_tape_write(struct file *filp, const char *buf,
 				size_t count, loff_t * ppos)
 {
-	int err;
 	kdev_t dev = filp->f_dentry->d_inode->i_rdev;
 	unsigned short flags = filp->f_flags;
 	unsigned long bytes_todo, bytes_done, total_bytes_done = 0;
diff -Nru a/fs/dnotify.c b/fs/dnotify.c
--- a/fs/dnotify.c	Sat Jun 15 13:20:28 2002
+++ b/fs/dnotify.c	Sat Jun 15 13:20:28 2002
@@ -135,7 +135,6 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-out:
 	write_unlock(&dn_lock);
 }
 
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Sat Jun 15 13:20:28 2002
+++ b/fs/namespace.c	Sat Jun 15 13:20:28 2002
@@ -21,6 +21,8 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 
+extern int init_rootfs(void);
+
 struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
 int do_remount_sb(struct super_block *sb, int flags, void * data);
 void kill_super(struct super_block *sb);
diff -Nru a/fs/proc/Makefile b/fs/proc/Makefile
--- a/fs/proc/Makefile	Sat Jun 15 13:20:28 2002
+++ b/fs/proc/Makefile	Sat Jun 15 13:20:28 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := proc.o
 
-export-objs := root.o
+export-objs := root.o inode.o
 
 obj-y    := inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o kcore.o
diff -Nru a/fs/proc/inode.c b/fs/proc/inode.c
--- a/fs/proc/inode.c	Sat Jun 15 13:20:28 2002
+++ b/fs/proc/inode.c	Sat Jun 15 13:20:28 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
@@ -174,7 +175,9 @@
 out_fail:
 	de_put(de);
 	goto out;
-}			
+}
+
+EXPORT_SYMBOL(proc_get_inode);
 
 struct super_block *proc_read_super(struct super_block *s,void *data, 
 				    int silent)


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
