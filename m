Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbTA0FUz>; Mon, 27 Jan 2003 00:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbTA0FUz>; Mon, 27 Jan 2003 00:20:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18525 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267124AbTA0FUy>; Mon, 27 Jan 2003 00:20:54 -0500
Date: Mon, 27 Jan 2003 00:30:11 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch for fs/partitions/sun.c
Message-ID: <20030127003011.B9530@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boots with recent 2.5 greet me with this on the console:

[/sbin/fsck.ext2] fsck.ext2 -a /dev/sda6
fsck.ext2: Device not configured while trying to open /dev/sda6

This happens because I have root on /dev/sda4 and /home on /dev/sda6.
Dave, can you take it or should I send it to Trivial?

-- Pete

diff -urN -X dontdiff linux-2.5.59/fs/partitions/sun.c linux-2.5.59-sparc/fs/partitions/sun.c
--- linux-2.5.59/fs/partitions/sun.c	2003-01-13 21:59:16.000000000 -0800
+++ linux-2.5.59-sparc/fs/partitions/sun.c	2003-01-26 15:54:03.000000000 -0800
@@ -80,8 +80,8 @@
 			put_partition(state, slot, st_sector, num_sectors);
 			if (label->infos[i].id == LINUX_RAID_PARTITION)
 				state->parts[slot].flags = 1;
-			slot++;
 		}
+		slot++;
 	}
 	printk("\n");
 	put_dev_sector(sect);
