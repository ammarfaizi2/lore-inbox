Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbSKQWVS>; Sun, 17 Nov 2002 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSKQWVS>; Sun, 17 Nov 2002 17:21:18 -0500
Received: from verein.lst.de ([212.34.181.86]:52242 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S266974AbSKQWVH>;
	Sun, 17 Nov 2002 17:21:07 -0500
Date: Sun, 17 Nov 2002 23:28:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pull even more crap out of fs.h
Message-ID: <20021117232804.A9608@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this time tested with acme's monster .config that takes
 hours to compile..]

Don't include the following headers implicitly through fs.h:

- stddef.h
- string.h
- bitops.h
- pipe_fs_i.h
- ext3_fs_i.h
- efs_fs_i.h

and fixup the fallout..


--- 1.25/drivers/char/raw.c	Sun Nov 10 19:53:10 2002
+++ edited/drivers/char/raw.c	Sun Nov 17 20:42:39 2002
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/raw.h>
 #include <linux/capability.h>
-
+#include <linux/uio.h>
 #include <asm/uaccess.h>
 
 struct raw_device_data {
===== drivers/char/sx.c 1.13 vs edited =====
--- 1.13/drivers/char/sx.c	Tue Nov  5 10:39:51 2002
+++ edited/drivers/char/sx.c	Sun Nov 17 20:41:39 2002
@@ -225,6 +225,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
+#include <linux/bitops.h>
 
 /* The 3.0.0 version of sxboards/sxwindow.h  uses BYTE and WORD.... */
 #define BYTE u8
===== drivers/net/irda/old_belkin.c 1.3 vs edited =====
--- 1.3/drivers/net/irda/old_belkin.c	Tue Jun 18 22:13:10 2002
+++ edited/drivers/net/irda/old_belkin.c	Sun Nov 17 20:44:57 2002
@@ -33,6 +33,7 @@
 #include <linux/tty.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/net.h>
 #include <linux/irda.h>
 
 #include <net/irda/irda.h>
===== drivers/scsi/megaraid.c 1.27 vs edited =====
--- 1.27/drivers/scsi/megaraid.c	Thu Oct 31 23:59:07 2002
+++ edited/drivers/scsi/megaraid.c	Sun Nov 17 20:49:17 2002
@@ -494,6 +494,7 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/string.h>
 #include <asm/pgtable.h>
 
 #include <linux/sched.h>
===== fs/char_dev.c 1.4 vs edited =====
--- 1.4/fs/char_dev.c	Sun Feb 17 22:39:04 2002
+++ edited/fs/char_dev.c	Sun Nov 17 19:00:17 2002
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #define HASH_BITS	6
 #define HASH_SIZE	(1UL << HASH_BITS)
===== fs/fifo.c 1.5 vs edited =====
--- 1.5/fs/fifo.c	Sat Nov  9 11:40:49 2002
+++ edited/fs/fifo.c	Sun Nov 17 19:00:17 2002
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/pipe_fs_i.h>
 
 static void wait_for_partner(struct inode* inode, unsigned int* cnt)
 {
===== fs/pipe.c 1.23 vs edited =====
--- 1.23/fs/pipe.c	Sat Nov 16 15:42:38 2002
+++ edited/fs/pipe.c	Sun Nov 17 19:00:17 2002
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pipe_fs_i.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
===== fs/adfs/dir_f.c 1.6 vs edited =====
--- 1.6/fs/adfs/dir_f.c	Sun Oct 13 11:27:33 2002
+++ edited/fs/adfs/dir_f.c	Sun Nov 17 20:30:28 2002
@@ -17,6 +17,7 @@
 #include <linux/stat.h>
 #include <linux/spinlock.h>
 #include <linux/buffer_head.h>
+#include <linux/string.h>
 
 #include "adfs.h"
 #include "dir_f.h"
===== fs/adfs/dir_fplus.c 1.6 vs edited =====
--- 1.6/fs/adfs/dir_fplus.c	Sun Oct 13 11:27:33 2002
+++ edited/fs/adfs/dir_fplus.c	Sun Nov 17 20:30:39 2002
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/spinlock.h>
 #include <linux/buffer_head.h>
+#include <linux/string.h>
 
 #include "adfs.h"
 #include "dir_fplus.h"
===== fs/befs/datastream.c 1.1 vs edited =====
--- 1.1/fs/befs/datastream.c	Tue Oct 22 10:39:38 2002
+++ edited/fs/befs/datastream.c	Sun Nov 17 20:32:49 2002
@@ -14,6 +14,7 @@
 #include <linux/version.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/string.h>
 
 #include "befs.h"
 #include "datastream.h"
===== fs/cifs/md5.c 1.1 vs edited =====
--- 1.1/fs/cifs/md5.c	Thu Oct 10 15:16:13 2002
+++ edited/fs/cifs/md5.c	Sun Nov 17 20:33:26 2002
@@ -20,7 +20,7 @@
    and to fit the cifs vfs by 
    Steve French sfrench@us.ibm.com */
 
-#include <linux/fs.h>
+#include <linux/string.h>
 #include "md5.h"
 
 static void MD5Transform(__u32 buf[4], __u32 const in[16]);
===== fs/freevxfs/vxfs_fshead.c 1.5 vs edited =====
--- 1.5/fs/freevxfs/vxfs_fshead.c	Thu May 23 09:18:47 2002
+++ edited/fs/freevxfs/vxfs_fshead.c	Sun Nov 17 19:00:17 2002
@@ -36,6 +36,7 @@
 #include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include "vxfs.h"
 #include "vxfs_inode.h"
===== fs/smbfs/cache.c 1.9 vs edited =====
--- 1.9/fs/smbfs/cache.c	Mon Apr 29 18:18:35 2002
+++ edited/fs/smbfs/cache.c	Sun Nov 17 20:38:36 2002
@@ -16,6 +16,7 @@
 #include <linux/dirent.h>
 #include <linux/smb_fs.h>
 #include <linux/pagemap.h>
+#include <linux/net.h>
 
 #include <asm/page.h>
 
===== fs/smbfs/dir.c 1.20 vs edited =====
--- 1.20/fs/smbfs/dir.c	Sun Sep 29 17:48:37 2002
+++ edited/fs/smbfs/dir.c	Sun Nov 17 20:38:38 2002
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/ctype.h>
+#include <linux/net.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smb_mount.h>
===== fs/smbfs/file.c 1.19 vs edited =====
--- 1.19/fs/smbfs/file.c	Tue Sep 17 16:15:58 2002
+++ edited/fs/smbfs/file.c	Sun Nov 17 20:38:39 2002
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/net.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
===== fs/smbfs/getopt.c 1.3 vs edited =====
--- 1.3/fs/smbfs/getopt.c	Tue Feb  5 10:23:14 2002
+++ edited/fs/smbfs/getopt.c	Sun Nov 17 20:38:41 2002
@@ -4,6 +4,7 @@
 
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/net.h>
 
 #include "getopt.h"
 
===== fs/smbfs/inode.c 1.34 vs edited =====
--- 1.34/fs/smbfs/inode.c	Sun Nov 17 06:19:44 2002
+++ edited/fs/smbfs/inode.c	Sun Nov 17 20:38:28 2002
@@ -23,6 +23,7 @@
 #include <linux/nls.h>
 #include <linux/seq_file.h>
 #include <linux/mount.h>
+#include <linux/net.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
===== fs/smbfs/ioctl.c 1.6 vs edited =====
--- 1.6/fs/smbfs/ioctl.c	Fri Jul 12 18:13:36 2002
+++ edited/fs/smbfs/ioctl.c	Sun Nov 17 20:38:29 2002
@@ -13,6 +13,7 @@
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/highuid.h>
+#include <linux/net.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smb_mount.h>
===== fs/smbfs/proc.c 1.24 vs edited =====
--- 1.24/fs/smbfs/proc.c	Sun Sep 29 15:39:31 2002
+++ edited/fs/smbfs/proc.c	Sun Nov 17 20:38:30 2002
@@ -18,6 +18,7 @@
 #include <linux/dirent.h>
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
+#include <linux/net.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
===== fs/smbfs/request.c 1.2 vs edited =====
--- 1.2/fs/smbfs/request.c	Sun Sep 29 15:42:36 2002
+++ edited/fs/smbfs/request.c	Sun Nov 17 20:38:32 2002
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/net.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
===== fs/smbfs/smbiod.c 1.4 vs edited =====
--- 1.4/fs/smbfs/smbiod.c	Sun Sep 29 16:59:17 2002
+++ edited/fs/smbfs/smbiod.c	Sun Nov 17 20:38:33 2002
@@ -19,6 +19,7 @@
 #include <linux/dcache.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/net.h>
 #include <net/ip.h>
 
 #include <linux/smb_fs.h>
===== fs/smbfs/sock.c 1.12 vs edited =====
--- 1.12/fs/smbfs/sock.c	Mon Oct 14 03:05:08 2002
+++ edited/fs/smbfs/sock.c	Sun Nov 17 20:38:34 2002
@@ -20,6 +20,7 @@
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
 #include <linux/workqueue.h>
+#include <linux/net.h>
 #include <net/scm.h>
 #include <net/ip.h>
 
===== fs/smbfs/symlink.c 1.2 vs edited =====
--- 1.2/fs/smbfs/symlink.c	Thu Oct  3 16:15:44 2002
+++ edited/fs/smbfs/symlink.c	Sun Nov 17 20:38:35 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/net.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
===== fs/sysv/balloc.c 1.9 vs edited =====
--- 1.9/fs/sysv/balloc.c	Thu May 23 09:18:57 2002
+++ edited/fs/sysv/balloc.c	Sun Nov 17 19:00:17 2002
@@ -20,6 +20,7 @@
  */
 
 #include <linux/buffer_head.h>
+#include <linux/string.h>
 #include "sysv.h"
 
 /* We don't trust the value of
===== fs/sysv/itree.c 1.16 vs edited =====
--- 1.16/fs/sysv/itree.c	Sat Nov 16 15:18:12 2002
+++ edited/fs/sysv/itree.c	Sun Nov 17 19:00:17 2002
@@ -7,6 +7,7 @@
 
 #include <linux/buffer_head.h>
 #include <linux/mount.h>
+#include <linux/string.h>
 #include "sysv.h"
 
 enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
===== include/linux/amigaffs.h 1.11 vs edited =====
--- 1.11/include/linux/amigaffs.h	Thu May 23 09:19:02 2002
+++ edited/include/linux/amigaffs.h	Sun Nov 17 20:32:20 2002
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/buffer_head.h>
+#include <linux/string.h>
 #include <asm/byteorder.h>
 
 /* AmigaOS allows file names with up to 30 characters length.
===== include/linux/ext3_fs.h 1.19 vs edited =====
--- 1.19/include/linux/ext3_fs.h	Wed Nov  6 17:19:54 2002
+++ edited/include/linux/ext3_fs.h	Sun Nov 17 19:00:57 2002
@@ -17,6 +17,7 @@
 #define _LINUX_EXT3_FS_H
 
 #include <linux/types.h>
+#include <linux/ext3_fs_i.h>
 #include <linux/ext3_fs_sb.h>
 
 /*
===== include/linux/fs.h 1.192 vs edited =====
--- 1.192/include/linux/fs.h	Sun Nov 17 07:55:55 2002
+++ edited/include/linux/fs.h	Sun Nov 17 19:00:45 2002
@@ -18,16 +18,13 @@
 #include <linux/dcache.h>
 #include <linux/stat.h>
 #include <linux/cache.h>
-#include <linux/stddef.h>
-#include <linux/string.h>
 #include <linux/radix-tree.h>
-#include <linux/bitops.h>
-
 #include <asm/atomic.h>
 
-struct poll_table_struct;
 struct iovec;
 struct nameidata;
+struct pipe_inode_info;
+struct poll_table_struct;
 struct vm_area_struct;
 struct vfsmount;
 
@@ -220,9 +220,6 @@
 			unsigned long max_blocks,
 			struct buffer_head *bh_result, int create);
 
-#include <linux/pipe_fs_i.h>
-/* #include <linux/umsdos_fs_i.h> */
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -415,8 +412,6 @@
 
 /* will die */
 #include <linux/coda_fs_i.h>
-#include <linux/ext3_fs_i.h>
-#include <linux/efs_fs_i.h>
 
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
===== include/linux/msdos_fs.h 1.20 vs edited =====
--- 1.20/include/linux/msdos_fs.h	Wed Oct 23 11:14:05 2002
+++ edited/include/linux/msdos_fs.h	Sun Nov 17 19:00:17 2002
@@ -5,6 +5,7 @@
  * The MS-DOS filesystem constants/structures
  */
 #include <linux/buffer_head.h>
+#include <linux/string.h>
 #include <asm/byteorder.h>
 
 #define SECTOR_SIZE	512		/* sector size (bytes) */
===== include/linux/ncp_fs_sb.h 1.5 vs edited =====
--- 1.5/include/linux/ncp_fs_sb.h	Tue Oct  1 11:31:54 2002
+++ edited/include/linux/ncp_fs_sb.h	Sun Nov 17 20:34:02 2002
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/ncp_mount.h>
+#include <linux/net.h>
 
 #ifdef __KERNEL__
 
===== init/initramfs.c 1.4 vs edited =====
--- 1.4/init/initramfs.c	Sun Nov  3 19:55:38 2002
+++ edited/init/initramfs.c	Sun Nov 17 19:00:17 2002
@@ -6,6 +6,7 @@
 #include <linux/fcntl.h>
 #include <linux/unistd.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static void __init error(char *x)
 {
