Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWILIXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWILIXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWILIXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:23:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:65166 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965037AbWILIXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:23:03 -0400
X-Sasl-enc: eq9iBtOVwmqdWnG1jnAF5/AGjVFIozId485CO4gPUbL/ 1158049380
Date: Tue, 12 Sep 2006 16:22:52 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jeff Garzik <jeff@garzik.org>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
In-Reply-To: <20060909110245.GA9617@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0609121620550.4911@raven.themaw.net>
References: <20060909110245.GA9617@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2006, Jeff Garzik wrote:

> 
> An IRC discussion sparked a memory:  most filesystems really don't
> need to put anything at all in include/linux.  Excluding API-ish
> filesystems like procfs, just about the only filesystem symbols that
> get exported outside of __KERNEL__ are the *_SUPER_MAGIC symbols,
> and similar symbols.
> 
> After seeing the useful attributes of linux/poison.h, I propose a
> similar linux/magic.h.
> 
> We can see from the patch below that this permitted the deletion of a
> couple headers, where the *_SUPER_MAGIC symbol was the only thing in the
> entire header.
> 
> Other non-filesystem-related magic numbers could get moved here
> eventually, if maintainers so desire, but I wanted to start off with the
> obvious low-hanging fruit.
> 

Would be good to include autofs in this lot.

Defined in linux/autofs/autofs_i.h
Defined in linux/autofs4/autofs_i.h

as 

#define AUTOFS_SUPER_MAGIC 0x0187

> The 'magic' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 
> contains the following update:
> 
>  fs/affs/affs.h               |    1 -
>  fs/affs/super.c              |    1 +
>  fs/hpfs/hpfs_fn.h            |    1 -
>  fs/hpfs/super.c              |    1 +
>  fs/openpromfs/inode.c        |    1 +
>  include/linux/adfs_fs.h      |    2 +-
>  include/linux/affs_fs.h      |    7 -------
>  include/linux/coda_psdev.h   |    4 ++--
>  include/linux/efs_fs_sb.h    |    3 +--
>  include/linux/ext2_fs.h      |    6 +-----
>  include/linux/ext3_fs.h      |    6 +-----
>  include/linux/hpfs_fs.h      |    8 --------
>  include/linux/iso_fs.h       |    6 +++---
>  include/linux/jffs2.h        |    4 ++--
>  include/linux/magic.h        |   36 ++++++++++++++++++++++++++++++++++++
>  include/linux/minix_fs.h     |    6 ++----
>  include/linux/msdos_fs.h     |    4 ++--
>  include/linux/ncp_fs.h       |    5 +----
>  include/linux/nfs_fs.h       |    6 +-----
>  include/linux/openprom_fs.h  |   10 ----------
>  include/linux/proc_fs.h      |    3 +--
>  include/linux/qnx4_fs.h      |    2 +-
>  include/linux/reiserfs_fs.h  |   10 ++--------
>  include/linux/smb.h          |    3 +--
>  include/linux/usbdevice_fs.h |    3 +--
>  25 files changed, 62 insertions(+), 77 deletions(-)
> 
> diff --git a/fs/affs/affs.h b/fs/affs/affs.h
> index 0ddd4cc..1dc8438 100644
> --- a/fs/affs/affs.h
> +++ b/fs/affs/affs.h
> @@ -1,7 +1,6 @@
>  #include <linux/types.h>
>  #include <linux/fs.h>
>  #include <linux/buffer_head.h>
> -#include <linux/affs_fs.h>
>  #include <linux/amigaffs.h>
>  
>  /* AmigaOS allows file names with up to 30 characters length.
> diff --git a/fs/affs/super.c b/fs/affs/super.c
> index 5200f49..1735201 100644
> --- a/fs/affs/super.c
> +++ b/fs/affs/super.c
> @@ -14,6 +14,7 @@ #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/statfs.h>
>  #include <linux/parser.h>
> +#include <linux/magic.h>
>  #include "affs.h"
>  
>  extern struct timezone sys_tz;
> diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
> index f687d54..32ab51e 100644
> --- a/fs/hpfs/hpfs_fn.h
> +++ b/fs/hpfs/hpfs_fn.h
> @@ -12,7 +12,6 @@
>  #include <linux/mutex.h>
>  #include <linux/pagemap.h>
>  #include <linux/buffer_head.h>
> -#include <linux/hpfs_fs.h>
>  #include <linux/slab.h>
>  #include <linux/smp_lock.h>
>  
> diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
> index f798480..8fe51c3 100644
> --- a/fs/hpfs/super.c
> +++ b/fs/hpfs/super.c
> @@ -11,6 +11,7 @@ #include <linux/module.h>
>  #include <linux/parser.h>
>  #include <linux/init.h>
>  #include <linux/statfs.h>
> +#include <linux/magic.h>
>  
>  /* Mark the filesystem dirty, so that chkdsk checks it when os/2 booted */
>  
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index 93a56bd..a6ad105 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -12,6 +12,7 @@ #include <linux/openprom_fs.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
> +#include <linux/magic.h>
>  
>  #include <asm/openprom.h>
>  #include <asm/oplib.h>
> diff --git a/include/linux/adfs_fs.h b/include/linux/adfs_fs.h
> index 4a5d50c..ef788c2 100644
> --- a/include/linux/adfs_fs.h
> +++ b/include/linux/adfs_fs.h
> @@ -2,6 +2,7 @@ #ifndef _ADFS_FS_H
>  #define _ADFS_FS_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
>  
>  /*
>   * Disc Record at disc address 0xc00
> @@ -38,7 +39,6 @@ #define ADFS_DISCRECORD		(0xc00)
>  #define ADFS_DR_OFFSET		(0x1c0)
>  #define ADFS_DR_SIZE		 60
>  #define ADFS_DR_SIZE_BITS	(ADFS_DR_SIZE << 3)
> -#define ADFS_SUPER_MAGIC	 0xadf5
>  
>  #ifdef __KERNEL__
>  #include <linux/adfs_fs_i.h>
> diff --git a/include/linux/affs_fs.h b/include/linux/affs_fs.h
> deleted file mode 100644
> index c57b5ee..0000000
> --- a/include/linux/affs_fs.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#ifndef _AFFS_FS_H
> -#define _AFFS_FS_H
> -/*
> - * The affs filesystem constants/structures
> - */
> -#define AFFS_SUPER_MAGIC 0xadff
> -#endif
> diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
> index 98f6c52..b541bb3 100644
> --- a/include/linux/coda_psdev.h
> +++ b/include/linux/coda_psdev.h
> @@ -1,11 +1,11 @@
>  #ifndef __CODA_PSDEV_H
>  #define __CODA_PSDEV_H
>  
> +#include <linux/magic.h>
> +
>  #define CODA_PSDEV_MAJOR 67
>  #define MAX_CODADEVS  5	   /* how many do we allow */
>  
> -#define CODA_SUPER_MAGIC	0x73757245
> -
>  struct kstatfs;
>  
>  struct coda_sb_info
> diff --git a/include/linux/efs_fs_sb.h b/include/linux/efs_fs_sb.h
> index c76088b..ff1945e 100644
> --- a/include/linux/efs_fs_sb.h
> +++ b/include/linux/efs_fs_sb.h
> @@ -9,8 +9,7 @@
>  #ifndef __EFS_FS_SB_H__
>  #define __EFS_FS_SB_H__
>  
> -/* statfs() magic number for EFS */
> -#define EFS_SUPER_MAGIC	0x414A53
> +#include <linux/magic.h>
>  
>  /* EFS superblock magic numbers */
>  #define EFS_MAGIC	0x072959
> diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
> index facf34e..33a1aa1 100644
> --- a/include/linux/ext2_fs.h
> +++ b/include/linux/ext2_fs.h
> @@ -17,6 +17,7 @@ #ifndef _LINUX_EXT2_FS_H
>  #define _LINUX_EXT2_FS_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
>  
>  /*
>   * The second extended filesystem constants/structures
> @@ -63,11 +64,6 @@ #define EXT2_UNDEL_DIR_INO	 6	/* Undelet
>  /* First non-reserved inode for old ext2 filesystems */
>  #define EXT2_GOOD_OLD_FIRST_INO	11
>  
> -/*
> - * The second extended file system magic number
> - */
> -#define EXT2_SUPER_MAGIC	0xEF53
> -
>  #ifdef __KERNEL__
>  #include <linux/ext2_fs_sb.h>
>  static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
> diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
> index 9f9cce7..0eed918 100644
> --- a/include/linux/ext3_fs.h
> +++ b/include/linux/ext3_fs.h
> @@ -17,6 +17,7 @@ #ifndef _LINUX_EXT3_FS_H
>  #define _LINUX_EXT3_FS_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
>  
>  /*
>   * The second extended filesystem constants/structures
> @@ -67,11 +68,6 @@ #define EXT3_JOURNAL_INO	 8	/* Journal i
>  #define EXT3_GOOD_OLD_FIRST_INO	11
>  
>  /*
> - * The second extended file system magic number
> - */
> -#define EXT3_SUPER_MAGIC	0xEF53
> -
> -/*
>   * Maximal count of links to a file
>   */
>  #define EXT3_LINK_MAX		32000
> diff --git a/include/linux/hpfs_fs.h b/include/linux/hpfs_fs.h
> deleted file mode 100644
> index a5028dd..0000000
> --- a/include/linux/hpfs_fs.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#ifndef _LINUX_HPFS_FS_H
> -#define _LINUX_HPFS_FS_H
> -
> -/* HPFS magic number (word 0 of block 16) */
> -
> -#define HPFS_SUPER_MAGIC 0xf995e849
> -
> -#endif
> diff --git a/include/linux/iso_fs.h b/include/linux/iso_fs.h
> index 4796787..4688ac4 100644
> --- a/include/linux/iso_fs.h
> +++ b/include/linux/iso_fs.h
> @@ -2,6 +2,8 @@ #ifndef _ISOFS_FS_H
>  #define _ISOFS_FS_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
> +
>  /*
>   * The isofs filesystem constants/structures
>   */
> @@ -160,6 +162,4 @@ #define ISOFS_BLOCK_SIZE 2048
>  #define ISOFS_BUFFER_SIZE(INODE) ((INODE)->i_sb->s_blocksize)
>  #define ISOFS_BUFFER_BITS(INODE) ((INODE)->i_sb->s_blocksize_bits)
>  
> -#define ISOFS_SUPER_MAGIC 0x9660
> -
> -#endif
> +#endif /* _ISOFS_FS_H */
> diff --git a/include/linux/jffs2.h b/include/linux/jffs2.h
> index c9c7607..840631f 100644
> --- a/include/linux/jffs2.h
> +++ b/include/linux/jffs2.h
> @@ -15,12 +15,12 @@
>  #ifndef __LINUX_JFFS2_H__
>  #define __LINUX_JFFS2_H__
>  
> +#include <linux/magic.h>
> +
>  /* You must include something which defines the C99 uintXX_t types. 
>     We don't do it from here because this file is used in too many
>     different environments. */
>  
> -#define JFFS2_SUPER_MAGIC 0x72b6
> -
>  /* Values we may expect to find in the 'magic' field */
>  #define JFFS2_OLD_MAGIC_BITMASK 0x1984
>  #define JFFS2_MAGIC_BITMASK 0x1985
> diff --git a/include/linux/magic.h b/include/linux/magic.h
> new file mode 100644
> index 0000000..c4ade90
> --- /dev/null
> +++ b/include/linux/magic.h
> @@ -0,0 +1,36 @@
> +#ifndef __LINUX_MAGIC_H__
> +#define __LINUX_MAGIC_H__
> +
> +#define ADFS_SUPER_MAGIC	0xadf5
> +#define AFFS_SUPER_MAGIC	0xadff
> +#define CODA_SUPER_MAGIC	0x73757245
> +#define EFS_SUPER_MAGIC		0x414A53
> +#define EXT2_SUPER_MAGIC	0xEF53
> +#define EXT3_SUPER_MAGIC	0xEF53
> +#define HPFS_SUPER_MAGIC	0xf995e849
> +#define ISOFS_SUPER_MAGIC	0x9660
> +#define JFFS2_SUPER_MAGIC	0x72b6
> +
> +#define MINIX_SUPER_MAGIC	0x137F		/* original minix fs */
> +#define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
> +#define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
> +#define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
> +
> +#define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
> +#define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is :-) */
> +#define NFS_SUPER_MAGIC		0x6969
> +#define OPENPROM_SUPER_MAGIC	0x9fa1
> +#define PROC_SUPER_MAGIC	0x9fa0
> +#define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
> +
> +#define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
> +					/* used by file system utilities that
> +	                                   look at the superblock, etc.  */
> +#define REISERFS_SUPER_MAGIC_STRING	"ReIsErFs"
> +#define REISER2FS_SUPER_MAGIC_STRING	"ReIsEr2Fs"
> +#define REISER2FS_JR_SUPER_MAGIC_STRING	"ReIsEr3Fs"
> +
> +#define SMB_SUPER_MAGIC		0x517B
> +#define USBDEVICE_SUPER_MAGIC	0x9fa2
> +
> +#endif /* __LINUX_MAGIC_H__ */
> diff --git a/include/linux/minix_fs.h b/include/linux/minix_fs.h
> index 1ecc3cc..916e8f7 100644
> --- a/include/linux/minix_fs.h
> +++ b/include/linux/minix_fs.h
> @@ -1,6 +1,8 @@
>  #ifndef _LINUX_MINIX_FS_H
>  #define _LINUX_MINIX_FS_H
>  
> +#include <linux/magic.h>
> +
>  /*
>   * The minix filesystem constants/structures
>   */
> @@ -19,10 +21,6 @@ #define MINIX2_LINK_MAX	65530
>  
>  #define MINIX_I_MAP_SLOTS	8
>  #define MINIX_Z_MAP_SLOTS	64
> -#define MINIX_SUPER_MAGIC	0x137F		/* original minix fs */
> -#define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
> -#define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
> -#define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
>  #define MINIX_VALID_FS		0x0001		/* Clean fs. */
>  #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
>  
> diff --git a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
> index d9035c7..bae62d6 100644
> --- a/include/linux/msdos_fs.h
> +++ b/include/linux/msdos_fs.h
> @@ -1,6 +1,8 @@
>  #ifndef _LINUX_MSDOS_FS_H
>  #define _LINUX_MSDOS_FS_H
>  
> +#include <linux/magic.h>
> +
>  /*
>   * The MS-DOS filesystem constants/structures
>   */
> @@ -18,8 +20,6 @@ #define CT_LE_W(v)	cpu_to_le16(v)
>  #define CT_LE_L(v)	cpu_to_le32(v)
>  
>  
> -#define MSDOS_SUPER_MAGIC 0x4d44 /* MD */
> -
>  #define MSDOS_ROOT_INO	1	/* == MINIX_ROOT_INO */
>  #define MSDOS_DIR_BITS	5	/* log2(sizeof(struct msdos_dir_entry)) */
>  
> diff --git a/include/linux/ncp_fs.h b/include/linux/ncp_fs.h
> index b208f0c..02e352b 100644
> --- a/include/linux/ncp_fs.h
> +++ b/include/linux/ncp_fs.h
> @@ -11,6 +11,7 @@ #define _LINUX_NCP_FS_H
>  #include <linux/fs.h>
>  #include <linux/in.h>
>  #include <linux/types.h>
> +#include <linux/magic.h>
>  
>  #include <linux/ipx.h>
>  #include <linux/ncp_no.h>
> @@ -185,10 +186,6 @@ struct ncp_entry_info {
>  	__u8			file_handle[6];
>  };
>  
> -/* Guess, what 0x564c is :-) */
> -#define NCP_SUPER_MAGIC  0x564c
> -
> -
>  static inline struct ncp_server *NCP_SBP(struct super_block *sb)
>  {
>  	return sb->s_fs_info;
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 2474345..8ada5da 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -14,6 +14,7 @@ #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/rwsem.h>
>  #include <linux/wait.h>
> +#include <linux/magic.h>
>  
>  #include <linux/sunrpc/debug.h>
>  #include <linux/sunrpc/auth.h>
> @@ -43,11 +44,6 @@ #define NFS_MAX_UDP_TIMEOUT	(60*HZ)
>  #define NFS_MAX_TCP_TIMEOUT	(600*HZ)
>  
>  /*
> - * superblock magic number for NFS
> - */
> -#define NFS_SUPER_MAGIC			0x6969
> -
> -/*
>   * These are the default flags for swap requests
>   */
>  #define NFS_RPC_SWAPFLAGS		(RPC_TASK_SWAPPER|RPC_TASK_ROOTCREDS)
> diff --git a/include/linux/openprom_fs.h b/include/linux/openprom_fs.h
> deleted file mode 100644
> index a837aab..0000000
> --- a/include/linux/openprom_fs.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#ifndef _LINUX_OPENPROM_FS_H
> -#define _LINUX_OPENPROM_FS_H
> -
> -/*
> - * The openprom filesystem constants/structures
> - */
> -
> -#define OPENPROM_SUPER_MAGIC 0x9fa1
> -
> -#endif /* _LINUX_OPENPROM_FS_H */
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 17e7578..3435ca3 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -4,6 +4,7 @@ #define _LINUX_PROC_FS_H
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/spinlock.h>
> +#include <linux/magic.h>
>  #include <asm/atomic.h>
>  
>  /*
> @@ -24,8 +25,6 @@ enum {
>  	PROC_ROOT_INO = 1,
>  };
>  
> -#define PROC_SUPER_MAGIC 0x9fa0
> -
>  /*
>   * This is not completely implemented yet. The idea is to
>   * create an in-memory tree (like the actual /proc filesystem
> diff --git a/include/linux/qnx4_fs.h b/include/linux/qnx4_fs.h
> index 27f49c8..0c7ac44 100644
> --- a/include/linux/qnx4_fs.h
> +++ b/include/linux/qnx4_fs.h
> @@ -11,6 +11,7 @@ #ifndef _LINUX_QNX4_FS_H
>  #define _LINUX_QNX4_FS_H
>  
>  #include <linux/qnxtypes.h>
> +#include <linux/magic.h>
>  
>  #define QNX4_ROOT_INO 1
>  
> @@ -25,7 +26,6 @@ #define QNX4_FILE_FSYSCLEAN     0x20
>  
>  #define QNX4_I_MAP_SLOTS	8
>  #define QNX4_Z_MAP_SLOTS	64
> -#define QNX4_SUPER_MAGIC	0x002f	/* qnx4 fs detection */
>  #define QNX4_VALID_FS		0x0001	/* Clean fs. */
>  #define QNX4_ERROR_FS		0x0002	/* fs has errors. */
>  #define QNX4_BLOCK_SIZE         0x200	/* blocksize of 512 bytes */
> diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
> index daa2d83..28493ff 100644
> --- a/include/linux/reiserfs_fs.h
> +++ b/include/linux/reiserfs_fs.h
> @@ -12,6 +12,8 @@ #ifndef _LINUX_REISER_FS_H
>  #define _LINUX_REISER_FS_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
> +
>  #ifdef __KERNEL__
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> @@ -227,14 +229,6 @@ #define is_block_in_log_or_reserved_area
>           ((!is_reiserfs_jr(SB_DISK_SUPER_BLOCK(s)) ? \
>           SB_ONDISK_JOURNAL_SIZE(s) + 1 : SB_ONDISK_RESERVED_FOR_JOURNAL(s)))
>  
> -				/* used by gcc */
> -#define REISERFS_SUPER_MAGIC 0x52654973
> -				/* used by file system utilities that
> -				   look at the superblock, etc. */
> -#define REISERFS_SUPER_MAGIC_STRING "ReIsErFs"
> -#define REISER2FS_SUPER_MAGIC_STRING "ReIsEr2Fs"
> -#define REISER2FS_JR_SUPER_MAGIC_STRING "ReIsEr3Fs"
> -
>  int is_reiserfs_3_5(struct reiserfs_super_block *rs);
>  int is_reiserfs_3_6(struct reiserfs_super_block *rs);
>  int is_reiserfs_jr(struct reiserfs_super_block *rs);
> diff --git a/include/linux/smb.h b/include/linux/smb.h
> index b016220..6df3b15 100644
> --- a/include/linux/smb.h
> +++ b/include/linux/smb.h
> @@ -10,6 +10,7 @@ #ifndef _LINUX_SMB_H
>  #define _LINUX_SMB_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
>  
>  enum smb_protocol { 
>  	SMB_PROTOCOL_NONE, 
> @@ -101,8 +102,6 @@ enum smb_conn_state {
>  	CONN_RETRYING		/* Currently trying to reconnect */
>  };
>  
> -#define SMB_SUPER_MAGIC               0x517B
> -
>  #define SMB_HEADER_LEN   37     /* includes everything up to, but not
>                                   * including smb_bcc */
>  
> diff --git a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
> index 7b7aadb..617d8a1 100644
> --- a/include/linux/usbdevice_fs.h
> +++ b/include/linux/usbdevice_fs.h
> @@ -32,11 +32,10 @@ #ifndef _LINUX_USBDEVICE_FS_H
>  #define _LINUX_USBDEVICE_FS_H
>  
>  #include <linux/types.h>
> +#include <linux/magic.h>
>  
>  /* --------------------------------------------------------------------- */
>  
> -#define USBDEVICE_SUPER_MAGIC 0x9fa2
> -
>  /* usbdevfs ioctl codes */
>  
>  struct usbdevfs_ctrltransfer {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
