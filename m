Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSG1XjN>; Sun, 28 Jul 2002 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSG1XjN>; Sun, 28 Jul 2002 19:39:13 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:55725 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317431AbSG1XjN>; Sun, 28 Jul 2002 19:39:13 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 28 Jul 2002 16:42:20 -0700
Message-Id: <200207282342.QAA03809@adam.yggdrasil.com>
To: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Patch?: initial ramdisks did not work in 2.5.28-29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Initial ramdisks do not work in linux-2.5.2{8,9}, because
fs/block_dev.c in these kernels has a new version of bd_open()
that does not set bdev->bd_inode->i_size when bdev->bd_openers is
non-zero.

	I would appreciate information on whether this change in
bd_open's behavior is intended.  If it is, then the following
patch makes updates the ramdisk driver to work again.

	Also, I would appreciate knowing if anyone is acting as
maintainer for drivers/block/rd.c, or if I should just send
patches for rd.c directly to Linus if nobody complains on
the linux-kernel mailing list.  I have some other minor patches for rd.c
to reduce its use of minor device numbers, and a patch that someone
whose name I don't remember posted long ago for dropping pages that
contiain all zeroes.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.29/drivers/block/rd.c	2002-07-26 19:58:39.000000000 -0700
+++ linux/drivers/block/rd.c	2002-07-28 16:28:03.000000000 -0700
@@ -379,6 +404,7 @@
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_block_size = rd_blocksize;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_inode->i_size = rd_kbsize[unit] << 10;
 		rd_bdev[unit]->bd_queue = &blk_dev[MAJOR_NR].request_queue;
 	}
 
