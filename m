Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSKABNX>; Thu, 31 Oct 2002 20:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265261AbSKABNX>; Thu, 31 Oct 2002 20:13:23 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:23544 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265242AbSKABNK>; Thu, 31 Oct 2002 20:13:10 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.54950.583655.36894@wombat.chubb.wattle.id.au>
Date: Fri, 1 Nov 2002 12:19:34 +1100
To: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: [PATCH] Large block devices for linux 2.4
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, all you people who were asking for it...

There are patches up on the website for Linux 2.4.20-rc1 and for the
latest IA64 2.4 kernel at 
       http://www.gelato.unsw.edu.au/patches/

There's also a bk tree for the IA64 version at
bk://gelato,unsw.edu.au:2026 

I'm not suggesting that this patch be merged into the standard 2.4
kernels --- it's too invasive --- but it'll do as an interim measure
for people who can't/won't use 2.5 until 2.6 is stable.

Tested on ia32 with loopback device, on IA64 with 3TB of attached disc
on a megaraid controller and software raid.

 Documentation/Configure.help    |    5 ++
 drivers/block/Config.in         |    3 +
 drivers/block/DAC960.c          |   15 ++++--
 drivers/block/DAC960.h          |    2 
 drivers/block/blkpg.c           |   13 +++--
 drivers/block/cciss.c           |   12 +----
 drivers/block/cciss.h           |    2 
 drivers/block/cpqarray.c        |    8 ---
 drivers/block/cpqarray.h        |    2 
 drivers/block/floppy.c          |   84 +++++++++++++++++------------------
 drivers/block/genhd.c           |    8 +--
 drivers/block/ll_rw_blk.c       |   28 ++++++-----
 drivers/block/loop.c            |   96 ++++++++++++++++++++++++++++------------
 drivers/block/nbd.c             |    2 
 drivers/block/ps2esdi.c         |    4 -
 drivers/block/rd.c              |    2 
 drivers/block/umem.c            |    2 
 drivers/block/xd.c              |    2 
 drivers/char/raw.c              |    3 -
 drivers/ide/ataraid.c           |    2 
 drivers/ide/ide-cd.c            |   11 ++--
 drivers/ide/ide-disk.c          |   46 ++++++++++++-------
 drivers/ide/ide-floppy.c        |   11 ++--
 drivers/ide/ide-probe.c         |    2 
 drivers/ide/ide-tape.c          |    4 -
 drivers/ide/ide.c               |    9 ++-
 drivers/ieee1394/sbp2.c         |    4 -
 drivers/md/linear.c             |   44 +++++++++++++-----
 drivers/md/lvm-snap.c           |   12 ++---
 drivers/md/lvm.c                |    2 
 drivers/md/md.c                 |   68 ++++++++++++----------------
 drivers/md/multipath.c          |   12 ++---
 drivers/md/raid0.c              |   25 +++++++---
 drivers/md/raid1.c              |   14 ++---
 drivers/message/i2o/i2o_block.c |    2 
 drivers/mtd/devices/blkmtd.c    |    4 -
 drivers/mtd/mtdblock.c          |    2 
 drivers/scsi/3w-xxxx.c          |    4 -
 drivers/scsi/advansys.c         |    2 
 drivers/scsi/aha152x.c          |    4 -
 drivers/scsi/aic7xxx_old.c      |    4 -
 drivers/scsi/atp870u.c          |    4 -
 drivers/scsi/ibmmca.c           |    6 +-
 drivers/scsi/ide-scsi.c         |    4 -
 drivers/scsi/imm.c              |    4 -
 drivers/scsi/in2000.c           |    6 +-
 drivers/scsi/ini9100u.c         |    6 +-
 drivers/scsi/inia100.c          |    6 +-
 drivers/scsi/ips.c              |    2 
 drivers/scsi/megaraid.c         |    8 +--
 drivers/scsi/ppa.c              |    4 -
 drivers/scsi/qla1280.c          |    6 +-
 drivers/scsi/qlogicfas.c        |    4 -
 drivers/scsi/scsi.c             |    4 -
 drivers/scsi/scsi_lib.c         |    4 -
 drivers/scsi/sd.c               |   47 +++++++++++--------
 drivers/scsi/sd.h               |    2 
 drivers/scsi/sr.c               |   20 ++++----
 drivers/scsi/wd7000.c           |    4 -
 fs/adfs/adfs.h                  |    2 
 fs/adfs/inode.c                 |    4 -
 fs/affs/file.c                  |   12 +++--
 fs/affs/super.c                 |    1 
 fs/befs/linuxvfs.c              |   11 ++--
 fs/bfs/file.c                   |    4 -
 fs/block_dev.c                  |   12 ++---
 fs/buffer.c                     |   30 ++++++------
 fs/efs/file.c                   |    2 
 fs/efs/inode.c                  |    4 -
 fs/ext2/inode.c                 |    7 +-
 fs/ext3/ialloc.c                |    4 -
 fs/ext3/inode.c                 |    4 -
 fs/fat/file.c                   |    6 +-
 fs/fat/inode.c                  |    2 
 fs/fat/misc.c                   |    4 -
 fs/freevxfs/vxfs_kcompat.h      |    4 -
 fs/freevxfs/vxfs_subr.c         |    6 +-
 fs/hfs/file.c                   |    2 
 fs/hfs/hfs.h                    |    2 
 fs/hfs/inode.c                  |    2 
 fs/hpfs/file.c                  |    4 -
 fs/hpfs/hpfs_fn.h               |    2 
 fs/inode.c                      |    4 -
 fs/isofs/inode.c                |   11 ++--
 fs/jbd/commit.c                 |    4 -
 fs/jbd/journal.c                |    4 -
 fs/jbd/revoke.c                 |    2 
 fs/jfs/inode.c                  |    6 +-
 fs/minix/inode.c                |    4 -
 fs/minix/itree_common.c         |    2 
 fs/partitions/acorn.c           |    2 
 fs/partitions/acorn.h           |    2 
 fs/partitions/amiga.c           |    2 
 fs/partitions/amiga.h           |    2 
 fs/partitions/atari.c           |    2 
 fs/partitions/atari.h           |    2 
 fs/partitions/check.c           |   19 +++----
 fs/partitions/check.h           |    4 -
 fs/partitions/efi.c             |    2 
 fs/partitions/efi.h             |    2 
 fs/partitions/ldm.c             |    2 
 fs/partitions/ldm.h             |    2 
 fs/partitions/mac.c             |    2 
 fs/partitions/mac.h             |    2 
 fs/partitions/msdos.c           |    2 
 fs/partitions/msdos.h           |    2 
 fs/partitions/osf.c             |    2 
 fs/partitions/osf.h             |    2 
 fs/partitions/sgi.c             |    2 
 fs/partitions/sgi.h             |    2 
 fs/partitions/sun.c             |    2 
 fs/partitions/sun.h             |    2 
 fs/partitions/ultrix.c          |    2 
 fs/partitions/ultrix.h          |    2 
 fs/qnx4/inode.c                 |    4 -
 fs/reiserfs/inode.c             |   37 +++++++++------
 fs/reiserfs/journal.c           |   15 +++---
 fs/reiserfs/prints.c            |   40 ++++++++--------
 fs/reiserfs/super.c             |   14 ++---
 fs/sysv/itree.c                 |    4 -
 fs/udf/inode.c                  |    6 +-
 fs/ufs/inode.c                  |    4 -
 include/asm-i386/types.h        |    4 +
 include/asm-ppc/types.h         |    6 ++
 include/linux/blkdev.h          |   25 ++++++++--
 include/linux/fs.h              |   30 ++++++------
 include/linux/genhd.h           |    6 +-
 include/linux/ide.h             |    4 -
 include/linux/iobuf.h           |    4 -
 include/linux/iso_fs.h          |    4 -
 include/linux/loop.h            |    4 -
 include/linux/msdos_fs.h        |    2 
 include/linux/qnx4_fs.h         |    2 
 include/linux/raid/linear.h     |    4 -
 include/linux/raid/md.h         |    2 
 include/linux/raid/md_k.h       |    4 -
 include/linux/types.h           |    4 +
 mm/page_io.c                    |    4 -
 138 files changed, 667 insertions(+), 523 deletions(-)
