Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSF2Pkg>; Sat, 29 Jun 2002 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSF2Pkf>; Sat, 29 Jun 2002 11:40:35 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:1291 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S313087AbSF2Pka>; Sat, 29 Jun 2002 11:40:30 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the broken filesystems by cont_prepare_write() change
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 30 Jun 2002 00:42:45 +0900
Message-ID: <878z4y3xca.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes broken adfs/affs/hfs/hpfs/qnx4 by cont_prepare_write()
change.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_big-file-2.5.24/include/linux/adfs_fs_i.h mmu_private-fix-2.5.24/include/linux/adfs_fs_i.h
--- fat_big-file-2.5.24/include/linux/adfs_fs_i.h	Sun Jun 23 15:32:04 2002
+++ mmu_private-fix-2.5.24/include/linux/adfs_fs_i.h	Sun Jun 23 15:38:29 2002
@@ -11,7 +11,7 @@
  * adfs file system inode data in memory
  */
 struct adfs_inode_info {
-	unsigned long	mmu_private;
+	loff_t		mmu_private;
 	unsigned long	parent_id;	/* object id of parent		*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
diff -urN fat_big-file-2.5.24/include/linux/affs_fs_i.h mmu_private-fix-2.5.24/include/linux/affs_fs_i.h
--- fat_big-file-2.5.24/include/linux/affs_fs_i.h	Sun Jun 23 15:32:04 2002
+++ mmu_private-fix-2.5.24/include/linux/affs_fs_i.h	Sun Jun 23 15:38:29 2002
@@ -35,7 +35,7 @@
 	struct affs_ext_key *i_ac;		/* associative cache of extended blocks */
 	u32	 i_ext_last;			/* last accessed extended block */
 	struct buffer_head *i_ext_bh;		/* bh of last extended block */
-	unsigned long mmu_private;
+	loff_t	 mmu_private;
 	u32	 i_protect;			/* unused attribute bits */
 	u32	 i_lastalloc;			/* last allocated block */
 	int	 i_pa_cnt;			/* number of preallocated blocks */
diff -urN fat_big-file-2.5.24/include/linux/hfs_fs_i.h mmu_private-fix-2.5.24/include/linux/hfs_fs_i.h
--- fat_big-file-2.5.24/include/linux/hfs_fs_i.h	Sun Jun 23 15:32:05 2002
+++ mmu_private-fix-2.5.24/include/linux/hfs_fs_i.h	Sun Jun 23 15:38:30 2002
@@ -19,7 +19,7 @@
 struct hfs_inode_info {
 	int				magic;     /* A magic number */
 
-	unsigned long			mmu_private;
+	loff_t				mmu_private;
 	struct hfs_cat_entry		*entry;
 
 	/* For a regular or header file */
diff -urN fat_big-file-2.5.24/include/linux/hpfs_fs_i.h mmu_private-fix-2.5.24/include/linux/hpfs_fs_i.h
--- fat_big-file-2.5.24/include/linux/hpfs_fs_i.h	Sun Jun 23 15:32:05 2002
+++ mmu_private-fix-2.5.24/include/linux/hpfs_fs_i.h	Sun Jun 23 15:38:30 2002
@@ -2,7 +2,7 @@
 #define _HPFS_FS_I
 
 struct hpfs_inode_info {
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	ino_t i_parent_dir;	/* (directories) gives fnode of parent dir */
 	unsigned i_dno;		/* (directories) root dnode */
 	unsigned i_dpos;	/* (directories) temp for readdir */
diff -urN fat_big-file-2.5.24/include/linux/qnx4_fs.h mmu_private-fix-2.5.24/include/linux/qnx4_fs.h
--- fat_big-file-2.5.24/include/linux/qnx4_fs.h	Sun Jun 23 15:32:06 2002
+++ mmu_private-fix-2.5.24/include/linux/qnx4_fs.h	Sun Jun 23 15:38:31 2002
@@ -106,7 +106,7 @@
 
 struct qnx4_inode_info {
 	struct qnx4_inode_entry raw;
-	unsigned long mmu_private;
+	loff_t mmu_private;
 	struct inode vfs_inode;
 };
 
