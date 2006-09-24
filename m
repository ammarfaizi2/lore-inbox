Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWIXQSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWIXQSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWIXQSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:18:13 -0400
Received: from havoc.gtf.org ([69.61.125.42]:25516 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751199AbWIXQSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:18:11 -0400
Date: Sun, 24 Sep 2006 12:18:10 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [git patch] add and use include/linux/magic.h
Message-ID: <20060924161809.GA13423@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Along the lines of linux/poison.h, do a similar thing with filesystem
superblock (and later perhaps, other) magic numbers.  This permits
us to delete several headers which -only- included the superblock
magic number, and it integrates well with dwmw2's header_check /
header_install stuff.

Please pull from 'magic' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git magic

to receive the following updates:

 fs/affs/affs.h               |    1 -
 fs/affs/super.c              |    1 +
 fs/autofs/autofs_i.h         |    2 --
 fs/autofs/inode.c            |    1 +
 fs/autofs4/autofs_i.h        |    2 --
 fs/autofs4/inode.c           |    1 +
 fs/hpfs/hpfs_fn.h            |    1 -
 fs/hpfs/super.c              |    1 +
 fs/openpromfs/inode.c        |    2 +-
 include/linux/Kbuild         |    4 +---
 include/linux/adfs_fs.h      |    2 +-
 include/linux/affs_fs.h      |    7 -------
 include/linux/coda_psdev.h   |    4 ++--
 include/linux/efs_fs_sb.h    |    3 +--
 include/linux/ext2_fs.h      |    6 +-----
 include/linux/ext3_fs.h      |    6 +-----
 include/linux/hpfs_fs.h      |    8 --------
 include/linux/iso_fs.h       |    6 +++---
 include/linux/jffs2.h        |    4 ++--
 include/linux/magic.h        |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/minix_fs.h     |    6 ++----
 include/linux/msdos_fs.h     |    4 ++--
 include/linux/ncp_fs.h       |    5 +----
 include/linux/nfs_fs.h       |    7 ++-----
 include/linux/openprom_fs.h  |   10 ----------
 include/linux/proc_fs.h      |    3 +--
 include/linux/qnx4_fs.h      |    2 +-
 include/linux/reiserfs_fs.h  |   10 ++--------
 include/linux/smb.h          |    3 +--
 include/linux/usbdevice_fs.h |    3 +--
 30 files changed, 67 insertions(+), 85 deletions(-)

Jeff Garzik:
      Move several *_SUPER_MAGIC symbols to include/linux/magic.h.

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 0ddd4cc..1dc8438 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -1,7 +1,6 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
-#include <linux/affs_fs.h>
 #include <linux/amigaffs.h>
 
 /* AmigaOS allows file names with up to 30 characters length.
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 5200f49..1735201 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -14,6 +14,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/statfs.h>
 #include <linux/parser.h>
+#include <linux/magic.h>
 #include "affs.h"
 
 extern struct timezone sys_tz;
diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index a62327f..c7700d9 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -37,8 +37,6 @@ #else
 #define DPRINTK(D) ((void)0)
 #endif
 
-#define AUTOFS_SUPER_MAGIC 0x0187
-
 /*
  * If the daemon returns a negative response (AUTOFS_IOC_FAIL) then the
  * kernel will keep the negative response cached for up to the time given
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 65e5ed4..af2efbb 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -16,6 +16,7 @@ #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/parser.h>
 #include <linux/bitops.h>
+#include <linux/magic.h>
 #include "autofs_i.h"
 #include <linux/module.h>
 
diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index d6603d0..480ab17 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -40,8 +40,6 @@ #else
 #define DPRINTK(fmt,args...) do {} while(0)
 #endif
 
-#define AUTOFS_SUPER_MAGIC 0x0187
-
 /* Unified info structure.  This is pointed to by both the dentry and
    inode structures.  Each file in the filesystem has an instance of this
    structure.  It holds a reference to the dentry, so dentries are never
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index fde78b1..11a6a9a 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -19,6 +19,7 @@ #include <linux/pagemap.h>
 #include <linux/parser.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
+#include <linux/magic.h>
 #include "autofs_i.h"
 #include <linux/module.h>
 
diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index f687d54..32ab51e 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -12,7 +12,6 @@
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
-#include <linux/hpfs_fs.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index f798480..8fe51c3 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -11,6 +11,7 @@ #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/init.h>
 #include <linux/statfs.h>
+#include <linux/magic.h>
 
 /* Mark the filesystem dirty, so that chkdsk checks it when os/2 booted */
 
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 93a56bd..592a640 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -8,10 +8,10 @@ #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/fs.h>
-#include <linux/openprom_fs.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
+#include <linux/magic.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 7d076d9..6738360 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -12,7 +12,6 @@ header-y += netfilter_bridge/
 header-y += netfilter_ipv4/
 header-y += netfilter_ipv6/
 
-header-y += affs_fs.h
 header-y += affs_hardblocks.h
 header-y += aio_abi.h
 header-y += a.out.h
@@ -67,7 +66,6 @@ header-y += genetlink.h
 header-y += gen_stats.h
 header-y += gigaset_dev.h
 header-y += hdsmart.h
-header-y += hpfs_fs.h
 header-y += hysdn_if.h
 header-y += i2c-dev.h
 header-y += i8k.h
@@ -103,6 +101,7 @@ header-y += ixjuser.h
 header-y += jffs2.h
 header-y += keyctl.h
 header-y += limits.h
+header-y += magic.h
 header-y += major.h
 header-y += matroxfb.h
 header-y += meye.h
@@ -116,7 +115,6 @@ header-y += netrom.h
 header-y += nfs2.h
 header-y += nfs4_mount.h
 header-y += nfs_mount.h
-header-y += openprom_fs.h
 header-y += param.h
 header-y += pci_ids.h
 header-y += pci_regs.h
diff --git a/include/linux/adfs_fs.h b/include/linux/adfs_fs.h
index 4a5d50c..ef788c2 100644
--- a/include/linux/adfs_fs.h
+++ b/include/linux/adfs_fs.h
@@ -2,6 +2,7 @@ #ifndef _ADFS_FS_H
 #define _ADFS_FS_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
 
 /*
  * Disc Record at disc address 0xc00
@@ -38,7 +39,6 @@ #define ADFS_DISCRECORD		(0xc00)
 #define ADFS_DR_OFFSET		(0x1c0)
 #define ADFS_DR_SIZE		 60
 #define ADFS_DR_SIZE_BITS	(ADFS_DR_SIZE << 3)
-#define ADFS_SUPER_MAGIC	 0xadf5
 
 #ifdef __KERNEL__
 #include <linux/adfs_fs_i.h>
diff --git a/include/linux/affs_fs.h b/include/linux/affs_fs.h
deleted file mode 100644
index c57b5ee..0000000
--- a/include/linux/affs_fs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _AFFS_FS_H
-#define _AFFS_FS_H
-/*
- * The affs filesystem constants/structures
- */
-#define AFFS_SUPER_MAGIC 0xadff
-#endif
diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index 98f6c52..b541bb3 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -1,11 +1,11 @@
 #ifndef __CODA_PSDEV_H
 #define __CODA_PSDEV_H
 
+#include <linux/magic.h>
+
 #define CODA_PSDEV_MAJOR 67
 #define MAX_CODADEVS  5	   /* how many do we allow */
 
-#define CODA_SUPER_MAGIC	0x73757245
-
 struct kstatfs;
 
 struct coda_sb_info
diff --git a/include/linux/efs_fs_sb.h b/include/linux/efs_fs_sb.h
index c76088b..ff1945e 100644
--- a/include/linux/efs_fs_sb.h
+++ b/include/linux/efs_fs_sb.h
@@ -9,8 +9,7 @@
 #ifndef __EFS_FS_SB_H__
 #define __EFS_FS_SB_H__
 
-/* statfs() magic number for EFS */
-#define EFS_SUPER_MAGIC	0x414A53
+#include <linux/magic.h>
 
 /* EFS superblock magic numbers */
 #define EFS_MAGIC	0x072959
diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
index facf34e..33a1aa1 100644
--- a/include/linux/ext2_fs.h
+++ b/include/linux/ext2_fs.h
@@ -17,6 +17,7 @@ #ifndef _LINUX_EXT2_FS_H
 #define _LINUX_EXT2_FS_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
 
 /*
  * The second extended filesystem constants/structures
@@ -63,11 +64,6 @@ #define EXT2_UNDEL_DIR_INO	 6	/* Undelet
 /* First non-reserved inode for old ext2 filesystems */
 #define EXT2_GOOD_OLD_FIRST_INO	11
 
-/*
- * The second extended file system magic number
- */
-#define EXT2_SUPER_MAGIC	0xEF53
-
 #ifdef __KERNEL__
 #include <linux/ext2_fs_sb.h>
 static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
index 9f9cce7..0eed918 100644
--- a/include/linux/ext3_fs.h
+++ b/include/linux/ext3_fs.h
@@ -17,6 +17,7 @@ #ifndef _LINUX_EXT3_FS_H
 #define _LINUX_EXT3_FS_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
 
 /*
  * The second extended filesystem constants/structures
@@ -67,11 +68,6 @@ #define EXT3_JOURNAL_INO	 8	/* Journal i
 #define EXT3_GOOD_OLD_FIRST_INO	11
 
 /*
- * The second extended file system magic number
- */
-#define EXT3_SUPER_MAGIC	0xEF53
-
-/*
  * Maximal count of links to a file
  */
 #define EXT3_LINK_MAX		32000
diff --git a/include/linux/hpfs_fs.h b/include/linux/hpfs_fs.h
deleted file mode 100644
index a5028dd..0000000
--- a/include/linux/hpfs_fs.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _LINUX_HPFS_FS_H
-#define _LINUX_HPFS_FS_H
-
-/* HPFS magic number (word 0 of block 16) */
-
-#define HPFS_SUPER_MAGIC 0xf995e849
-
-#endif
diff --git a/include/linux/iso_fs.h b/include/linux/iso_fs.h
index 4796787..4688ac4 100644
--- a/include/linux/iso_fs.h
+++ b/include/linux/iso_fs.h
@@ -2,6 +2,8 @@ #ifndef _ISOFS_FS_H
 #define _ISOFS_FS_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
+
 /*
  * The isofs filesystem constants/structures
  */
@@ -160,6 +162,4 @@ #define ISOFS_BLOCK_SIZE 2048
 #define ISOFS_BUFFER_SIZE(INODE) ((INODE)->i_sb->s_blocksize)
 #define ISOFS_BUFFER_BITS(INODE) ((INODE)->i_sb->s_blocksize_bits)
 
-#define ISOFS_SUPER_MAGIC 0x9660
-
-#endif
+#endif /* _ISOFS_FS_H */
diff --git a/include/linux/jffs2.h b/include/linux/jffs2.h
index c9c7607..840631f 100644
--- a/include/linux/jffs2.h
+++ b/include/linux/jffs2.h
@@ -15,12 +15,12 @@
 #ifndef __LINUX_JFFS2_H__
 #define __LINUX_JFFS2_H__
 
+#include <linux/magic.h>
+
 /* You must include something which defines the C99 uintXX_t types. 
    We don't do it from here because this file is used in too many
    different environments. */
 
-#define JFFS2_SUPER_MAGIC 0x72b6
-
 /* Values we may expect to find in the 'magic' field */
 #define JFFS2_OLD_MAGIC_BITMASK 0x1984
 #define JFFS2_MAGIC_BITMASK 0x1985
diff --git a/include/linux/magic.h b/include/linux/magic.h
new file mode 100644
index 0000000..22036dd
--- /dev/null
+++ b/include/linux/magic.h
@@ -0,0 +1,37 @@
+#ifndef __LINUX_MAGIC_H__
+#define __LINUX_MAGIC_H__
+
+#define ADFS_SUPER_MAGIC	0xadf5
+#define AFFS_SUPER_MAGIC	0xadff
+#define AUTOFS_SUPER_MAGIC	0x0187
+#define CODA_SUPER_MAGIC	0x73757245
+#define EFS_SUPER_MAGIC		0x414A53
+#define EXT2_SUPER_MAGIC	0xEF53
+#define EXT3_SUPER_MAGIC	0xEF53
+#define HPFS_SUPER_MAGIC	0xf995e849
+#define ISOFS_SUPER_MAGIC	0x9660
+#define JFFS2_SUPER_MAGIC	0x72b6
+
+#define MINIX_SUPER_MAGIC	0x137F		/* original minix fs */
+#define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
+#define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
+#define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+
+#define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
+#define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is :-) */
+#define NFS_SUPER_MAGIC		0x6969
+#define OPENPROM_SUPER_MAGIC	0x9fa1
+#define PROC_SUPER_MAGIC	0x9fa0
+#define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
+
+#define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
+					/* used by file system utilities that
+	                                   look at the superblock, etc.  */
+#define REISERFS_SUPER_MAGIC_STRING	"ReIsErFs"
+#define REISER2FS_SUPER_MAGIC_STRING	"ReIsEr2Fs"
+#define REISER2FS_JR_SUPER_MAGIC_STRING	"ReIsEr3Fs"
+
+#define SMB_SUPER_MAGIC		0x517B
+#define USBDEVICE_SUPER_MAGIC	0x9fa2
+
+#endif /* __LINUX_MAGIC_H__ */
diff --git a/include/linux/minix_fs.h b/include/linux/minix_fs.h
index 1ecc3cc..916e8f7 100644
--- a/include/linux/minix_fs.h
+++ b/include/linux/minix_fs.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MINIX_FS_H
 #define _LINUX_MINIX_FS_H
 
+#include <linux/magic.h>
+
 /*
  * The minix filesystem constants/structures
  */
@@ -19,10 +21,6 @@ #define MINIX2_LINK_MAX	65530
 
 #define MINIX_I_MAP_SLOTS	8
 #define MINIX_Z_MAP_SLOTS	64
-#define MINIX_SUPER_MAGIC	0x137F		/* original minix fs */
-#define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
-#define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
-#define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
diff --git a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
index d9035c7..bae62d6 100644
--- a/include/linux/msdos_fs.h
+++ b/include/linux/msdos_fs.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MSDOS_FS_H
 #define _LINUX_MSDOS_FS_H
 
+#include <linux/magic.h>
+
 /*
  * The MS-DOS filesystem constants/structures
  */
@@ -18,8 +20,6 @@ #define CT_LE_W(v)	cpu_to_le16(v)
 #define CT_LE_L(v)	cpu_to_le32(v)
 
 
-#define MSDOS_SUPER_MAGIC 0x4d44 /* MD */
-
 #define MSDOS_ROOT_INO	1	/* == MINIX_ROOT_INO */
 #define MSDOS_DIR_BITS	5	/* log2(sizeof(struct msdos_dir_entry)) */
 
diff --git a/include/linux/ncp_fs.h b/include/linux/ncp_fs.h
index b208f0c..02e352b 100644
--- a/include/linux/ncp_fs.h
+++ b/include/linux/ncp_fs.h
@@ -11,6 +11,7 @@ #define _LINUX_NCP_FS_H
 #include <linux/fs.h>
 #include <linux/in.h>
 #include <linux/types.h>
+#include <linux/magic.h>
 
 #include <linux/ipx.h>
 #include <linux/ncp_no.h>
@@ -185,10 +186,6 @@ struct ncp_entry_info {
 	__u8			file_handle[6];
 };
 
-/* Guess, what 0x564c is :-) */
-#define NCP_SUPER_MAGIC  0x564c
-
-
 static inline struct ncp_server *NCP_SBP(struct super_block *sb)
 {
 	return sb->s_fs_info;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 3b5b041..36f5bcf 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -9,6 +9,8 @@
 #ifndef _LINUX_NFS_FS_H
 #define _LINUX_NFS_FS_H
 
+#include <linux/magic.h>
+
 /*
  * Enable debugging support for nfs client.
  * Requires RPC_DEBUG.
@@ -22,11 +24,6 @@ #define NFS_MAX_UDP_TIMEOUT	(60*HZ)
 #define NFS_MAX_TCP_TIMEOUT	(600*HZ)
 
 /*
- * superblock magic number for NFS
- */
-#define NFS_SUPER_MAGIC			0x6969
-
-/*
  * When flushing a cluster of dirty pages, there can be different
  * strategies:
  */
diff --git a/include/linux/openprom_fs.h b/include/linux/openprom_fs.h
deleted file mode 100644
index a837aab..0000000
--- a/include/linux/openprom_fs.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _LINUX_OPENPROM_FS_H
-#define _LINUX_OPENPROM_FS_H
-
-/*
- * The openprom filesystem constants/structures
- */
-
-#define OPENPROM_SUPER_MAGIC 0x9fa1
-
-#endif /* _LINUX_OPENPROM_FS_H */
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 17e7578..3435ca3 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -4,6 +4,7 @@ #define _LINUX_PROC_FS_H
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/spinlock.h>
+#include <linux/magic.h>
 #include <asm/atomic.h>
 
 /*
@@ -24,8 +25,6 @@ enum {
 	PROC_ROOT_INO = 1,
 };
 
-#define PROC_SUPER_MAGIC 0x9fa0
-
 /*
  * This is not completely implemented yet. The idea is to
  * create an in-memory tree (like the actual /proc filesystem
diff --git a/include/linux/qnx4_fs.h b/include/linux/qnx4_fs.h
index 27f49c8..0c7ac44 100644
--- a/include/linux/qnx4_fs.h
+++ b/include/linux/qnx4_fs.h
@@ -11,6 +11,7 @@ #ifndef _LINUX_QNX4_FS_H
 #define _LINUX_QNX4_FS_H
 
 #include <linux/qnxtypes.h>
+#include <linux/magic.h>
 
 #define QNX4_ROOT_INO 1
 
@@ -25,7 +26,6 @@ #define QNX4_FILE_FSYSCLEAN     0x20
 
 #define QNX4_I_MAP_SLOTS	8
 #define QNX4_Z_MAP_SLOTS	64
-#define QNX4_SUPER_MAGIC	0x002f	/* qnx4 fs detection */
 #define QNX4_VALID_FS		0x0001	/* Clean fs. */
 #define QNX4_ERROR_FS		0x0002	/* fs has errors. */
 #define QNX4_BLOCK_SIZE         0x200	/* blocksize of 512 bytes */
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index daa2d83..28493ff 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -12,6 +12,8 @@ #ifndef _LINUX_REISER_FS_H
 #define _LINUX_REISER_FS_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
+
 #ifdef __KERNEL__
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -227,14 +229,6 @@ #define is_block_in_log_or_reserved_area
          ((!is_reiserfs_jr(SB_DISK_SUPER_BLOCK(s)) ? \
          SB_ONDISK_JOURNAL_SIZE(s) + 1 : SB_ONDISK_RESERVED_FOR_JOURNAL(s)))
 
-				/* used by gcc */
-#define REISERFS_SUPER_MAGIC 0x52654973
-				/* used by file system utilities that
-				   look at the superblock, etc. */
-#define REISERFS_SUPER_MAGIC_STRING "ReIsErFs"
-#define REISER2FS_SUPER_MAGIC_STRING "ReIsEr2Fs"
-#define REISER2FS_JR_SUPER_MAGIC_STRING "ReIsEr3Fs"
-
 int is_reiserfs_3_5(struct reiserfs_super_block *rs);
 int is_reiserfs_3_6(struct reiserfs_super_block *rs);
 int is_reiserfs_jr(struct reiserfs_super_block *rs);
diff --git a/include/linux/smb.h b/include/linux/smb.h
index b016220..6df3b15 100644
--- a/include/linux/smb.h
+++ b/include/linux/smb.h
@@ -10,6 +10,7 @@ #ifndef _LINUX_SMB_H
 #define _LINUX_SMB_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
 
 enum smb_protocol { 
 	SMB_PROTOCOL_NONE, 
@@ -101,8 +102,6 @@ enum smb_conn_state {
 	CONN_RETRYING		/* Currently trying to reconnect */
 };
 
-#define SMB_SUPER_MAGIC               0x517B
-
 #define SMB_HEADER_LEN   37     /* includes everything up to, but not
                                  * including smb_bcc */
 
diff --git a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
index 7b7aadb..617d8a1 100644
--- a/include/linux/usbdevice_fs.h
+++ b/include/linux/usbdevice_fs.h
@@ -32,11 +32,10 @@ #ifndef _LINUX_USBDEVICE_FS_H
 #define _LINUX_USBDEVICE_FS_H
 
 #include <linux/types.h>
+#include <linux/magic.h>
 
 /* --------------------------------------------------------------------- */
 
-#define USBDEVICE_SUPER_MAGIC 0x9fa2
-
 /* usbdevfs ioctl codes */
 
 struct usbdevfs_ctrltransfer {
