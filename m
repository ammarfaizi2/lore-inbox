Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSG2O6K>; Mon, 29 Jul 2002 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSG2O6K>; Mon, 29 Jul 2002 10:58:10 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:29125 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317435AbSG2O6J>; Mon, 29 Jul 2002 10:58:09 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 29 Jul 2002 08:01:13 -0700
Message-Id: <200207291501.IAA04761@adam.yggdrasil.com>
To: torvalds@transmeta.com
Subject: PATCH: linux-2.5.29/drivers/block/rd.c did not work with new do_open()
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	linux-2.5.28/drivers/block_dev.c has a new do_open that broke
initial ramdisk support, because it now requires devices that "manually"
set bdev->bd_openers to set bdev->bd_inode->i_size as well.  The
following single line patch, suggested by Russell King, fixes the
problem.

	There does not appear to be anyone acting as maintainer for
rd.c, so I posted to lkml yesterday to ask if anyone objected to my
submitting the patch to you, and I also emailed the message to Russell
King and Al Viro.  Nobody has complained.  I have been running the
patch for almost a day without problems.

	Please apply.  Thanks in advance.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.29/drivers/block/rd.c	2002-07-26 19:58:39.000000000 -0700
+++ linux/drivers/block/rd.c	2002-07-28 16:59:05.000000000 -0700
@@ -379,6 +404,7 @@
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_block_size = rd_blocksize;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_inode->i_size = rd_length[unit];
 		rd_bdev[unit]->bd_queue = &blk_dev[MAJOR_NR].request_queue;
 	}
 
