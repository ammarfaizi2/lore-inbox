Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316108AbSETQal>; Mon, 20 May 2002 12:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSETQak>; Mon, 20 May 2002 12:30:40 -0400
Received: from imladris.infradead.org ([194.205.184.45]:57104 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316108AbSETQaY>; Mon, 20 May 2002 12:30:24 -0400
Date: Mon, 20 May 2002 17:29:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of <linux/locks.h>
Message-ID: <20020520172927.A24528@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock.h header contained some hand-crafted lcoking routines from
the pre-SMP days.  In 2.5 only lock_super/unlock_super are left,
guarded by a number of completly unrelated (!) includes.

This patch moves lock_super/unlock_super to fs.h, which defined
struct super_block that is needed for those to operate it, removes
locks.h and updates all caller to not include it and add the missing,
previously nested includes where needed.

===== drivers/block/DAC960.c 1.26 vs edited =====
--- 1.26/drivers/block/DAC960.c	Tue Apr 30 22:58:44 2002
+++ edited/drivers/block/DAC960.c	Mon May 20 13:33:58 2002
@@ -35,7 +35,6 @@
 #include <linux/blkpg.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
===== drivers/block/block_ioctl.c 1.7 vs edited =====
--- 1.7/drivers/block/block_ioctl.c	Wed Apr 24 22:00:34 2002
+++ edited/drivers/block/block_ioctl.c	Mon May 20 13:41:02 2002
@@ -21,7 +21,6 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/config.h>
-#include <linux/locks.h>
 #include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
===== drivers/block/cpqarray.h 1.5 vs edited =====
--- 1.5/drivers/block/cpqarray.h	Tue Feb  5 16:22:01 2002
+++ edited/drivers/block/cpqarray.h	Mon May 20 13:34:04 2002
@@ -27,7 +27,6 @@
 
 #ifdef __KERNEL__
 #include <linux/blkdev.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/timer.h>
===== drivers/block/ll_rw_blk.c 1.66 vs edited =====
--- 1.66/drivers/block/ll_rw_blk.c	Sun May 19 13:49:48 2002
+++ edited/drivers/block/ll_rw_blk.c	Mon May 20 13:34:06 2002
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/config.h>
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/init.h>
===== drivers/isdn/capi/capifs.c 1.16 vs edited =====
--- 1.16/drivers/isdn/capi/capifs.c	Wed Apr 24 17:50:15 2002
+++ edited/drivers/isdn/capi/capifs.c	Mon May 20 13:34:08 2002
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
-#include <linux/locks.h>
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
===== drivers/isdn/capi/kcapi.c 1.31 vs edited =====
--- 1.31/drivers/isdn/capi/kcapi.c	Sun May 19 08:56:35 2002
+++ edited/drivers/isdn/capi/kcapi.c	Mon May 20 13:34:10 2002
@@ -26,7 +26,6 @@
 #include <linux/tqueue.h>
 #include <linux/capi.h>
 #include <linux/kernelcapi.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/isdn/capicmd.h>
===== drivers/md/lvm.c 1.26 vs edited =====
--- 1.26/drivers/md/lvm.c	Wed Apr 24 22:00:40 2002
+++ edited/drivers/md/lvm.c	Mon May 20 13:34:14 2002
@@ -212,7 +212,6 @@
 #include <linux/proc_fs.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
-#include <linux/locks.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <asm/ioctl.h>
===== drivers/md/raid5.c 1.21 vs edited =====
--- 1.21/drivers/md/raid5.c	Wed May 15 07:00:01 2002
+++ edited/drivers/md/raid5.c	Mon May 20 13:34:18 2002
@@ -18,7 +18,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/raid/raid5.h>
 #include <asm/bitops.h>
===== drivers/media/video/i2c-old.c 1.3 vs edited =====
--- 1.3/drivers/media/video/i2c-old.c	Tue Feb  5 08:49:25 2002
+++ edited/drivers/media/video/i2c-old.c	Mon May 20 13:34:20 2002
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/delay.h>
-#include <linux/locks.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/i2c-old.h>
===== fs/binfmt_em86.c 1.3 vs edited =====
--- 1.3/fs/binfmt_em86.c	Mon Feb 25 19:35:33 2002
+++ edited/fs/binfmt_em86.c	Mon May 20 13:40:05 2002
@@ -12,7 +12,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/binfmts.h>
 #include <linux/elf.h>
===== fs/block_dev.c 1.56 vs edited =====
--- 1.56/fs/block_dev.c	Sun May 19 13:49:48 2002
+++ edited/fs/block_dev.c	Mon May 20 13:40:08 2002
@@ -8,7 +8,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/locks.h>
 #include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
===== fs/buffer.c 1.101 vs edited =====
--- 1.101/fs/buffer.c	Sun May 19 13:49:49 2002
+++ edited/fs/buffer.c	Mon May 20 13:40:11 2002
@@ -23,7 +23,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/file.h>
===== fs/super.c 1.70 vs edited =====
--- 1.70/fs/super.c	Sun May 19 13:49:49 2002
+++ edited/fs/super.c	Mon May 20 13:40:13 2002
@@ -22,7 +22,6 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/acct.h>
===== fs/adfs/inode.c 1.10 vs edited =====
--- 1.10/fs/adfs/inode.c	Fri Apr  5 15:20:28 2002
+++ edited/fs/adfs/inode.c	Mon May 20 13:34:22 2002
@@ -14,7 +14,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
===== fs/adfs/super.c 1.14 vs edited =====
--- 1.14/fs/adfs/super.c	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/super.c	Mon May 20 13:34:24 2002
@@ -16,7 +16,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 
 #include <asm/bitops.h>
===== fs/affs/amigaffs.c 1.11 vs edited =====
--- 1.11/fs/affs/amigaffs.c	Sun Mar 17 20:20:24 2002
+++ edited/fs/affs/amigaffs.c	Mon May 20 13:34:27 2002
@@ -13,7 +13,6 @@
 #include <linux/time.h>
 #include <linux/affs_fs.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/amigaffs.h>
 
===== fs/affs/bitmap.c 1.8 vs edited =====
--- 1.8/fs/affs/bitmap.c	Mon Mar 18 17:25:46 2002
+++ edited/fs/affs/bitmap.c	Mon May 20 13:34:29 2002
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/bitops.h>
 #include <linux/amigaffs.h>
 
===== fs/affs/file.c 1.17 vs edited =====
--- 1.17/fs/affs/file.c	Wed May  1 06:14:58 2002
+++ edited/fs/affs/file.c	Mon May 20 13:34:32 2002
@@ -22,7 +22,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/dirent.h>
 #include <linux/fs.h>
===== fs/affs/inode.c 1.13 vs edited =====
--- 1.13/fs/affs/inode.c	Fri Apr  5 15:20:28 2002
+++ edited/fs/affs/inode.c	Mon May 20 13:34:34 2002
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/genhd.h>
 #include <linux/amigaffs.h>
 #include <linux/major.h>
===== fs/affs/namei.c 1.16 vs edited =====
--- 1.16/fs/affs/namei.c	Sun Mar 17 20:20:24 2002
+++ edited/fs/affs/namei.c	Mon May 20 13:34:36 2002
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
-#include <linux/locks.h>
 #include <linux/amigaffs.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
===== fs/affs/super.c 1.23 vs edited =====
--- 1.23/fs/affs/super.c	Wed Apr 24 08:03:46 2002
+++ edited/fs/affs/super.c	Mon May 20 13:34:39 2002
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/genhd.h>
 #include <linux/amigaffs.h>
 #include <linux/major.h>
===== fs/autofs/inode.c 1.9 vs edited =====
--- 1.9/fs/autofs/inode.c	Thu May  2 06:54:14 2002
+++ edited/fs/autofs/inode.c	Mon May 20 13:34:41 2002
@@ -14,7 +14,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-#include <linux/locks.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
 #define __NO_VERSION__
===== fs/autofs4/inode.c 1.7 vs edited =====
--- 1.7/fs/autofs4/inode.c	Sat Mar 23 23:56:32 2002
+++ edited/fs/autofs4/inode.c	Mon May 20 13:49:29 2002
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-#include <linux/locks.h>
+#include <linux/pagemap.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
 #define __NO_VERSION__
===== fs/bfs/dir.c 1.14 vs edited =====
--- 1.14/fs/bfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/bfs/dir.c	Mon May 20 13:34:46 2002
@@ -7,7 +7,6 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/bfs_fs.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 #include "bfs_defs.h"
===== fs/bfs/file.c 1.6 vs edited =====
--- 1.6/fs/bfs/file.c	Sun Mar 17 11:36:53 2002
+++ edited/fs/bfs/file.c	Mon May 20 13:34:48 2002
@@ -5,7 +5,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/bfs_fs.h>
 #include <linux/smp_lock.h>
 #include "bfs_defs.h"
===== fs/bfs/inode.c 1.13 vs edited =====
--- 1.13/fs/bfs/inode.c	Tue Apr 23 12:56:42 2002
+++ edited/fs/bfs/inode.c	Mon May 20 13:34:50 2002
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/locks.h>
 #include <linux/bfs_fs.h>
 #include <linux/smp_lock.h>
 
===== fs/coda/cache.c 1.6 vs edited =====
--- 1.6/fs/coda/cache.c	Thu Feb 28 23:41:57 2002
+++ edited/fs/coda/cache.c	Mon May 20 13:34:52 2002
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/list.h>
===== fs/coda/coda_linux.c 1.5 vs edited =====
--- 1.5/fs/coda/coda_linux.c	Thu Feb 28 23:47:39 2002
+++ edited/fs/coda/coda_linux.c	Mon May 20 13:34:54 2002
@@ -14,7 +14,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 
===== fs/coda/dir.c 1.15 vs edited =====
--- 1.15/fs/coda/dir.c	Fri Mar  1 12:44:27 2002
+++ edited/fs/coda/dir.c	Mon May 20 13:34:56 2002
@@ -15,7 +15,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 
===== fs/coda/file.c 1.8 vs edited =====
--- 1.8/fs/coda/file.c	Thu Feb 28 23:41:57 2002
+++ edited/fs/coda/file.c	Mon May 20 13:34:59 2002
@@ -14,7 +14,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
===== fs/coda/inode.c 1.15 vs edited =====
--- 1.15/fs/coda/inode.c	Fri Apr  5 15:20:28 2002
+++ edited/fs/coda/inode.c	Mon May 20 13:35:01 2002
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/unistd.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
===== fs/coda/pioctl.c 1.6 vs edited =====
--- 1.6/fs/coda/pioctl.c	Thu Feb 28 23:41:57 2002
+++ edited/fs/coda/pioctl.c	Mon May 20 13:35:03 2002
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #define __NO_VERSION__
 #include <linux/module.h>
===== fs/coda/symlink.c 1.4 vs edited =====
--- 1.4/fs/coda/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/coda/symlink.c	Mon May 20 14:52:48 2002
@@ -13,7 +13,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
+#include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
 #include <linux/coda.h>
===== fs/coda/upcall.c 1.9 vs edited =====
--- 1.9/fs/coda/upcall.c	Thu Feb 28 23:41:57 2002
+++ edited/fs/coda/upcall.c	Mon May 20 13:35:07 2002
@@ -26,7 +26,6 @@
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
 #include <linux/vmalloc.h>
===== fs/cramfs/inode.c 1.20 vs edited =====
--- 1.20/fs/cramfs/inode.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/cramfs/inode.c	Mon May 20 13:35:10 2002
@@ -16,7 +16,6 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/cramfs_fs.h>
 #include <linux/smp_lock.h>
===== fs/devpts/inode.c 1.10 vs edited =====
--- 1.10/fs/devpts/inode.c	Thu Apr  4 00:00:01 2002
+++ edited/fs/devpts/inode.c	Mon May 20 13:35:16 2002
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
-#include <linux/locks.h>
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
===== fs/efs/super.c 1.9 vs edited =====
--- 1.9/fs/efs/super.c	Tue Mar 12 23:03:48 2002
+++ edited/fs/efs/super.c	Mon May 20 13:35:18 2002
@@ -8,7 +8,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/locks.h>
 #include <linux/efs_fs.h>
 #include <linux/efs_vh.h>
 #include <linux/efs_fs_sb.h>
===== fs/ext2/balloc.c 1.17 vs edited =====
--- 1.17/fs/ext2/balloc.c	Tue Mar 12 19:00:36 2002
+++ edited/fs/ext2/balloc.c	Mon May 20 13:35:21 2002
@@ -13,7 +13,6 @@
 
 #include <linux/config.h>
 #include "ext2.h"
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 
 /*
===== fs/ext2/fsync.c 1.6 vs edited =====
--- 1.6/fs/ext2/fsync.c	Sun May 19 13:49:46 2002
+++ edited/fs/ext2/fsync.c	Mon May 20 13:35:24 2002
@@ -23,7 +23,6 @@
  */
 
 #include "ext2.h"
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 
===== fs/ext2/ialloc.c 1.14 vs edited =====
--- 1.14/fs/ext2/ialloc.c	Sun May 19 13:49:49 2002
+++ edited/fs/ext2/ialloc.c	Mon May 20 13:35:26 2002
@@ -14,7 +14,6 @@
 
 #include <linux/config.h>
 #include "ext2.h"
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 
 
===== fs/ext2/inode.c 1.30 vs edited =====
--- 1.30/fs/ext2/inode.c	Sun May 19 13:49:49 2002
+++ edited/fs/ext2/inode.c	Mon May 20 13:49:47 2002
@@ -23,10 +23,10 @@
  */
 
 #include "ext2.h"
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/highuid.h>
+#include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/module.h>
 
===== fs/ext2/super.c 1.23 vs edited =====
--- 1.23/fs/ext2/super.c	Wed Apr 24 08:59:51 2002
+++ edited/fs/ext2/super.c	Mon May 20 13:35:32 2002
@@ -22,7 +22,6 @@
 #include "ext2.h"
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/random.h>
 #include <linux/smp_lock.h>
===== fs/ext3/balloc.c 1.4 vs edited =====
--- 1.4/fs/ext3/balloc.c	Thu Apr  4 12:39:47 2002
+++ edited/fs/ext3/balloc.c	Mon May 20 13:35:35 2002
@@ -17,7 +17,6 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 
 /*
===== fs/ext3/file.c 1.3 vs edited =====
--- 1.3/fs/ext3/file.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/ext3/file.c	Mon May 20 13:35:37 2002
@@ -20,7 +20,6 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
===== fs/ext3/ialloc.c 1.8 vs edited =====
--- 1.8/fs/ext3/ialloc.c	Thu Jan 31 15:34:41 2002
+++ edited/fs/ext3/ialloc.c	Mon May 20 13:35:39 2002
@@ -19,7 +19,6 @@
 #include <linux/ext3_jbd.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 
 #include <asm/bitops.h>
===== fs/ext3/inode.c 1.18 vs edited =====
--- 1.18/fs/ext3/inode.c	Sun May 19 13:49:46 2002
+++ edited/fs/ext3/inode.c	Mon May 20 13:50:43 2002
@@ -22,15 +22,16 @@
  *  Assorted race fixes, rewrite of ext3_get_block() by Al Viro, 2000
  */
 
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/time.h>
 #include <linux/ext3_jbd.h>
 #include <linux/jbd.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
+#include <linux/pagemap.h>
 #include <linux/quotaops.h>
-#include <linux/module.h>
+#include <linux/string.h>
 
 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the start
===== fs/ext3/namei.c 1.13 vs edited =====
--- 1.13/fs/ext3/namei.c	Tue May  7 06:34:46 2002
+++ edited/fs/ext3/namei.c	Mon May 20 13:35:44 2002
@@ -26,7 +26,6 @@
 #include <linux/fcntl.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 
===== fs/ext3/super.c 1.20 vs edited =====
--- 1.20/fs/ext3/super.c	Tue May  7 06:34:46 2002
+++ edited/fs/ext3/super.c	Mon May 20 13:35:46 2002
@@ -26,7 +26,6 @@
 #include <linux/ext3_jbd.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
===== fs/fat/file.c 1.12 vs edited =====
--- 1.12/fs/fat/file.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/fat/file.c	Mon May 20 13:35:48 2002
@@ -7,7 +7,6 @@
  */
 
 #include <linux/time.h>
-#include <linux/locks.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 #include <linux/smp_lock.h>
===== fs/fat/inode.c 1.38 vs edited =====
--- 1.38/fs/fat/inode.c	Tue May  7 06:35:29 2002
+++ edited/fs/fat/inode.c	Mon May 20 14:06:31 2002
@@ -12,11 +12,11 @@
 
 #include <linux/module.h>
 #include <linux/time.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
+#include <linux/pagemap.h>
 
 //#include <asm/uaccess.h>
 #include <asm/unaligned.h>
===== fs/hpfs/file.c 1.8 vs edited =====
--- 1.8/fs/hpfs/file.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/hpfs/file.c	Mon May 20 14:54:41 2002
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
+#include <linux/pagemap.h>
 #include "hpfs_fn.h"
 
 #define BLOCKS(size) (((size) + 511) >> 9)
===== fs/hpfs/hpfs_fn.h 1.6 vs edited =====
--- 1.6/fs/hpfs/hpfs_fn.h	Sat Feb  9 04:10:55 2002
+++ edited/fs/hpfs/hpfs_fn.h	Mon May 20 14:24:01 2002
@@ -16,7 +16,6 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
-#include <linux/locks.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <asm/bitops.h>
===== fs/hpfs/inode.c 1.8 vs edited =====
--- 1.8/fs/hpfs/inode.c	Fri Apr  5 15:20:28 2002
+++ edited/fs/hpfs/inode.c	Mon May 20 15:01:05 2002
@@ -6,6 +6,7 @@
  *  inode VFS functions
  */
 
+#include <linux/fs.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
 #include "hpfs_fn.h"
===== fs/hpfs/namei.c 1.12 vs edited =====
--- 1.12/fs/hpfs/namei.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/hpfs/namei.c	Mon May 20 14:55:37 2002
@@ -6,6 +6,7 @@
  *  adding & removing files & directories
  */
 
+#include <linux/pagemap.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 
===== fs/intermezzo/cache.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/cache.c	Thu Feb 28 11:55:14 2002
+++ edited/fs/intermezzo/cache.c	Mon May 20 13:35:55 2002
@@ -22,7 +22,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 
===== fs/intermezzo/dcache.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/dcache.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/dcache.c	Mon May 20 13:36:01 2002
@@ -14,7 +14,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
===== fs/intermezzo/dir.c 1.5 vs edited =====
--- 1.5/fs/intermezzo/dir.c	Tue Apr 16 07:16:09 2002
+++ edited/fs/intermezzo/dir.c	Mon May 20 13:36:03 2002
@@ -24,7 +24,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #define __NO_VERSION__
===== fs/intermezzo/ext_attr.c 1.3 vs edited =====
--- 1.3/fs/intermezzo/ext_attr.c	Sun May 19 07:01:50 2002
+++ edited/fs/intermezzo/ext_attr.c	Mon May 20 13:36:06 2002
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/unistd.h>
 
 #include <asm/system.h>
===== fs/intermezzo/file.c 1.3 vs edited =====
--- 1.3/fs/intermezzo/file.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/file.c	Mon May 20 13:36:08 2002
@@ -31,7 +31,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
===== fs/intermezzo/inode.c 1.3 vs edited =====
--- 1.3/fs/intermezzo/inode.c	Thu Feb 28 11:55:14 2002
+++ edited/fs/intermezzo/inode.c	Mon May 20 14:56:02 2002
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/unistd.h>
 
 #include <asm/system.h>
@@ -24,7 +23,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
 #include <linux/slab.h>
===== fs/intermezzo/journal.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/journal.c	Tue Feb  5 16:23:08 2002
+++ edited/fs/intermezzo/journal.c	Mon May 20 13:36:12 2002
@@ -13,7 +13,6 @@
 #include <linux/vmalloc.h>
 #include <linux/time.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
===== fs/intermezzo/journal_ext2.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/journal_ext2.c	Tue Mar 12 19:00:28 2002
+++ edited/fs/intermezzo/journal_ext2.c	Mon May 20 13:36:15 2002
@@ -11,7 +11,6 @@
 #include <linux/vmalloc.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/ext2_fs.h> 
===== fs/intermezzo/journal_ext3.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/journal_ext3.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/journal_ext3.c	Mon May 20 13:36:17 2002
@@ -16,7 +16,6 @@
 #include <linux/vmalloc.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
===== fs/intermezzo/journal_obdfs.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/journal_obdfs.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/journal_obdfs.c	Mon May 20 13:36:30 2002
@@ -16,7 +16,6 @@
 #include <linux/vmalloc.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #ifdef CONFIG_OBDFS_FS
===== fs/intermezzo/journal_reiserfs.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/journal_reiserfs.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/journal_reiserfs.c	Mon May 20 13:36:45 2002
@@ -16,7 +16,6 @@
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #if 0
===== fs/intermezzo/journal_xfs.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/journal_xfs.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/journal_xfs.c	Mon May 20 13:36:48 2002
@@ -11,7 +11,6 @@
 #include <linux/vmalloc.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #ifdef CONFIG_FS_XFS
===== fs/intermezzo/methods.c 1.3 vs edited =====
--- 1.3/fs/intermezzo/methods.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/methods.c	Mon May 20 13:36:52 2002
@@ -23,7 +23,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #define __NO_VERSION__
===== fs/intermezzo/presto.c 1.8 vs edited =====
--- 1.8/fs/intermezzo/presto.c	Sat Mar  2 05:19:52 2002
+++ edited/fs/intermezzo/presto.c	Mon May 20 13:36:54 2002
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <asm/uaccess.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
===== fs/intermezzo/super.c 1.5 vs edited =====
--- 1.5/fs/intermezzo/super.c	Thu Apr  4 00:00:02 2002
+++ edited/fs/intermezzo/super.c	Mon May 20 13:36:56 2002
@@ -23,7 +23,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #define __NO_VERSION__
===== fs/intermezzo/upcall.c 1.3 vs edited =====
--- 1.3/fs/intermezzo/upcall.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/intermezzo/upcall.c	Mon May 20 13:36:58 2002
@@ -32,7 +32,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
 #include <linux/vmalloc.h>
===== fs/isofs/compress.c 1.8 vs edited =====
--- 1.8/fs/isofs/compress.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/isofs/compress.c	Mon May 20 13:37:01 2002
@@ -26,7 +26,6 @@
 #include <linux/major.h>
 #include <linux/mm.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/cdrom.h>
===== fs/isofs/dir.c 1.7 vs edited =====
--- 1.7/fs/isofs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/isofs/dir.c	Mon May 20 13:37:03 2002
@@ -19,7 +19,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/time.h>
-#include <linux/locks.h>
 #include <linux/config.h>
 #include <linux/smp_lock.h>
 
===== fs/isofs/inode.c 1.20 vs edited =====
--- 1.20/fs/isofs/inode.c	Fri May 10 07:26:16 2002
+++ edited/fs/isofs/inode.c	Mon May 20 13:37:05 2002
@@ -19,7 +19,6 @@
 #include <linux/major.h>
 #include <linux/mm.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/cdrom.h>
===== fs/jbd/checkpoint.c 1.3 vs edited =====
--- 1.3/fs/jbd/checkpoint.c	Tue Apr 30 00:18:28 2002
+++ edited/fs/jbd/checkpoint.c	Mon May 20 13:37:07 2002
@@ -22,7 +22,6 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 
 extern spinlock_t journal_datalist_lock;
 
===== fs/jbd/commit.c 1.9 vs edited =====
--- 1.9/fs/jbd/commit.c	Sun May  5 15:32:04 2002
+++ edited/fs/jbd/commit.c	Mon May 20 13:37:10 2002
@@ -18,7 +18,6 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 extern spinlock_t journal_datalist_lock;
===== fs/jbd/journal.c 1.13 vs edited =====
--- 1.13/fs/jbd/journal.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/jbd/journal.c	Mon May 20 13:51:35 2002
@@ -28,11 +28,11 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 
===== fs/jbd/recovery.c 1.7 vs edited =====
--- 1.7/fs/jbd/recovery.c	Sun May 19 13:49:46 2002
+++ edited/fs/jbd/recovery.c	Mon May 20 13:37:14 2002
@@ -21,7 +21,6 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #endif
 
 /*
===== fs/jbd/revoke.c 1.7 vs edited =====
--- 1.7/fs/jbd/revoke.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/jbd/revoke.c	Mon May 20 13:37:22 2002
@@ -65,7 +65,6 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
===== fs/jbd/transaction.c 1.14 vs edited =====
--- 1.14/fs/jbd/transaction.c	Sun May 19 13:49:50 2002
+++ edited/fs/jbd/transaction.c	Mon May 20 13:51:16 2002
@@ -22,10 +22,10 @@
 #include <linux/jbd.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/timer.h>
 #include <linux/smp_lock.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 
 extern spinlock_t journal_datalist_lock;
 
===== fs/jffs/inode-v23.c 1.29 vs edited =====
--- 1.29/fs/jffs/inode-v23.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/jffs/inode-v23.c	Mon May 20 13:37:30 2002
@@ -42,7 +42,6 @@
 #include <linux/slab.h>
 #include <linux/jffs.h>
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/ioctl.h>
 #include <linux/stat.h>
===== fs/jffs/intrep.c 1.11 vs edited =====
--- 1.11/fs/jffs/intrep.c	Thu Feb 28 11:56:44 2002
+++ edited/fs/jffs/intrep.c	Mon May 20 13:37:32 2002
@@ -63,7 +63,6 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/pagemap.h>
-#include <linux/locks.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 #include <linux/version.h>
===== fs/jfs/file.c 1.3 vs edited =====
--- 1.3/fs/jfs/file.c	Mon Apr 29 18:41:42 2002
+++ edited/fs/jfs/file.c	Mon May 20 13:40:15 2002
@@ -17,7 +17,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include "jfs_incore.h"
 #include "jfs_txnmgr.h"
 #include "jfs_debug.h"
===== fs/jfs/inode.c 1.4 vs edited =====
--- 1.4/fs/jfs/inode.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/jfs/inode.c	Mon May 20 13:40:18 2002
@@ -17,7 +17,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_imap.h"
===== fs/jfs/jfs_dtree.c 1.9 vs edited =====
--- 1.9/fs/jfs/jfs_dtree.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/jfs/jfs_dtree.c	Mon May 20 13:40:20 2002
@@ -101,7 +101,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include "jfs_incore.h"
 #include "jfs_superblock.h"
===== fs/jfs/jfs_imap.c 1.5 vs edited =====
--- 1.5/fs/jfs/jfs_imap.c	Tue Apr 30 00:18:54 2002
+++ edited/fs/jfs/jfs_imap.c	Mon May 20 13:40:23 2002
@@ -42,7 +42,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_dinode.h"
===== fs/jfs/jfs_logmgr.c 1.13 vs edited =====
--- 1.13/fs/jfs/jfs_logmgr.c	Thu May  9 10:13:46 2002
+++ edited/fs/jfs/jfs_logmgr.c	Mon May 20 13:40:25 2002
@@ -59,7 +59,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
===== fs/jfs/jfs_txnmgr.c 1.8 vs edited =====
--- 1.8/fs/jfs/jfs_txnmgr.c	Fri May 10 23:30:40 2002
+++ edited/fs/jfs/jfs_txnmgr.c	Mon May 20 13:40:27 2002
@@ -43,7 +43,6 @@
 
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
===== fs/jfs/jfs_xtree.c 1.2 vs edited =====
--- 1.2/fs/jfs/jfs_xtree.c	Thu Apr  4 18:41:58 2002
+++ edited/fs/jfs/jfs_xtree.c	Mon May 20 13:40:29 2002
@@ -20,7 +20,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
===== fs/jfs/namei.c 1.7 vs edited =====
--- 1.7/fs/jfs/namei.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/jfs/namei.c	Mon May 20 13:40:32 2002
@@ -17,7 +17,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include "jfs_incore.h"
 #include "jfs_inode.h"
 #include "jfs_dinode.h"
===== fs/jfs/super.c 1.10 vs edited =====
--- 1.10/fs/jfs/super.c	Tue Apr 30 00:18:54 2002
+++ edited/fs/jfs/super.c	Mon May 20 13:40:34 2002
@@ -17,7 +17,6 @@
  */
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/completion.h>
===== fs/minix/inode.c 1.22 vs edited =====
--- 1.22/fs/minix/inode.c	Wed Mar 20 11:06:57 2002
+++ edited/fs/minix/inode.c	Mon May 20 13:37:34 2002
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include "minix.h"
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
 
===== fs/minix/itree_v1.c 1.6 vs edited =====
--- 1.6/fs/minix/itree_v1.c	Wed Mar 20 08:19:19 2002
+++ edited/fs/minix/itree_v1.c	Mon May 20 13:37:40 2002
@@ -1,5 +1,4 @@
 #include "minix.h"
-#include <linux/locks.h>
 
 enum {DEPTH = 3, DIRECT = 7};	/* Only double indirect */
 
===== fs/minix/itree_v2.c 1.6 vs edited =====
--- 1.6/fs/minix/itree_v2.c	Wed Mar 20 08:19:33 2002
+++ edited/fs/minix/itree_v2.c	Mon May 20 13:37:43 2002
@@ -1,5 +1,4 @@
 #include "minix.h"
-#include <linux/locks.h>
 
 enum {DIRECT = 7, DEPTH = 4};	/* Have triple indirect */
 
===== fs/ncpfs/dir.c 1.15 vs edited =====
--- 1.15/fs/ncpfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/ncpfs/dir.c	Mon May 20 13:37:45 2002
@@ -20,7 +20,6 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 #include <linux/ncp_fs.h>
===== fs/ncpfs/file.c 1.8 vs edited =====
--- 1.8/fs/ncpfs/file.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/ncpfs/file.c	Mon May 20 13:37:48 2002
@@ -15,7 +15,6 @@
 #include <linux/fcntl.h>
 #include <linux/stat.h>
 #include <linux/mm.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
===== fs/ncpfs/inode.c 1.17 vs edited =====
--- 1.17/fs/ncpfs/inode.c	Sat Apr  6 15:22:56 2002
+++ edited/fs/ncpfs/inode.c	Mon May 20 13:37:50 2002
@@ -21,7 +21,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/slab.h>
===== fs/nfs/inode.c 1.29 vs edited =====
--- 1.29/fs/nfs/inode.c	Tue Apr 30 00:18:54 2002
+++ edited/fs/nfs/inode.c	Mon May 20 13:37:52 2002
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/unistd.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/stats.h>
===== fs/nfsd/nfs3proc.c 1.9 vs edited =====
--- 1.9/fs/nfsd/nfs3proc.c	Fri Apr  5 05:33:40 2002
+++ edited/fs/nfsd/nfs3proc.c	Mon May 20 13:38:11 2002
@@ -9,7 +9,6 @@
 #include <linux/linkage.h>
 #include <linux/time.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/stat.h>
===== fs/nfsd/nfsproc.c 1.12 vs edited =====
--- 1.12/fs/nfsd/nfsproc.c	Fri Apr  5 05:33:40 2002
+++ edited/fs/nfsd/nfsproc.c	Mon May 20 13:38:13 2002
@@ -10,7 +10,6 @@
 #include <linux/linkage.h>
 #include <linux/time.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
===== fs/nfsd/vfs.c 1.27 vs edited =====
--- 1.27/fs/nfsd/vfs.c	Wed May 15 07:14:49 2002
+++ edited/fs/nfsd/vfs.c	Mon May 20 13:38:16 2002
@@ -20,7 +20,6 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/ext2_fs.h>
===== fs/ntfs/aops.c 1.69 vs edited =====
--- 1.69/fs/ntfs/aops.c	Sat May 11 14:17:56 2002
+++ edited/fs/ntfs/aops.c	Mon May 20 13:38:18 2002
@@ -25,7 +25,6 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/locks.h>
 
 #include "ntfs.h"
 
===== fs/ntfs/compress.c 1.40 vs edited =====
--- 1.40/fs/ntfs/compress.c	Sat May  4 23:07:28 2002
+++ edited/fs/ntfs/compress.c	Mon May 20 13:38:20 2002
@@ -21,7 +21,6 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/locks.h>
 #include <linux/fs.h>
 
 #include "ntfs.h"
===== fs/ntfs/mft.c 1.58 vs edited =====
--- 1.58/fs/ntfs/mft.c	Sat May 11 14:17:56 2002
+++ edited/fs/ntfs/mft.c	Mon May 20 13:38:22 2002
@@ -20,7 +20,6 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/locks.h>
 #include <linux/swap.h>
 
 #include "ntfs.h"
===== fs/ntfs/super.c 1.99 vs edited =====
--- 1.99/fs/ntfs/super.c	Sun May 19 13:49:48 2002
+++ edited/fs/ntfs/super.c	Mon May 20 13:38:24 2002
@@ -23,7 +23,6 @@
 #include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
 #include <linux/backing-dev.h>
===== fs/openpromfs/inode.c 1.12 vs edited =====
--- 1.12/fs/openpromfs/inode.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/openpromfs/inode.c	Mon May 20 13:38:26 2002
@@ -10,7 +10,6 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/openprom_fs.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
===== fs/proc/inode.c 1.12 vs edited =====
--- 1.12/fs/proc/inode.c	Thu Apr  4 00:00:02 2002
+++ edited/fs/proc/inode.c	Mon May 20 13:38:28 2002
@@ -11,7 +11,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/file.h>
-#include <linux/locks.h>
 #include <linux/limits.h>
 #include <linux/init.h>
 #define __NO_VERSION__
===== fs/qnx4/fsync.c 1.5 vs edited =====
--- 1.5/fs/qnx4/fsync.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/qnx4/fsync.c	Mon May 20 13:38:30 2002
@@ -15,7 +15,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 #include <linux/fs.h>
===== fs/qnx4/inode.c 1.17 vs edited =====
--- 1.17/fs/qnx4/inode.c	Tue Apr 23 12:35:51 2002
+++ edited/fs/qnx4/inode.c	Mon May 20 15:07:51 2002
@@ -20,10 +20,10 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/qnx4_fs.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/smp_lock.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 
===== fs/qnx4/truncate.c 1.4 vs edited =====
--- 1.4/fs/qnx4/truncate.c	Tue Feb 12 02:41:50 2002
+++ edited/fs/qnx4/truncate.c	Mon May 20 13:38:34 2002
@@ -15,7 +15,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/qnx4_fs.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
===== fs/ramfs/inode.c 1.16 vs edited =====
--- 1.16/fs/ramfs/inode.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/ramfs/inode.c	Mon May 20 13:38:36 2002
@@ -28,7 +28,6 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
===== fs/reiserfs/bitmap.c 1.15 vs edited =====
--- 1.15/fs/reiserfs/bitmap.c	Thu Feb 28 02:05:34 2002
+++ edited/fs/reiserfs/bitmap.c	Mon May 20 13:38:38 2002
@@ -5,7 +5,6 @@
 #include <linux/config.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
-#include <linux/locks.h>
 #include <asm/bitops.h>
 #include <linux/list.h>
 
===== fs/reiserfs/buffer2.c 1.11 vs edited =====
--- 1.11/fs/reiserfs/buffer2.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/reiserfs/buffer2.c	Mon May 20 13:38:41 2002
@@ -4,7 +4,6 @@
 
 #include <linux/config.h>
 #include <linux/time.h>
-#include <linux/locks.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
===== fs/reiserfs/fix_node.c 1.20 vs edited =====
--- 1.20/fs/reiserfs/fix_node.c	Wed Mar 27 20:38:22 2002
+++ edited/fs/reiserfs/fix_node.c	Mon May 20 13:38:44 2002
@@ -38,7 +38,6 @@
 #include <linux/config.h>
 #include <linux/time.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/reiserfs_fs.h>
 
 
===== fs/reiserfs/inode.c 1.56 vs edited =====
--- 1.56/fs/reiserfs/inode.c	Sun May 19 13:49:47 2002
+++ edited/fs/reiserfs/inode.c	Mon May 20 15:06:22 2002
@@ -5,8 +5,8 @@
 #include <linux/config.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
===== fs/reiserfs/ioctl.c 1.7 vs edited =====
--- 1.7/fs/reiserfs/ioctl.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/reiserfs/ioctl.c	Mon May 20 15:06:32 2002
@@ -6,8 +6,8 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/time.h>
 #include <asm/uaccess.h>
+#include <linux/pagemap.h>
 #include <linux/smp_lock.h>
-#include <linux/locks.h>
 
 /*
 ** reiserfs_ioctl - handler for ioctl for inode
===== fs/reiserfs/journal.c 1.39 vs edited =====
--- 1.39/fs/reiserfs/journal.c	Tue May 14 18:27:06 2002
+++ edited/fs/reiserfs/journal.c	Mon May 20 13:38:54 2002
@@ -54,7 +54,6 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/fcntl.h>
-#include <linux/locks.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
===== fs/reiserfs/objectid.c 1.10 vs edited =====
--- 1.10/fs/reiserfs/objectid.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/reiserfs/objectid.c	Mon May 20 13:38:56 2002
@@ -4,7 +4,6 @@
 
 #include <linux/config.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/random.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
===== fs/reiserfs/procfs.c 1.7 vs edited =====
--- 1.7/fs/reiserfs/procfs.c	Wed Apr 24 22:00:41 2002
+++ edited/fs/reiserfs/procfs.c	Mon May 20 13:38:59 2002
@@ -17,7 +17,6 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/smp_lock.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 
===== fs/reiserfs/resize.c 1.6 vs edited =====
--- 1.6/fs/reiserfs/resize.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/reiserfs/resize.c	Mon May 20 13:39:01 2002
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/reiserfs_fs.h>
===== fs/reiserfs/stree.c 1.27 vs edited =====
--- 1.27/fs/reiserfs/stree.c	Wed Apr 24 22:00:41 2002
+++ edited/fs/reiserfs/stree.c	Mon May 20 13:39:03 2002
@@ -56,7 +56,6 @@
 #include <linux/config.h>
 #include <linux/time.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/pagemap.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
===== fs/reiserfs/super.c 1.37 vs edited =====
--- 1.37/fs/reiserfs/super.c	Tue May  7 06:35:15 2002
+++ edited/fs/reiserfs/super.c	Mon May 20 13:39:05 2002
@@ -17,7 +17,6 @@
 #include <asm/uaccess.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
-#include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
 
===== fs/reiserfs/tail_conversion.c 1.19 vs edited =====
--- 1.19/fs/reiserfs/tail_conversion.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/reiserfs/tail_conversion.c	Mon May 20 13:39:07 2002
@@ -6,7 +6,6 @@
 #include <linux/time.h>
 #include <linux/pagemap.h>
 #include <linux/reiserfs_fs.h>
-#include <linux/locks.h>
 
 /* access to tail : when one is going to read tail it must make sure, that is not running.
  direct2indirect and indirect2direct can not run concurrently */
===== fs/romfs/inode.c 1.18 vs edited =====
--- 1.18/fs/romfs/inode.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/romfs/inode.c	Mon May 20 15:05:58 2002
@@ -70,8 +70,8 @@
 #include <linux/slab.h>
 #include <linux/romfs_fs.h>
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/init.h>
+#include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
===== fs/smbfs/inode.c 1.20 vs edited =====
--- 1.20/fs/smbfs/inode.c	Tue Apr 30 00:18:54 2002
+++ edited/fs/smbfs/inode.c	Mon May 20 13:39:15 2002
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/file.h>
===== fs/sysv/balloc.c 1.7 vs edited =====
--- 1.7/fs/sysv/balloc.c	Tue Apr 30 23:36:38 2002
+++ edited/fs/sysv/balloc.c	Mon May 20 13:39:18 2002
@@ -19,7 +19,6 @@
  *  This file contains code for allocating/freeing blocks.
  */
 
-#include <linux/locks.h>
 #include "sysv.h"
 
 /* We don't trust the value of
===== fs/sysv/ialloc.c 1.9 vs edited =====
--- 1.9/fs/sysv/ialloc.c	Wed Apr  3 15:50:40 2002
+++ edited/fs/sysv/ialloc.c	Mon May 20 14:07:13 2002
@@ -21,9 +21,9 @@
 
 #include <linux/kernel.h>
 #include <linux/stddef.h>
+#include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include "sysv.h"
 
 /* We don't trust the value of
===== fs/sysv/inode.c 1.19 vs edited =====
--- 1.19/fs/sysv/inode.c	Mon Apr 29 13:03:10 2002
+++ edited/fs/sysv/inode.c	Mon May 20 13:39:22 2002
@@ -21,7 +21,6 @@
  *  the superblock.
  */
 
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
 #include <linux/slab.h>
===== fs/sysv/itree.c 1.10 vs edited =====
--- 1.10/fs/sysv/itree.c	Tue Apr 30 23:36:38 2002
+++ edited/fs/sysv/itree.c	Mon May 20 13:39:26 2002
@@ -5,7 +5,6 @@
  *  AV, Sep--Dec 2000
  */
 
-#include <linux/locks.h>
 #include "sysv.h"
 
 enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
===== fs/udf/balloc.c 1.7 vs edited =====
--- 1.7/fs/udf/balloc.c	Wed Mar 13 00:56:21 2002
+++ edited/fs/udf/balloc.c	Mon May 20 13:39:29 2002
@@ -26,7 +26,6 @@
 
 #include "udfdecl.h"
 
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 #include <asm/bitops.h>
 
===== fs/udf/file.c 1.8 vs edited =====
--- 1.8/fs/udf/file.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/udf/file.c	Mon May 20 14:56:47 2002
@@ -37,8 +37,8 @@
 #include <linux/kernel.h>
 #include <linux/string.h> /* memset */
 #include <linux/errno.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
+#include <linux/pagemap.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/fsync.c 1.6 vs edited =====
--- 1.6/fs/udf/fsync.c	Sun May 19 13:49:46 2002
+++ edited/fs/udf/fsync.c	Mon May 20 13:39:33 2002
@@ -26,7 +26,6 @@
 #include "udfdecl.h"
 
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 /*
===== fs/udf/ialloc.c 1.7 vs edited =====
--- 1.7/fs/udf/ialloc.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/ialloc.c	Mon May 20 13:39:35 2002
@@ -25,7 +25,6 @@
 
 #include "udfdecl.h"
 #include <linux/fs.h>
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 #include <linux/udf_fs.h>
 
===== fs/udf/inode.c 1.19 vs edited =====
--- 1.19/fs/udf/inode.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/udf/inode.c	Mon May 20 14:56:21 2002
@@ -34,10 +34,10 @@
  */
 
 #include "udfdecl.h"
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/pagemap.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/namei.c 1.18 vs edited =====
--- 1.18/fs/udf/namei.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/udf/namei.c	Mon May 20 13:39:42 2002
@@ -33,7 +33,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/quotaops.h>
-#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 static inline int udf_match(int len, const char * const name, struct qstr *qs)
===== fs/udf/super.c 1.21 vs edited =====
--- 1.21/fs/udf/super.c	Wed Apr 24 08:59:51 2002
+++ edited/fs/udf/super.c	Mon May 20 13:39:44 2002
@@ -50,7 +50,6 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
-#include <linux/locks.h>
 #include <linux/module.h>
 #include <linux/stat.h>
 #include <linux/cdrom.h>
===== fs/ufs/balloc.c 1.11 vs edited =====
--- 1.11/fs/ufs/balloc.c	Mon May  6 18:18:23 2002
+++ edited/fs/ufs/balloc.c	Mon May 20 13:39:46 2002
@@ -11,7 +11,6 @@
 #include <linux/stat.h>
 #include <linux/time.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
===== fs/ufs/cylinder.c 1.4 vs edited =====
--- 1.4/fs/ufs/cylinder.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/ufs/cylinder.c	Mon May 20 13:39:48 2002
@@ -13,7 +13,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
===== fs/ufs/dir.c 1.6 vs edited =====
--- 1.6/fs/ufs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/ufs/dir.c	Mon May 20 13:39:50 2002
@@ -14,7 +14,6 @@
  */
 
 #include <linux/time.h>
-#include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
===== fs/ufs/file.c 1.6 vs edited =====
--- 1.6/fs/ufs/file.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/ufs/file.c	Mon May 20 13:39:53 2002
@@ -32,7 +32,6 @@
 #include <linux/fcntl.h>
 #include <linux/time.h>
 #include <linux/stat.h>
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
===== fs/ufs/ialloc.c 1.6 vs edited =====
--- 1.6/fs/ufs/ialloc.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/ufs/ialloc.c	Mon May 20 13:39:55 2002
@@ -25,7 +25,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/quotaops.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
===== fs/ufs/inode.c 1.10 vs edited =====
--- 1.10/fs/ufs/inode.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/ufs/inode.c	Mon May 20 13:39:56 2002
@@ -34,7 +34,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 
===== fs/ufs/super.c 1.20 vs edited =====
--- 1.20/fs/ufs/super.c	Fri May  3 06:52:18 2002
+++ edited/fs/ufs/super.c	Mon May 20 13:39:59 2002
@@ -77,7 +77,6 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
===== fs/ufs/truncate.c 1.10 vs edited =====
--- 1.10/fs/ufs/truncate.c	Tue Feb 12 02:46:31 2002
+++ edited/fs/ufs/truncate.c	Mon May 20 13:40:01 2002
@@ -35,7 +35,6 @@
 #include <linux/fcntl.h>
 #include <linux/time.h>
 #include <linux/stat.h>
-#include <linux/locks.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 
===== fs/ufs/util.c 1.7 vs edited =====
--- 1.7/fs/ufs/util.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/ufs/util.c	Mon May 20 13:40:03 2002
@@ -8,7 +8,6 @@
  
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/locks.h>
 #include <linux/ufs_fs.h>
 
 #include "swab.h"
===== include/linux/amigaffs.h 1.9 vs edited =====
--- 1.9/include/linux/amigaffs.h	Mon Apr 29 19:04:54 2002
+++ edited/include/linux/amigaffs.h	Mon May 20 14:22:37 2002
@@ -2,7 +2,6 @@
 #define AMIGAFFS_H
 
 #include <linux/types.h>
-#include <linux/locks.h>
 
 #include <asm/byteorder.h>
 
===== include/linux/blk.h 1.18 vs edited =====
--- 1.18/include/linux/blk.h	Tue Apr 23 20:24:38 2002
+++ edited/include/linux/blk.h	Mon May 20 15:07:56 2002
@@ -3,7 +3,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
-#include <linux/locks.h>
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/compiler.h>
===== include/linux/fs.h 1.114 vs edited =====
--- 1.114/include/linux/fs.h	Sun May 19 13:52:27 2002
+++ edited/include/linux/fs.h	Mon May 20 13:43:51 2002
@@ -662,6 +662,19 @@
 };
 
 /*
+ * Superblock locking.
+ */
+static inline void lock_super(struct super_block * sb)
+{
+	down(&sb->s_lock);
+}
+
+static inline void unlock_super(struct super_block * sb)
+{
+	up(&sb->s_lock);
+}
+
+/*
  * VFS helper functions..
  */
 extern int vfs_create(struct inode *, struct dentry *, int);
===== include/linux/hfs_sysdep.h 1.5 vs edited =====
--- 1.5/include/linux/hfs_sysdep.h	Sat Mar 16 13:59:37 2002
+++ edited/include/linux/hfs_sysdep.h	Mon May 20 14:54:06 2002
@@ -19,8 +19,8 @@
 
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/locks.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
===== include/linux/nbd.h 1.7 vs edited =====
--- 1.7/include/linux/nbd.h	Sun Mar 31 15:43:18 2002
+++ edited/include/linux/nbd.h	Mon May 20 13:40:45 2002
@@ -22,7 +22,6 @@
 
 #ifdef MAJOR_NR
 
-#include <linux/locks.h>
 #include <asm/semaphore.h>
 
 #define LOCAL_END_REQUEST
===== include/linux/swap.h 1.42 vs edited =====
--- 1.42/include/linux/swap.h	Sun May  5 18:55:39 2002
+++ edited/include/linux/swap.h	Mon May 20 15:07:21 2002
@@ -91,6 +91,7 @@
 	int next;			/* next entry on swap list */
 };
 
+struct inode;
 extern int nr_swap_pages;
 
 /* Swap 50% full? Release swapcache more aggressively.. */
===== include/linux/ufs_fs.h 1.4 vs edited =====
--- 1.4/include/linux/ufs_fs.h	Tue Feb  5 16:24:38 2002
+++ edited/include/linux/ufs_fs.h	Mon May 20 14:07:41 2002
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/stat.h>
+#include <linux/fs.h>
 
 #define UFS_BBLOCK 0
 #define UFS_BBSIZE 8192
===== include/linux/raid/md.h 1.9 vs edited =====
--- 1.9/include/linux/raid/md.h	Wed Apr 24 22:00:41 2002
+++ edited/include/linux/raid/md.h	Mon May 20 15:12:11 2002
@@ -31,7 +31,6 @@
 #include <linux/delay.h>
 #include <net/checksum.h>
 #include <linux/random.h>
-#include <linux/locks.h>
 #include <linux/kernel_stat.h>
 #include <asm/io.h>
 #include <linux/completion.h>
===== kernel/ksyms.c 1.85 vs edited =====
--- 1.85/kernel/ksyms.c	Wed May 15 19:31:10 2002
+++ edited/kernel/ksyms.c	Mon May 20 13:40:50 2002
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/serial.h>
-#include <linux/locks.h>
 #include <linux/delay.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
===== mm/page_io.c 1.13 vs edited =====
--- 1.13/mm/page_io.c	Mon May  6 17:24:09 2002
+++ edited/mm/page_io.c	Mon May 20 13:49:11 2002
@@ -12,8 +12,8 @@
 
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
+#include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/locks.h>
 #include <linux/swapctl.h>
 
 #include <asm/pgtable.h>
===== mm/shmem.c 1.49 vs edited =====
--- 1.49/mm/shmem.c	Sun May 19 13:49:50 2002
+++ edited/mm/shmem.c	Mon May 20 13:40:55 2002
@@ -25,7 +25,6 @@
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/string.h>
-#include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/shmem_fs.h>
===== net/khttpd/datasending.c 1.4 vs edited =====
--- 1.4/net/khttpd/datasending.c	Mon Feb 11 08:06:55 2002
+++ edited/net/khttpd/datasending.c	Mon May 20 13:40:57 2002
@@ -36,7 +36,6 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/locks.h>
 #include <linux/skbuff.h>
 
 #include <net/tcp.h>
--- a/include/linux/locks.h	Mon May 20 15:21:20 2002
+++ /dev/null	Thu Dec 13 11:34:58 2001
@@ -1,28 +0,0 @@
-#ifndef _LINUX_LOCKS_H
-#define _LINUX_LOCKS_H
-
-#ifndef _LINUX_MM_H
-#include <linux/mm.h>
-#endif
-#ifndef _LINUX_PAGEMAP_H
-#include <linux/pagemap.h>
-#endif
-
-/*
- * super-block locking. Again, interrupts may only unlock
- * a super-block (although even this isn't done right now.
- * nfs may need it).
- */
-
-static inline void lock_super(struct super_block * sb)
-{
-	down(&sb->s_lock);
-}
-
-static inline void unlock_super(struct super_block * sb)
-{
-	up(&sb->s_lock);
-}
-
-#endif /* _LINUX_LOCKS_H */
-
