Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWIDH56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWIDH56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWIDH56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:57:58 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:51145 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932479AbWIDH55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:57:57 -0400
Date: Mon, 4 Sep 2006 09:54:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 20/22][RFC] Unionfs: Internal include file
In-Reply-To: <20060901020104.GU5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040949130.22518@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901020104.GU5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+static inline void fist_copy_attr_atime(struct inode *dest,
>+					const struct inode *src)
>+{
>+	dest->i_atime = src->i_atime;
>+}
>+static inline void fist_copy_attr_times(struct inode *dest,
>+					const struct inode *src)
>+{
>+	dest->i_atime = src->i_atime;
>+	dest->i_mtime = src->i_mtime;
>+	dest->i_ctime = src->i_ctime;
>+}
>+static inline void fist_copy_attr_timesizes(struct inode *dest,
>+					    const struct inode *src)
>+{
>+	dest->i_atime = src->i_atime;
>+	dest->i_mtime = src->i_mtime;
>+	dest->i_ctime = src->i_ctime;
>+	dest->i_size = src->i_size;
>+	dest->i_blocks = src->i_blocks;
>+}
>+static inline void fist_copy_attr_all(struct inode *dest,
>+				      const struct inode *src)
>+{
>+	dest->i_mode = src->i_mode;
>+	/* we do not need to copy if the file is a deleted file */
>+	if (dest->i_nlink > 0)
>+		dest->i_nlink = get_nlinks(dest);
>+	dest->i_uid = src->i_uid;
>+	dest->i_gid = src->i_gid;
>+	dest->i_rdev = src->i_rdev;
>+	dest->i_atime = src->i_atime;
>+	dest->i_mtime = src->i_mtime;
>+	dest->i_ctime = src->i_ctime;
>+	dest->i_blksize = src->i_blksize;
>+	dest->i_blkbits = src->i_blkbits;
>+	dest->i_size = src->i_size;
>+	dest->i_blocks = src->i_blocks;
>+	dest->i_flags = src->i_flags;
>+}

Add some empty lines between the functions.

>+static inline int branchperms(struct super_block *sb, int index)
>+{
>+	BUG_ON(index < 0);
>+
>+	return stopd(sb)->usi_data[index].branchperms;
>+}
>+static inline int set_branchperms(struct super_block *sb, int index, int perms)
>+{
>+	BUG_ON(index < 0);
>+
>+	stopd(sb)->usi_data[index].branchperms = perms;
>+
>+	return perms;
>+}

>+/* What do we use for whiteouts. */
>+#define UNIONFS_WHPFX ".wh."
>+#define UNIONFS_WHLEN 4

#define UNINOFS_WHLEN (sizeof(UNIONFS_WHPFX) - 1)

>+/*
>+ * MACROS:
>+ */
>+
>+#ifndef SEEK_SET
>+#define SEEK_SET 0
>+#endif				/* not SEEK_SET */
>+
>+#ifndef SEEK_CUR
>+#define SEEK_CUR 1
>+#endif				/* not SEEK_CUR */
>+
>+#ifndef SEEK_END
>+#define SEEK_END 2
>+#endif				/* not SEEK_END */

These should really be in include/linux/. Currently, everybody
replicates them or uses hard-coded values :-(

linux-2.6.17.11-jen33$ grep -r SEEK_CUR .;
./drivers/char/mbcs.c:  case 1:         /* SEEK_CUR */
./drivers/isdn/hardware/eicon/dsp_defs.h:#define OS_SEEK_CUR 1
./drivers/mtd/mtdchar.c:                /* SEEK_CUR */
./fs/unionfs/dirfops.c:         case SEEK_CUR:
./fs/unionfs/dirfops.c:         case SEEK_CUR:
./fs/unionfs/unionfs.h:#ifndef SEEK_CUR
./fs/unionfs/unionfs.h:#define SEEK_CUR 1
./fs/unionfs/unionfs.h:#endif                           /* not SEEK_CUR */
./fs/xfs/xfs_vnodeops.c:        case 1: /*SEEK_CUR*/
./fs/locks.c:   case 1: /*SEEK_CUR*/
./fs/locks.c:   case 1: /*SEEK_CUR*/
./security/rpldev.c:#ifndef SEEK_CUR
./security/rpldev.c:#    define SEEK_CUR 1
./security/rpldev.c:    (BufRP). Thus, the only accepted origin is SEEK_CUR, or SEEK_END
./security/rpldev.c:    if(origin != SEEK_CUR)
./security/rpldev.c:            return rpldev_seek(filp, arg, SEEK_CUR);
./sound/core/info.c:            case 1: /* SEEK_CUR */
./sound/drivers/opl4/opl4_proc.c:       case 1: /* SEEK_CUR */
./sound/isa/gus/gus_mem_proc.c: case 1: /* SEEK_CUR */
./sound/pci/mixart/mixart.c:    case 1:  /* SEEK_CUR */
./sound/pci/mixart/mixart.c:    case 1:  /* SEEK_CUR */




Jan Engelhardt
-- 

-- 
VGER BF report: H 0.0197548
