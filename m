Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVAQRkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVAQRkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAQRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:40:10 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:57096 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262358AbVAQRjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:39:31 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/13] FAT: kill fatfs_syms.c
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:39:13 +0900
Message-ID: <87pt04oszi.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 1~13 patches is including the "Lindent" cleanup, size is bit
big.  However these are trivial changes.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



The patch below removes fatfs_syms.c

All EXPORT_SYMBOL's are moved to the files where the actual functions 
are.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/Makefile     |    2 +-
 fs/fat/dir.c        |   11 +++++++++++
 fs/fat/inode.c      |   34 ++++++++++++++++++++++++++++++++++
 fs/fat/misc.c       |    4 ++++
 fs/fat/fatfs_syms.c |   48 ------------------------------------------------
 5 files changed, 50 insertions(+), 49 deletions(-)

diff -puN fs/fat/Makefile~fat_export-cleanup fs/fat/Makefile
--- linux-2.6.10/fs/fat/Makefile~fat_export-cleanup	2005-01-08 09:07:36.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/Makefile	2005-01-08 09:07:37.000000000 +0900
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := cache.o dir.o file.o inode.o misc.o fatfs_syms.o
+fat-objs := cache.o dir.o file.o inode.o misc.o
diff -puN fs/fat/dir.c~fat_export-cleanup fs/fat/dir.c
--- linux-2.6.10/fs/fat/dir.c~fat_export-cleanup	2005-01-08 09:07:37.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/dir.c	2005-01-08 09:07:37.000000000 +0900
@@ -13,6 +13,7 @@
  *  Short name translation 1999, 2001 by Wolfram Pienkoss <wp@bszh.de>
  */
 
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
@@ -335,6 +336,8 @@ struct fat_ioctl_filldir_callback {
 	int short_len;
 };
 
+EXPORT_SYMBOL(fat_search_long);
+
 static int fat_readdirx(struct inode *inode, struct file *filp, void *dirent,
 			filldir_t filldir, int short_only, int both)
 {
@@ -732,6 +735,8 @@ int fat_add_entries(struct inode *dir,in
 	return offset;
 }
 
+EXPORT_SYMBOL(fat_add_entries);
+
 int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat)
 {
 	struct buffer_head *bh;
@@ -767,6 +772,8 @@ int fat_new_dir(struct inode *dir, struc
 	return 0;
 }
 
+EXPORT_SYMBOL(fat_new_dir);
+
 static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de, loff_t *i_pos)
@@ -800,6 +807,8 @@ int fat_dir_empty(struct inode *dir)
 	return result;
 }
 
+EXPORT_SYMBOL(fat_dir_empty);
+
 /*
  * fat_subdirs counts the number of sub-directories of dir. It can be run
  * on directories being created.
@@ -839,3 +848,5 @@ int fat_scan(struct inode *dir, const un
 	}
 	return -ENOENT;
 }
+
+EXPORT_SYMBOL(fat_scan);
diff -L fs/fat/fatfs_syms.c -puN fs/fat/fatfs_syms.c~fat_export-cleanup /dev/null
--- linux-2.6.10/fs/fat/fatfs_syms.c
+++ /dev/null	2004-09-13 22:36:32.000000000 +0900
@@ -1,48 +0,0 @@
-/*
- * linux/fs/fat/fatfs_syms.c
- *
- * Exported kernel symbols for the low-level FAT-based fs support.
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/mm.h>
-#include <linux/msdos_fs.h>
-
-EXPORT_SYMBOL(fat_new_dir);
-EXPORT_SYMBOL(fat_date_unix2dos);
-EXPORT_SYMBOL(fat__get_entry);
-EXPORT_SYMBOL(fat_notify_change);
-EXPORT_SYMBOL(fat_attach);
-EXPORT_SYMBOL(fat_detach);
-EXPORT_SYMBOL(fat_build_inode);
-EXPORT_SYMBOL(fat_fill_super);
-EXPORT_SYMBOL(fat_search_long);
-EXPORT_SYMBOL(fat_scan);
-EXPORT_SYMBOL(fat_add_entries);
-EXPORT_SYMBOL(fat_dir_empty);
-
-int __init fat_cache_init(void);
-void __exit fat_cache_destroy(void);
-int __init fat_init_inodecache(void);
-void __exit fat_destroy_inodecache(void);
-static int __init init_fat_fs(void)
-{
-	int ret;
-
-	ret = fat_cache_init();
-	if (ret < 0)
-		return ret;
-	return fat_init_inodecache();
-}
-
-static void __exit exit_fat_fs(void)
-{
-	fat_cache_destroy();
-	fat_destroy_inodecache();
-}
-
-module_init(init_fat_fs)
-module_exit(exit_fat_fs)
diff -puN fs/fat/inode.c~fat_export-cleanup fs/fat/inode.c
--- linux-2.6.10/fs/fat/inode.c~fat_export-cleanup	2005-01-08 09:07:37.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/inode.c	2005-01-08 09:07:37.000000000 +0900
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
@@ -87,6 +88,8 @@ void fat_attach(struct inode *inode, lof
 	spin_unlock(&sbi->inode_hash_lock);
 }
 
+EXPORT_SYMBOL(fat_attach);
+
 void fat_detach(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
@@ -96,6 +99,8 @@ void fat_detach(struct inode *inode)
 	spin_unlock(&sbi->inode_hash_lock);
 }
 
+EXPORT_SYMBOL(fat_detach);
+
 struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -145,6 +150,8 @@ out:
 	return inode;
 }
 
+EXPORT_SYMBOL(fat_build_inode);
+
 static void fat_delete_inode(struct inode *inode)
 {
 	if (!is_bad_inode(inode)) {
@@ -1070,6 +1077,8 @@ out_fail:
 	return error;
 }
 
+EXPORT_SYMBOL(fat_fill_super);
+
 static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int free, nr, ret;
@@ -1328,4 +1337,29 @@ out:
 	unlock_kernel();
 	return error;
 }
+
+EXPORT_SYMBOL(fat_notify_change);
+
+int __init fat_cache_init(void);
+void __exit fat_cache_destroy(void);
+
+static int __init init_fat_fs(void)
+{
+	int ret;
+
+	ret = fat_cache_init();
+	if (ret < 0)
+		return ret;
+	return fat_init_inodecache();
+}
+
+static void __exit exit_fat_fs(void)
+{
+	fat_cache_destroy();
+	fat_destroy_inodecache();
+}
+
+module_init(init_fat_fs)
+module_exit(exit_fat_fs)
+
 MODULE_LICENSE("GPL");
diff -puN fs/fat/misc.c~fat_export-cleanup fs/fat/misc.c
--- linux-2.6.10/fs/fat/misc.c~fat_export-cleanup	2005-01-08 09:07:37.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/misc.c	2005-01-08 09:07:37.000000000 +0900
@@ -6,6 +6,7 @@
  *		 and date_dos2unix for date==0 by Igor Zhbanov(bsg@uniyar.ac.ru)
  */
 
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
@@ -272,6 +273,7 @@ void fat_date_unix2dos(int unix_date,__l
 	*date = cpu_to_le16(nl_day-day_n[month-1]+1+(month << 5)+(year << 9));
 }
 
+EXPORT_SYMBOL(fat_date_unix2dos);
 
 /* Returns the inode number of the directory entry at offset pos. If bh is
    non-NULL, it is brelse'd before. Pos is incremented. The buffer header is
@@ -320,3 +322,5 @@ next:
 
 	return 0;
 }
+
+EXPORT_SYMBOL(fat__get_entry);
_
