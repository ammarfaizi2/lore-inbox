Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270535AbTGSUoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270537AbTGSUoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:44:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6414 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270535AbTGSUoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:44:15 -0400
Date: Sat, 19 Jul 2003 22:59:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ Makefile cleanup
Message-ID: <20030719205911.GC12080@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please apply.

Simplify Makefiles in fs/ by utilising the new syntax for composite
objects. The new syntax allowed a couple of ifeq ($(CONFIG_FOO),y)
to be deleted, resulting in more readable Makefiles.

No functional changes introduced.

	Sam

 devpts/Makefile |   12 +++---------
 ext2/Makefile   |   18 +++++-------------
 ext3/Makefile   |   18 +++++-------------
 jfs/Makefile    |    6 ++----
 ncpfs/Makefile  |   11 ++++-------
 proc/Makefile   |   15 +++++----------
 6 files changed, 24 insertions(+), 56 deletions(-)

===== fs/devpts/Makefile 1.5 vs edited =====
--- 1.5/fs/devpts/Makefile	Sun May 25 23:08:03 2003
+++ edited/fs/devpts/Makefile	Sat Jul 19 21:24:33 2003
@@ -4,12 +4,6 @@
 
 obj-$(CONFIG_DEVPTS_FS) += devpts.o
 
-devpts-objs := inode.o
-
-ifeq ($(CONFIG_DEVPTS_FS_XATTR),y)
-devpts-objs += xattr.o 
-endif
-
-ifeq ($(CONFIG_DEVPTS_FS_SECURITY),y)
-devpts-objs += xattr_security.o
-endif
+devpts-y := inode.o
+devpts-$(CONFIG_DEVPTS_FS_XATTR)	+= xattr.o 
+devpts-$(CONFIG_DEVPTS_FS_SECURITY)	+= xattr_security.o
===== fs/ext2/Makefile 1.9 vs edited =====
--- 1.9/fs/ext2/Makefile	Mon May  5 15:19:21 2003
+++ edited/fs/ext2/Makefile	Sat Jul 19 21:53:59 2003
@@ -4,17 +4,9 @@
 
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
-ext2-objs := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
-	     ioctl.o namei.o super.o symlink.o
+ext2-y := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
+	  ioctl.o namei.o super.o symlink.o
 
-ifeq ($(CONFIG_EXT2_FS_XATTR),y)
-ext2-objs += xattr.o xattr_user.o xattr_trusted.o
-endif
-
-ifeq ($(CONFIG_EXT2_FS_POSIX_ACL),y)
-ext2-objs += acl.o
-endif
-
-ifeq ($(CONFIG_EXT2_FS_SECURITY),y)
-ext2-objs += xattr_security.o
-endif
+ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
+ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
+ext2-$(CONFIG_EXT2_FS_SECURITY)	 += xattr_security.o
===== fs/ext3/Makefile 1.10 vs edited =====
--- 1.10/fs/ext3/Makefile	Mon May  5 15:18:48 2003
+++ edited/fs/ext3/Makefile	Sat Jul 19 21:44:01 2003
@@ -4,17 +4,9 @@
 
 obj-$(CONFIG_EXT3_FS) += ext3.o
 
-ext3-objs    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
-		ioctl.o namei.o super.o symlink.o hash.o
+ext3-y	:= balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
+	   ioctl.o namei.o super.o symlink.o hash.o
 
-ifeq ($(CONFIG_EXT3_FS_XATTR),y)
-ext3-objs += xattr.o xattr_user.o xattr_trusted.o
-endif
-
-ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
-ext3-objs += acl.o
-endif
-
-ifeq ($(CONFIG_EXT3_FS_SECURITY),y)
-ext3-objs += xattr_security.o
-endif
+ext3-$(CONFIG_EXT3_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
+ext3-$(CONFIG_EXT3_FS_POSIX_ACL) += acl.o
+ext3-$(CONFIG_EXT3_FS_SECURITY)	 += xattr_security.o
===== fs/jfs/Makefile 1.6 vs edited =====
--- 1.6/fs/jfs/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/fs/jfs/Makefile	Sat Jul 19 21:44:41 2003
@@ -4,14 +4,12 @@
 
 obj-$(CONFIG_JFS_FS) += jfs.o
 
-jfs-objs := super.o file.o inode.o namei.o jfs_mount.o jfs_umount.o \
+jfs-y    := super.o file.o inode.o namei.o jfs_mount.o jfs_umount.o \
 	    jfs_xtree.o jfs_imap.o jfs_debug.o jfs_dmap.o \
 	    jfs_unicode.o jfs_dtree.o jfs_inode.o \
 	    jfs_extent.o symlink.o jfs_metapage.o \
 	    jfs_logmgr.o jfs_txnmgr.o jfs_uniupr.o resize.o xattr.o
 
-ifeq ($(CONFIG_JFS_POSIX_ACL),y)
-jfs-objs += acl.o
-endif
+jfs-$(CONFIG_JFS_POSIX_ACL) += acl.o
 
 EXTRA_CFLAGS += -D_JFS_4K
===== fs/ncpfs/Makefile 1.5 vs edited =====
--- 1.5/fs/ncpfs/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/fs/ncpfs/Makefile	Sat Jul 19 21:54:59 2003
@@ -4,14 +4,11 @@
 
 obj-$(CONFIG_NCP_FS) += ncpfs.o
 
-ncpfs-objs   := dir.o file.o inode.o ioctl.o mmap.o ncplib_kernel.o sock.o \
+ncpfs-y      := dir.o file.o inode.o ioctl.o mmap.o ncplib_kernel.o sock.o \
 		ncpsign_kernel.o getopt.o
-ifeq ($(CONFIG_NCPFS_EXTRAS),y)
-ncpfs-objs   += symlink.o
-endif
-ifeq ($(CONFIG_NCPFS_NFS_NS),y)
-ncpfs-objs   += symlink.o
-endif
+
+ncpfs-$(CONFIG_NCPFS_EXTRAS)   += symlink.o
+ncpfs-$(CONFIG_NCPFS_NFS_NS)   += symlink.o
 
 # If you want debugging output, please uncomment the following line
 # EXTRA_CFLAGS += -DDEBUG_NCP=1
===== fs/proc/Makefile 1.6 vs edited =====
--- 1.6/fs/proc/Makefile	Mon Feb  3 23:19:38 2003
+++ edited/fs/proc/Makefile	Sat Jul 19 21:51:34 2003
@@ -4,15 +4,10 @@
 
 obj-$(CONFIG_PROC_FS) += proc.o
 
-proc-objs    := inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o kcore.o
+proc-y			:= task_nommu.o
+proc-$(CONFIG_MMU)	:= task_mmu.o
 
-ifeq ($(CONFIG_MMU),y)
-proc-objs    += task_mmu.o
-else
-proc-objs    += task_nommu.o
-endif
+proc-y       += inode.o root.o base.o generic.o array.o \
+		kmsg.o proc_tty.o proc_misc.o kcore.o
 
-ifeq ($(CONFIG_PROC_DEVICETREE),y)
-proc-objs    += proc_devtree.o
-endif
+proc-$(CONFIG_PROC_DEVICETREE)    += proc_devtree.o
