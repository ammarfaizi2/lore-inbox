Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270710AbRHPCku>; Wed, 15 Aug 2001 22:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270713AbRHPCkl>; Wed, 15 Aug 2001 22:40:41 -0400
Received: from rj.sgi.com ([204.94.215.100]:13704 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S270710AbRHPCkZ>;
	Wed, 15 Aug 2001 22:40:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: daddr_t is inconsistent and barely used
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Aug 2001 12:40:32 +1000
Message-ID: <9980.997929632@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daddr_t is barely used in the kernel.  2.4.8.

fs/freevxfs/vxfs.h:   daddr_t                 vsi_oltext;     /* OLT extent */
fs/freevxfs/vxfs.h:   daddr_t                 vsi_oltsize;    /* OLT size */
fs/freevxfs/vxfs_bmap.c:static daddr_t
fs/freevxfs/vxfs_bmap.c:              daddr_t                 pblock;
fs/freevxfs/vxfs_bmap.c:static daddr_t
fs/freevxfs/vxfs_bmap.c:      daddr_t                         pblock = 0;
fs/freevxfs/vxfs_bmap.c:static daddr_t
fs/freevxfs/vxfs_bmap.c:      daddr_t                         pblock = 0;
fs/freevxfs/vxfs_bmap.c:daddr_t
fs/freevxfs/vxfs_extern.h:extern daddr_t                      vxfs_bmap1(struct inode *, long);
fs/freevxfs/vxfs_olt.c:vxfs_oblock(daddr_t oblock, u_long bsize)
fs/freevxfs/vxfs_subr.c:      daddr_t                 pblock;
fs/freevxfs/vxfs_subr.c:      daddr_t                 pblock;
include/linux/genhd.h:        daddr_t s_start;                /* start sector no of partition */
include/linux/types.h:typedef __kernel_daddr_t        daddr_t;
arch/parisc/hpux/sys_hpux.c:  int32_t         f_tfree;        /* total free (daddr_t)  */

The use of daddr_t in freevxfs may give different in core and disk
layouts on different machines.  Is that intended?.

Its definition is not consistent.  Some 32 bit machines use int, some
use long.  Some 64 bit machines use int, some use long.

include/linux/types.h:typedef __kernel_daddr_t        daddr_t;
include/linux/types.h:        __kernel_daddr_t        f_tfree;
include/linux/mtio.h: __kernel_daddr_t mt_fileno;     /* number of current file on tape */
include/linux/mtio.h: __kernel_daddr_t mt_blkno;      /* current block number */
include/asm-i386/posix_types.h:typedef int            __kernel_daddr_t;
include/asm-mips/posix_types.h:typedef long           __kernel_daddr_t;
include/asm-alpha/posix_types.h:typedef int           __kernel_daddr_t;
include/asm-m68k/posix_types.h:typedef int            __kernel_daddr_t;
include/asm-sparc/posix_types.h:typedef long                   __kernel_daddr_t;
include/asm-ppc/posix_types.h:typedef int             __kernel_daddr_t;
include/asm-sparc64/posix_types.h:typedef int                    __kernel_daddr_t;
include/asm-arm/posix_types.h:typedef int                     __kernel_daddr_t;
include/asm-sh/posix_types.h:typedef int              __kernel_daddr_t;
include/asm-ia64/posix_types.h:typedef int            __kernel_daddr_t;
include/asm-mips64/posix_types.h:typedef long         __kernel_daddr_t;
include/asm-s390/posix_types.h:typedef int             __kernel_daddr_t;
include/asm-parisc/posix_types.h:typedef int                  __kernel_daddr_t;
include/asm-cris/posix_types.h:typedef int            __kernel_daddr_t;
include/asm-s390x/posix_types.h:typedef int             __kernel_daddr_t;

Do we still need daddr_t?

This question was raised when I saw patches for ia64 that replaced u32
with unsigned long because ia64 needs 64 bit.  Shouldn't we be using a
consistent type that holds kernel addresses as numbers?  off_t and
loff_t are not suitable.  caddr_t is close but uses char *, sometimes
you want just a number.  What about defining kaddr_t?

