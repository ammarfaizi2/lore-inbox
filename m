Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSG2AOF>; Sun, 28 Jul 2002 20:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSG2AOF>; Sun, 28 Jul 2002 20:14:05 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:18606 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317443AbSG2AOE>; Sun, 28 Jul 2002 20:14:04 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 28 Jul 2002 17:17:07 -0700
Message-Id: <200207290017.RAA00259@baldur.yggdrasil.com>
To: rmk@arm.linux.org.uk, viro@math.psu.edu
Subject: Re: Patch?: initial ramdisks did not work in 2.5.28-29
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002 00:51:56 +0100, Russell King wrote:
>On Sun, Jul 28, 2002 at 04:42:20PM -0700, Adam J. Richter wrote:
>> 	Initial ramdisks do not work in linux-2.5.2{8,9}, because

>Correct.
[...]
>Al has been working on the problem.  To permanently fix it so it doesn't
>break each time a change to do_open() happens.
[...]
>My temporary hack around the problem was to use rd_length[unit] since
>that's already in bytes.
[...]

	Thanks for the quick response.  Your solution is simpler.

	Although some bigger change may be in the works, would anyone
object to my submitting the following patch (your version of the fix)
to Linus in the meantime?  I am cc'ing this message to Al Viro.

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
 
