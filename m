Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316111AbSEWM0d>; Thu, 23 May 2002 08:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316474AbSEWM0c>; Thu, 23 May 2002 08:26:32 -0400
Received: from imladris.infradead.org ([194.205.184.45]:38666 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316111AbSEWM0U>; Thu, 23 May 2002 08:26:20 -0400
Date: Thu, 23 May 2002 13:26:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (9/10)
Message-ID: <20020523132611.A24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the 144 files in fs/ that need it include buffer_head.h directly.
Again some uses in the VFS files are layering violations and need to
be addressed later.  The new include statement gives a nice grep pattern
for that :)


--- 1.58/fs/block_dev.c	Wed May 22 23:43:52 2002
+++ edited/fs/block_dev.c	Thu May 23 13:18:39 2002
@@ -19,6 +19,7 @@
 #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/blkpg.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.104/fs/buffer.c	Wed May 22 01:33:34 2002
+++ edited/fs/buffer.c	Thu May 23 13:23:35 2002
@@ -33,6 +33,7 @@
 #include <linux/mempool.h>
 #include <linux/hash.h>
 #include <linux/suspend.h>
+#include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
--- 1.9/fs/fs-writeback.c	Sun May 19 13:49:49 2002
+++ edited/fs/fs-writeback.c	Thu May 23 13:18:39 2002
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
 
 /**
  *	__mark_inode_dirty -	internal function
--- 1.57/fs/inode.c	Mon May 20 18:35:29 2002
+++ edited/fs/inode.c	Thu May 23 13:18:40 2002
@@ -14,6 +14,16 @@
 #include <linux/writeback.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+/*
+ * This is needed for the following functions:
+ *  - inode_has_buffers
+ *  - invalidate_inode_buffers
+ *  - fsync_bdev
+ *  - invalidate_bdev
+ *
+ * FIXME: remove all knowledge of the buffer layer from this file
+ */
+#include <linux/buffer_head.h>
 
 /*
  * New inode.c implementation.
--- 1.73/fs/super.c	Wed May 22 17:50:25 2002
+++ edited/fs/super.c	Thu May 23 13:23:16 2002
@@ -28,6 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
 #include <linux/namei.h>
+#include <linux/buffer_head.h>		/* for fsync_super() */
 #include <asm/uaccess.h>
 
 void get_filesystem(struct file_system_type *fs);
--- 1.3/fs/adfs/adfs.h	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/adfs.h	Thu May 23 13:18:40 2002
@@ -14,6 +14,8 @@
 
 #include "dir_f.h"
 
+struct buffer_head;
+
 /*
  * Directory handling
  */
--- 1.6/fs/adfs/dir.c	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/dir.c	Thu May 23 13:18:40 2002
@@ -18,6 +18,7 @@
 #include <linux/stat.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>		/* for file_fsync() */
 
 #include "adfs.h"
 
--- 1.4/fs/adfs/dir_f.c	Mon Feb 25 19:35:33 2002
+++ edited/fs/adfs/dir_f.c	Thu May 23 13:18:40 2002
@@ -16,6 +16,7 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/buffer_head.h>
 
 #include "adfs.h"
 #include "dir_f.h"
--- 1.4/fs/adfs/dir_fplus.c	Mon Feb 25 19:35:33 2002
+++ edited/fs/adfs/dir_fplus.c	Thu May 23 13:18:40 2002
@@ -14,6 +14,7 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/buffer_head.h>
 
 #include "adfs.h"
 #include "dir_fplus.h"
--- 1.3/fs/adfs/file.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/adfs/file.c	Thu May 23 13:18:40 2002
@@ -25,6 +25,7 @@
 #include <linux/fcntl.h>
 #include <linux/time.h>
 #include <linux/stat.h>
+#include <linux/buffer_head.h>		/* for file_fsync() */
 
 #include "adfs.h"
 
--- 1.11/fs/adfs/inode.c	Mon May 20 15:34:22 2002
+++ edited/fs/adfs/inode.c	Thu May 23 13:18:41 2002
@@ -17,7 +17,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
-
+#include <linux/buffer_head.h>
 
 #include "adfs.h"
 
--- 1.3/fs/adfs/map.c	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/map.c	Thu May 23 13:18:41 2002
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 #include <linux/spinlock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/unaligned.h>
 
--- 1.15/fs/adfs/super.c	Mon May 20 15:34:24 2002
+++ edited/fs/adfs/super.c	Thu May 23 13:18:41 2002
@@ -17,6 +17,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/buffer_head.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- 1.12/fs/affs/amigaffs.c	Mon May 20 15:34:27 2002
+++ edited/fs/affs/amigaffs.c	Thu May 23 13:18:41 2002
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/amigaffs.h>
+#include <linux/buffer_head.h>
 
 extern struct timezone sys_tz;
 
--- 1.9/fs/affs/bitmap.c	Mon May 20 15:34:29 2002
+++ edited/fs/affs/bitmap.c	Thu May 23 13:18:41 2002
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/amigaffs.h>
+#include <linux/buffer_head.h>
 
 /* This is, of course, shamelessly stolen from fs/minix */
 
--- 1.8/fs/affs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/affs/dir.c	Thu May 23 13:18:41 2002
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/amigaffs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 static int affs_readdir(struct file *, void *, filldir_t);
 
--- 1.18/fs/affs/file.c	Mon May 20 15:34:32 2002
+++ edited/fs/affs/file.c	Thu May 23 13:18:41 2002
@@ -28,6 +28,7 @@
 #include <linux/amigaffs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #if PAGE_SIZE < 4096
 #error PAGE_SIZE must be at least 4096
--- 1.14/fs/affs/inode.c	Mon May 20 15:34:34 2002
+++ edited/fs/affs/inode.c	Thu May 23 13:18:41 2002
@@ -26,6 +26,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/module.h>
--- 1.17/fs/affs/namei.c	Mon May 20 15:34:36 2002
+++ edited/fs/affs/namei.c	Thu May 23 13:18:42 2002
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/amigaffs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
 #include <linux/errno.h>
--- 1.24/fs/affs/super.c	Mon May 20 15:34:39 2002
+++ edited/fs/affs/super.c	Thu May 23 13:18:42 2002
@@ -26,6 +26,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
--- 1.4/fs/affs/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/affs/symlink.c	Thu May 23 13:18:42 2002
@@ -15,6 +15,7 @@
 #include <linux/amigaffs.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 static int affs_symlink_readpage(struct file *file, struct page *page)
 {
--- 1.16/fs/bfs/dir.c	Tue May 21 03:13:12 2002
+++ edited/fs/bfs/dir.c	Thu May 23 13:24:30 2002
@@ -8,6 +8,8 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 #include "bfs.h"
 
 #undef DEBUG
--- 1.8/fs/bfs/file.c	Tue May 21 03:12:35 2002
+++ edited/fs/bfs/file.c	Thu May 23 13:24:50 2002
@@ -5,7 +5,7 @@
  */
 
 #include <linux/fs.h>
-#include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include "bfs.h"
 
--- 1.15/fs/bfs/inode.c	Tue May 21 03:12:51 2002
+++ edited/fs/bfs/inode.c	Thu May 23 13:25:04 2002
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 #include "bfs.h"
 
--- 1.21/fs/cramfs/inode.c	Mon May 20 15:35:10 2002
+++ edited/fs/cramfs/inode.c	Thu May 23 13:18:42 2002
@@ -21,6 +21,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/cramfs_fs_sb.h>
+#include <linux/buffer_head.h>
 #include <asm/semaphore.h>
 
 #include <asm/uaccess.h>
--- 1.3/fs/efs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/efs/dir.c	Thu May 23 13:18:43 2002
@@ -4,6 +4,7 @@
  * Copyright (c) 1999 Al Smith
  */
 
+#include <linux/buffer_head.h>
 #include <linux/efs_fs.h>
 #include <linux/smp_lock.h>
 
--- 1.3/fs/efs/file.c	Tue Feb  5 16:23:03 2002
+++ edited/fs/efs/file.c	Thu May 23 13:18:43 2002
@@ -6,6 +6,7 @@
  * Portions derived from work (c) 1995,1996 Christian Vogelgsang.
  */
 
+#include <linux/buffer_head.h>
 #include <linux/efs_fs.h>
 
 int efs_get_block(struct inode *inode, sector_t iblock,
--- 1.4/fs/efs/inode.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/efs/inode.c	Thu May 23 13:18:43 2002
@@ -9,6 +9,7 @@
 
 #include <linux/efs_fs.h>
 #include <linux/efs_fs_sb.h>
+#include <linux/buffer_head.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 
--- 1.3/fs/efs/namei.c	Tue Feb 12 00:45:56 2002
+++ edited/fs/efs/namei.c	Thu May 23 13:18:43 2002
@@ -6,6 +6,7 @@
  * Portions derived from work (c) 1995,1996 Christian Vogelgsang.
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include <linux/efs_fs.h>
 #include <linux/smp_lock.h>
--- 1.10/fs/efs/super.c	Mon May 20 15:35:18 2002
+++ edited/fs/efs/super.c	Thu May 23 13:18:43 2002
@@ -12,6 +12,7 @@
 #include <linux/efs_vh.h>
 #include <linux/efs_fs_sb.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>
 
 static struct super_block *efs_get_sb(struct file_system_type *fs_type,
 	int flags, char *dev_name, void *data)
--- 1.3/fs/efs/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/efs/symlink.c	Thu May 23 13:18:44 2002
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/efs_fs.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 static int efs_symlink_readpage(struct file *file, struct page *page)
--- 1.19/fs/ext2/balloc.c	Mon May 20 20:56:05 2002
+++ edited/fs/ext2/balloc.c	Thu May 23 13:18:44 2002
@@ -15,6 +15,7 @@
 #include "ext2.h"
 #include <linux/quotaops.h>
 #include <linux/sched.h>
+#include <linux/buffer_head.h>
 
 /*
  * balloc.c contains the blocks allocation and deallocation routines
--- 1.2/fs/ext2/bitmap.c	Tue Feb  5 16:24:38 2002
+++ edited/fs/ext2/bitmap.c	Thu May 23 13:18:44 2002
@@ -7,7 +7,7 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */
 
-#include "ext2.h"
+#include <linux/buffer_head.h>
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
 
--- 1.7/fs/ext2/fsync.c	Mon May 20 15:35:24 2002
+++ edited/fs/ext2/fsync.c	Thu May 23 13:18:44 2002
@@ -24,6 +24,7 @@
 
 #include "ext2.h"
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>		/* for fsync_inode_buffers() */
 
 
 /*
--- 1.16/fs/ext2/ialloc.c	Mon May 20 20:56:05 2002
+++ edited/fs/ext2/ialloc.c	Thu May 23 13:18:44 2002
@@ -16,6 +16,7 @@
 #include "ext2.h"
 #include <linux/quotaops.h>
 #include <linux/sched.h>
+#include <linux/buffer_head.h>
 
 
 /*
--- 1.31/fs/ext2/inode.c	Mon May 20 15:49:47 2002
+++ edited/fs/ext2/inode.c	Thu May 23 13:18:44 2002
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/module.h>
+#include <linux/buffer_head.h>
 
 MODULE_AUTHOR("Remy Card and others");
 MODULE_DESCRIPTION("Second Extended Filesystem");
--- 1.11/fs/ext2/namei.c	Tue Apr 16 07:17:06 2002
+++ edited/fs/ext2/namei.c	Thu May 23 13:18:44 2002
@@ -31,6 +31,7 @@
 
 #include "ext2.h"
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>		/* for block_symlink() */
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
--- 1.24/fs/ext2/super.c	Mon May 20 15:35:32 2002
+++ edited/fs/ext2/super.c	Thu May 23 13:18:45 2002
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/random.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
--- 1.5/fs/ext3/balloc.c	Mon May 20 15:35:35 2002
+++ edited/fs/ext3/balloc.c	Thu May 23 13:18:45 2002
@@ -18,6 +18,7 @@
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 
 /*
  * balloc.c contains the blocks allocation and deallocation routines
--- 1.1/fs/ext3/bitmap.c	Tue Feb  5 21:32:38 2002
+++ edited/fs/ext3/bitmap.c	Thu May 23 13:18:45 2002
@@ -7,7 +7,7 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */
 
-#include <linux/fs.h>
+#include <linux/buffer_head.h>
 
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
--- 1.2/fs/ext3/dir.c	Wed Apr 24 18:10:07 2002
+++ edited/fs/ext3/dir.c	Thu May 23 13:18:45 2002
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 static unsigned char ext3_filetype_table[] = {
--- 1.9/fs/ext3/ialloc.c	Mon May 20 15:35:39 2002
+++ edited/fs/ext3/ialloc.c	Thu May 23 13:18:45 2002
@@ -20,6 +20,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
--- 1.19/fs/ext3/inode.c	Mon May 20 15:50:43 2002
+++ edited/fs/ext3/inode.c	Thu May 23 13:18:45 2002
@@ -32,6 +32,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the start
--- 1.14/fs/ext3/namei.c	Mon May 20 15:35:44 2002
+++ edited/fs/ext3/namei.c	Thu May 23 13:18:45 2002
@@ -27,6 +27,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 
--- 1.21/fs/ext3/super.c	Mon May 20 15:35:46 2002
+++ edited/fs/ext3/super.c	Thu May 23 13:18:46 2002
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_JBD_DEBUG
--- 1.7/fs/fat/buffer.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/fat/buffer.c	Thu May 23 13:18:46 2002
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
+#include <linux/buffer_head.h>
 
 struct buffer_head *fat_bread(struct super_block *sb, int block)
 {
--- 1.14/fs/fat/cache.c	Thu Apr 25 03:45:38 2002
+++ edited/fs/fat/cache.c	Thu May 23 13:18:46 2002
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
+#include <linux/buffer_head.h>
 
 #if 0
 #  define PRINTK(x) printk x
--- 1.3/fs/fat/cvf.c	Tue Feb  5 16:24:44 2002
+++ edited/fs/fat/cvf.c	Thu May 23 13:18:46 2002
@@ -13,6 +13,7 @@
 #include <linux/msdos_fs_sb.h>
 #include <linux/fat_cvf.h>
 #include <linux/config.h>
+#include <linux/buffer_head.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
--- 1.11/fs/fat/dir.c	Fri May 17 23:17:59 2002
+++ edited/fs/fat/dir.c	Thu May 23 13:18:46 2002
@@ -18,6 +18,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/dirent.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.13/fs/fat/file.c	Mon May 20 15:35:48 2002
+++ edited/fs/fat/file.c	Thu May 23 13:18:46 2002
@@ -10,6 +10,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #define PRINTK(x)
 #define Printk(x) printk x
--- 1.39/fs/fat/inode.c	Mon May 20 16:06:31 2002
+++ edited/fs/fat/inode.c	Thu May 23 13:18:46 2002
@@ -17,6 +17,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 //#include <asm/uaccess.h>
 #include <asm/unaligned.h>
--- 1.9/fs/fat/misc.c	Thu Apr 25 03:45:38 2002
+++ edited/fs/fat/misc.c	Thu May 23 13:18:47 2002
@@ -8,6 +8,7 @@
 
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
+#include <linux/buffer_head.h>
 
 #if 0
 #  define PRINTK(x)	printk x
--- 1.7/fs/freevxfs/vxfs_bmap.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_bmap.c	Thu May 23 13:18:47 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - filesystem to disk block mapping.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 
 #include "vxfs.h"
--- 1.4/fs/freevxfs/vxfs_fshead.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_fshead.c	Thu May 23 13:18:47 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - fileset header routines.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
--- 1.8/fs/freevxfs/vxfs_inode.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_inode.c	Thu May 23 13:18:47 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - inode routines.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/pagemap.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
--- 1.4/fs/freevxfs/vxfs_olt.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_olt.c	Thu May 23 13:18:47 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - object location table support.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 
 #include "vxfs.h"
--- 1.8/fs/freevxfs/vxfs_subr.c	Tue Apr 30 00:18:54 2002
+++ edited/fs/freevxfs/vxfs_subr.c	Thu May 23 13:18:47 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - shared subroutines.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
--- 1.8/fs/freevxfs/vxfs_super.c	Fri Mar  8 20:00:27 2002
+++ edited/fs/freevxfs/vxfs_super.c	Thu May 23 13:18:47 2002
@@ -37,6 +37,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
--- 1.11/fs/hfs/file.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/hfs/file.c	Thu May 23 13:18:48 2002
@@ -20,6 +20,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 /*================ Forward declarations ================*/
--- 1.1/fs/hpfs/alloc.c	Tue Feb  5 18:39:38 2002
+++ edited/fs/hpfs/alloc.c	Thu May 23 13:18:48 2002
@@ -6,6 +6,7 @@
  *  HPFS bitmap operations
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 /*
--- 1.3/fs/hpfs/anode.c	Tue Feb  5 16:24:38 2002
+++ edited/fs/hpfs/anode.c	Thu May 23 13:18:49 2002
@@ -6,6 +6,7 @@
  *  handling HPFS anode tree that contains file allocation info
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 /* Find a sector in allocation tree */
--- 1.5/fs/hpfs/buffer.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/hpfs/buffer.c	Thu May 23 13:18:49 2002
@@ -6,6 +6,7 @@
  *  general buffer i/o
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 
--- 1.7/fs/hpfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/hpfs/dir.c	Thu May 23 13:18:49 2002
@@ -7,6 +7,7 @@
  */
 
 #include "hpfs_fn.h"
+#include <linux/buffer_head.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
 
--- 1.2/fs/hpfs/dnode.c	Tue Feb  5 16:24:38 2002
+++ edited/fs/hpfs/dnode.c	Thu May 23 13:18:49 2002
@@ -6,6 +6,7 @@
  *  handling directory dnode tree - adding, deleteing & searching for dirents
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 static loff_t get_pos(struct dnode *d, struct hpfs_dirent *fde)
--- 1.3/fs/hpfs/ea.c	Sat Mar  2 12:53:22 2002
+++ edited/fs/hpfs/ea.c	Thu May 23 13:18:49 2002
@@ -6,6 +6,7 @@
  *  handling extended attributes
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 
--- 1.9/fs/hpfs/file.c	Mon May 20 16:54:41 2002
+++ edited/fs/hpfs/file.c	Thu May 23 13:18:49 2002
@@ -6,6 +6,7 @@
  *  file VFS functions
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
--- 1.7/fs/hpfs/hpfs_fn.h	Mon May 20 16:24:01 2002
+++ edited/fs/hpfs/hpfs_fn.h	Thu May 23 13:18:49 2002
@@ -9,6 +9,7 @@
 //#define DBG
 //#define DEBUG_LOCKS
 
+#include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include <linux/hpfs_fs.h>
 #include <linux/hpfs_fs_i.h>
--- 1.9/fs/hpfs/inode.c	Mon May 20 17:01:05 2002
+++ edited/fs/hpfs/inode.c	Thu May 23 13:18:49 2002
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 static struct file_operations hpfs_file_ops =
--- 1.1/fs/hpfs/map.c	Tue Feb  5 18:39:38 2002
+++ edited/fs/hpfs/map.c	Thu May 23 13:18:50 2002
@@ -6,6 +6,7 @@
  *  mapping structures to memory with some minimal checks
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 unsigned *hpfs_map_dnode_bitmap(struct super_block *s, struct quad_buffer_head *qbh)
--- 1.13/fs/hpfs/namei.c	Mon May 20 16:55:37 2002
+++ edited/fs/hpfs/namei.c	Thu May 23 13:18:50 2002
@@ -8,6 +8,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 int hpfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
--- 1.13/fs/hpfs/super.c	Wed Mar 13 21:21:39 2002
+++ edited/fs/hpfs/super.c	Thu May 23 13:18:50 2002
@@ -6,6 +6,7 @@
  *  mounting, unmounting, error handling
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 #include <linux/module.h>
--- 1.9/fs/isofs/compress.c	Mon May 20 15:37:01 2002
+++ edited/fs/isofs/compress.c	Thu May 23 13:18:50 2002
@@ -36,6 +36,7 @@
 #include <linux/blkdev.h>
 #include <linux/vmalloc.h>
 #include <linux/zlib.h>
+#include <linux/buffer_head.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
--- 1.8/fs/isofs/dir.c	Mon May 20 15:37:03 2002
+++ edited/fs/isofs/dir.c	Thu May 23 13:18:50 2002
@@ -21,6 +21,7 @@
 #include <linux/time.h>
 #include <linux/config.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.21/fs/isofs/inode.c	Mon May 20 15:37:05 2002
+++ edited/fs/isofs/inode.c	Thu May 23 13:18:50 2002
@@ -27,6 +27,7 @@
 #include <linux/ctype.h>
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
+#include <linux/buffer_head.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
--- 1.8/fs/isofs/namei.c	Sat Mar 16 01:32:28 2002
+++ edited/fs/isofs/namei.c	Thu May 23 13:18:50 2002
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/config.h>	/* Joliet? */
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.11/fs/isofs/rock.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/isofs/rock.c	Thu May 23 13:18:50 2002
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "rock.h"
 
--- 1.5/fs/jfs/inode.c	Mon May 20 15:40:18 2002
+++ edited/fs/jfs/inode.c	Thu May 23 13:18:51 2002
@@ -17,6 +17,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_imap.h"
--- 1.15/fs/jfs/jfs_logmgr.c	Tue May 21 17:02:05 2002
+++ edited/fs/jfs/jfs_logmgr.c	Thu May 23 13:18:51 2002
@@ -63,6 +63,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/buffer_head.h>		/* for sync_blockdev() */
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
--- 1.9/fs/jfs/jfs_metapage.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/jfs/jfs_metapage.c	Thu May 23 13:18:51 2002
@@ -18,6 +18,7 @@
 
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/buffer_head.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
--- 1.9/fs/minix/bitmap.c	Wed Mar 20 08:41:14 2002
+++ edited/fs/minix/bitmap.c	Thu May 23 13:18:51 2002
@@ -13,6 +13,7 @@
 
 #include "minix.h"
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
 static int nibblemap[] = { 4,3,3,2,3,2,2,1,3,2,2,1,2,1,1,0 };
--- 1.8/fs/minix/file.c	Wed May 22 14:29:02 2002
+++ edited/fs/minix/file.c	Thu May 23 13:18:51 2002
@@ -6,6 +6,7 @@
  *  minix regular file handling primitives
  */
 
+#include <linux/buffer_head.h>		/* for fsync_inode_buffers() */
 #include "minix.h"
 
 /*
--- 1.24/fs/minix/inode.c	Wed May 22 14:29:02 2002
+++ edited/fs/minix/inode.c	Thu May 23 13:18:52 2002
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include "minix.h"
+#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
--- 1.8/fs/minix/itree_v1.c	Wed May 22 14:29:02 2002
+++ edited/fs/minix/itree_v1.c	Thu May 23 13:18:52 2002
@@ -1,3 +1,4 @@
+#include <linux/buffer_head.h>
 #include "minix.h"
 
 enum {DEPTH = 3, DIRECT = 7};	/* Only double indirect */
--- 1.8/fs/minix/itree_v2.c	Wed May 22 14:29:02 2002
+++ edited/fs/minix/itree_v2.c	Thu May 23 13:18:52 2002
@@ -1,3 +1,4 @@
+#include <linux/buffer_head.h>
 #include "minix.h"
 
 enum {DIRECT = 7, DEPTH = 4};	/* Have triple indirect */
--- 1.11/fs/minix/namei.c	Wed May 22 14:29:03 2002
+++ edited/fs/minix/namei.c	Thu May 23 13:18:52 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/buffer_head.h>	/* for block_symlink() */
 #include "minix.h"
 
 static inline void inc_count(struct inode *inode)
--- 1.21/fs/msdos/namei.c	Tue May  7 06:35:29 2002
+++ edited/fs/msdos/namei.c	Thu May 23 13:18:52 2002
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 
 #include <linux/time.h>
+#include <linux/buffer_head.h>
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 
--- 1.12/fs/nfsd/nfs3xdr.c	Wed May 22 21:19:24 2002
+++ edited/fs/nfsd/nfs3xdr.c	Thu May 23 13:58:00 2002
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/nfs3.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
 
--- 1.70/fs/ntfs/aops.c	Mon May 20 15:38:18 2002
+++ edited/fs/ntfs/aops.c	Thu May 23 13:18:52 2002
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 
--- 1.74/fs/ntfs/attrib.c	Wed Apr 24 02:40:01 2002
+++ edited/fs/ntfs/attrib.c	Thu May 23 13:18:52 2002
@@ -20,6 +20,7 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/buffer_head.h>
 #include "ntfs.h"
 
 /* Temporary helper functions -- might become macros */
--- 1.41/fs/ntfs/compress.c	Mon May 20 15:38:20 2002
+++ edited/fs/ntfs/compress.c	Thu May 23 13:18:53 2002
@@ -22,6 +22,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 
--- 1.80/fs/ntfs/inode.c	Wed May  1 21:22:13 2002
+++ edited/fs/ntfs/inode.c	Thu May 23 13:18:53 2002
@@ -20,6 +20,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 
--- 1.100/fs/ntfs/super.c	Mon May 20 15:38:24 2002
+++ edited/fs/ntfs/super.c	Thu May 23 13:18:53 2002
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
 #include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
--- 1.22/fs/partitions/check.c	Wed May  1 00:07:04 2002
+++ edited/fs/partitions/check.c	Thu May 23 13:18:54 2002
@@ -21,6 +21,7 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 #include <linux/raid/md.h>
+#include <linux/buffer_head.h>	/* for invalidate_bdev() */
 
 #include "check.h"
 
--- 1.11/fs/partitions/msdos.c	Wed Apr 24 22:00:33 2002
+++ edited/fs/partitions/msdos.c	Thu May 23 13:18:54 2002
@@ -26,6 +26,7 @@
 #include <linux/major.h>
 #include <linux/string.h>
 #include <linux/blk.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #ifdef CONFIG_BLK_DEV_IDE
 #include <linux/ide.h>	/* IDE xlate */
--- 1.5/fs/qnx4/bitmap.c	Wed Mar 13 21:06:39 2002
+++ edited/fs/qnx4/bitmap.c	Thu May 23 13:18:54 2002
@@ -20,6 +20,7 @@
 #include <linux/stat.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 #include <asm/bitops.h>
 
--- 1.4/fs/qnx4/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/qnx4/dir.c	Thu May 23 13:18:54 2002
@@ -18,6 +18,7 @@
 #include <linux/qnx4_fs.h>
 #include <linux/stat.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 
 static int qnx4_readdir(struct file *filp, void *dirent, filldir_t filldir)
--- 1.6/fs/qnx4/fsync.c	Mon May 20 15:38:30 2002
+++ edited/fs/qnx4/fsync.c	Thu May 23 13:18:54 2002
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <linux/fs.h>
 #include <linux/qnx4_fs.h>
--- 1.18/fs/qnx4/inode.c	Mon May 20 17:07:51 2002
+++ edited/fs/qnx4/inode.c	Thu May 23 13:18:54 2002
@@ -24,6 +24,7 @@
 #include <linux/highuid.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.7/fs/qnx4/namei.c	Thu Feb 14 11:30:17 2002
+++ edited/fs/qnx4/namei.c	Thu May 23 13:18:54 2002
@@ -22,6 +22,7 @@
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 
 /*
--- 1.17/fs/ramfs/inode.c	Mon May 20 15:38:36 2002
+++ edited/fs/ramfs/inode.c	Thu May 23 13:18:55 2002
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>		/* for block_symlink() */
 
 #include <asm/uaccess.h>
 
--- 1.16/fs/reiserfs/bitmap.c	Mon May 20 15:38:38 2002
+++ edited/fs/reiserfs/bitmap.c	Thu May 23 13:18:55 2002
@@ -7,6 +7,7 @@
 #include <linux/reiserfs_fs.h>
 #include <asm/bitops.h>
 #include <linux/list.h>
+#include <linux/buffer_head.h>
 
 #ifdef CONFIG_REISERFS_CHECK
 
--- 1.12/fs/reiserfs/buffer2.c	Mon May 20 15:38:41 2002
+++ edited/fs/reiserfs/buffer2.c	Thu May 23 13:18:55 2002
@@ -7,6 +7,7 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
+#include <linux/buffer_head.h>
 
 /*
  *  wait_buffer_until_released
--- 1.14/fs/reiserfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/reiserfs/dir.c	Thu May 23 13:18:55 2002
@@ -9,6 +9,7 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/stat.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
 extern struct key  MIN_KEY;
--- 1.13/fs/reiserfs/do_balan.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/reiserfs/do_balan.c	Thu May 23 13:18:55 2002
@@ -20,6 +20,7 @@
 #include <asm/uaccess.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 #ifdef CONFIG_REISERFS_CHECK
 
--- 1.22/fs/reiserfs/fix_node.c	Tue May 21 11:12:36 2002
+++ edited/fs/reiserfs/fix_node.c	Thu May 23 13:18:55 2002
@@ -39,6 +39,7 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 
 /* To make any changes in the tree we find a node, that contains item
--- 1.9/fs/reiserfs/ibalance.c	Wed Mar 27 20:38:22 2002
+++ edited/fs/reiserfs/ibalance.c	Thu May 23 13:18:56 2002
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 /* this is one and only function that is used outside (do_balance.c) */
 int	balance_internal (
--- 1.58/fs/reiserfs/inode.c	Mon May 20 17:06:22 2002
+++ edited/fs/reiserfs/inode.c	Thu May 23 13:18:56 2002
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
+#include <linux/buffer_head.h>
 
 /* args for the create parameter of reiserfs_get_block */
 #define GET_BLOCK_NO_CREATE 0 /* don't create new blocks or convert tails */
--- 1.41/fs/reiserfs/journal.c	Wed May 22 01:33:36 2002
+++ edited/fs/reiserfs/journal.c	Thu May 23 13:24:03 2002
@@ -58,6 +58,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/suspend.h> 
+#include <linux/buffer_head.h>
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
--- 1.8/fs/reiserfs/lbalance.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/reiserfs/lbalance.c	Thu May 23 13:18:56 2002
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 /* these are used in do_balance.c */
 
--- 1.16/fs/reiserfs/prints.c	Tue Apr 30 00:18:28 2002
+++ edited/fs/reiserfs/prints.c	Thu May 23 13:18:56 2002
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 #include <stdarg.h>
 
--- 1.7/fs/reiserfs/resize.c	Mon May 20 15:39:01 2002
+++ edited/fs/reiserfs/resize.c	Thu May 23 13:18:56 2002
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/reiserfs_fs_sb.h>
+#include <linux/buffer_head.h>
 
 int reiserfs_resize (struct super_block * s, unsigned long block_count_new)
 {
--- 1.28/fs/reiserfs/stree.c	Mon May 20 15:39:03 2002
+++ edited/fs/reiserfs/stree.c	Thu May 23 13:18:57 2002
@@ -59,6 +59,7 @@
 #include <linux/pagemap.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 /* Does the buffer contain a disk block which is in the tree. */
 inline int B_IS_IN_TREE (const struct buffer_head * p_s_bh)
--- 1.41/fs/reiserfs/super.c	Mon May 20 15:39:05 2002
+++ edited/fs/reiserfs/super.c	Thu May 23 13:18:57 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
+#include <linux/buffer_head.h>
 
 #define REISERFS_OLD_BLOCKSIZE 4096
 #define REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ 20
--- 1.20/fs/reiserfs/tail_conversion.c	Mon May 20 15:39:07 2002
+++ edited/fs/reiserfs/tail_conversion.c	Thu May 23 13:18:57 2002
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/time.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 #include <linux/reiserfs_fs.h>
 
 /* access to tail : when one is going to read tail it must make sure, that is not running.
--- 1.19/fs/romfs/inode.c	Mon May 20 17:05:58 2002
+++ edited/fs/romfs/inode.c	Thu May 23 13:18:57 2002
@@ -73,6 +73,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.8/fs/sysv/balloc.c	Mon May 20 15:39:18 2002
+++ edited/fs/sysv/balloc.c	Thu May 23 13:18:57 2002
@@ -19,6 +19,7 @@
  *  This file contains code for allocating/freeing blocks.
  */
 
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 /* We don't trust the value of
--- 1.10/fs/sysv/ialloc.c	Mon May 20 16:07:13 2002
+++ edited/fs/sysv/ialloc.c	Thu May 23 13:18:57 2002
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 /* We don't trust the value of
--- 1.21/fs/sysv/inode.c	Wed May 22 14:29:03 2002
+++ edited/fs/sysv/inode.c	Thu May 23 13:18:58 2002
@@ -25,6 +25,7 @@
 #include <linux/highuid.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 #include "sysv.h"
 
--- 1.12/fs/sysv/itree.c	Wed May 22 14:29:03 2002
+++ edited/fs/sysv/itree.c	Thu May 23 13:18:58 2002
@@ -5,6 +5,7 @@
  *  AV, Sep--Dec 2000
  */
 
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
--- 1.15/fs/sysv/super.c	Fri Apr 19 17:34:33 2002
+++ edited/fs/sysv/super.c	Thu May 23 13:18:58 2002
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 /*
--- 1.2/fs/sysv/sysv.h	Wed May 22 14:29:03 2002
+++ edited/fs/sysv/sysv.h	Thu May 23 14:29:20 2002
@@ -1,7 +1,7 @@
 #ifndef _SYSV_H
 #define _SYSV_H
 
-#include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/sysv_fs.h>
 
 /*
--- 1.8/fs/udf/balloc.c	Mon May 20 15:39:29 2002
+++ edited/fs/udf/balloc.c	Thu May 23 13:18:59 2002
@@ -27,6 +27,7 @@
 #include "udfdecl.h"
 
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
 #include "udf_i.h"
--- 1.8/fs/udf/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/udf/dir.c	Thu May 23 13:18:59 2002
@@ -36,6 +36,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
--- 1.4/fs/udf/directory.c	Wed Mar 13 00:56:21 2002
+++ edited/fs/udf/directory.c	Thu May 23 13:18:59 2002
@@ -20,6 +20,7 @@
 
 #include <linux/fs.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 uint8_t * udf_filead_read(struct inode *dir, uint8_t *tmpad, uint8_t ad_size,
 	lb_addr fe_loc, int *pos, int *offset, struct buffer_head **bh, int *error)
--- 1.9/fs/udf/file.c	Mon May 20 16:56:47 2002
+++ edited/fs/udf/file.c	Thu May 23 13:18:59 2002
@@ -39,6 +39,7 @@
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
--- 1.8/fs/udf/ialloc.c	Mon May 20 15:39:35 2002
+++ edited/fs/udf/ialloc.c	Thu May 23 13:18:59 2002
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/udf_fs.h>
+#include <linux/sched.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
--- 1.20/fs/udf/inode.c	Mon May 20 16:56:21 2002
+++ edited/fs/udf/inode.c	Thu May 23 13:18:59 2002
@@ -38,6 +38,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
--- 1.4/fs/udf/misc.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/misc.c	Thu May 23 13:19:00 2002
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/udf_fs.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
--- 1.19/fs/udf/namei.c	Mon May 20 15:39:42 2002
+++ edited/fs/udf/namei.c	Thu May 23 13:19:00 2002
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 static inline int udf_match(int len, const char * const name, struct qstr *qs)
 {
--- 1.6/fs/udf/partition.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/partition.c	Thu May 23 13:19:00 2002
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/udf_fs.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>
 
 inline uint32_t udf_get_pblock(struct super_block *sb, uint32_t block, uint16_t partition, uint32_t offset)
 {
--- 1.22/fs/udf/super.c	Mon May 20 15:39:44 2002
+++ edited/fs/udf/super.c	Thu May 23 13:19:00 2002
@@ -55,6 +55,7 @@
 #include <linux/cdrom.h>
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 
 #include <linux/udf_fs.h>
--- 1.7/fs/udf/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/udf/symlink.c	Thu May 23 13:19:00 2002
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include "udf_i.h"
 
 static void udf_pc_to_char(char *from, int fromlen, char *to)
--- 1.5/fs/udf/truncate.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/truncate.c	Thu May 23 13:19:00 2002
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/udf_fs.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
--- 1.8/fs/udf/udfdecl.h	Sat Mar 16 02:16:39 2002
+++ edited/fs/udf/udfdecl.h	Thu May 23 13:19:00 2002
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/udf_fs_i.h>
 #include <linux/udf_fs_sb.h>
+#include <linux/buffer_head.h>
 
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
--- 1.12/fs/ufs/balloc.c	Mon May 20 15:39:46 2002
+++ edited/fs/ufs/balloc.c	Thu May 23 13:19:01 2002
@@ -12,6 +12,8 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
--- 1.7/fs/ufs/dir.c	Mon May 20 15:39:50 2002
+++ edited/fs/ufs/dir.c	Thu May 23 13:19:01 2002
@@ -17,6 +17,8 @@
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 
 #include "swab.h"
 #include "util.h"
--- 1.7/fs/ufs/ialloc.c	Mon May 20 15:39:55 2002
+++ edited/fs/ufs/ialloc.c	Thu May 23 13:19:01 2002
@@ -26,6 +26,8 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
--- 1.11/fs/ufs/inode.c	Mon May 20 15:39:56 2002
+++ edited/fs/ufs/inode.c	Thu May 23 13:19:01 2002
@@ -36,6 +36,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "swab.h"
 #include "util.h"
--- 1.13/fs/ufs/namei.c	Fri Feb 15 01:56:13 2002
+++ edited/fs/ufs/namei.c	Thu May 23 13:19:01 2002
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #undef UFS_NAMEI_DEBUG
 
--- 1.21/fs/ufs/super.c	Mon May 20 15:39:59 2002
+++ edited/fs/ufs/super.c	Thu May 23 13:19:01 2002
@@ -80,6 +80,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "swab.h"
 #include "util.h"
--- 1.11/fs/ufs/truncate.c	Mon May 20 15:40:01 2002
+++ edited/fs/ufs/truncate.c	Thu May 23 13:19:01 2002
@@ -37,6 +37,8 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 
 #include "swab.h"
 #include "util.h"
--- 1.8/fs/ufs/util.c	Mon May 20 15:40:03 2002
+++ edited/fs/ufs/util.c	Thu May 23 13:19:01 2002
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/ufs_fs.h>
+#include <linux/buffer_head.h>
 
 #include "swab.h"
 #include "util.h"
--- 1.5/fs/ufs/util.h	Tue Feb  5 16:22:35 2002
+++ edited/fs/ufs/util.h	Thu May 23 14:29:27 2002
@@ -6,6 +6,7 @@
  * Charles University, Faculty of Mathematics and Physics
  */
 
+#include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include "swab.h"
 
--- 1.21/fs/vfat/namei.c	Wed May 22 20:16:37 2002
+++ edited/fs/vfat/namei.c	Thu May 23 13:19:02 2002
@@ -22,6 +22,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #define DEBUG_LEVEL 0
 #if (DEBUG_LEVEL >= 1)
