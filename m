Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTENDQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 23:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTENDQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 23:16:34 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:31730 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S263396AbTENDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 23:16:33 -0400
Date: Tue, 13 May 2003 20:29:20 -0700
From: Christopher Hoover <ch@murgatroid.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.68: Don't include SCSI block ioctls on non-scsi systems
Message-ID: <20030513202710.A32666@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I'm missing something, there doesn't seem to be a good reason
for the block system to include SCSI ioctls unless there's a SCSI
block device (CONFIG_BLK_DEV_SD) in the system.

This is good for embedded systems with tight memory.

-ch

-- 
Christopher Hoover
mailto:ch(at)murgatroid.com
mailto:ch(at)hpl.hp.com


PATCH FOLLOWS
KernelVersion: 2.5.68

diff -Naur -X dontdiff.txt linux-2.5.68-rmk1/drivers/block/Makefile linux-2.5.68-rmk1-ceiva1/drivers/block/Makefile
--- linux-2.5.68-rmk1/drivers/block/Makefile	2003-05-06 11:53:42.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/block/Makefile	2003-05-13 19:58:38.000000000 -0700
@@ -8,8 +8,9 @@
 # In the future, some of these should be built conditionally.
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o deadline-iosched.o
 
+obj-$(CONFIG_BLK_DEV_SD)	+= scsi_ioctl.o 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
