Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316209AbSETTIF>; Mon, 20 May 2002 15:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSETTIE>; Mon, 20 May 2002 15:08:04 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:16634 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316209AbSETTID>;
	Mon, 20 May 2002 15:08:03 -0400
Date: Mon, 20 May 2002 12:07:56 -0700
From: Christopher Hoover <ch@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ch@murgatroid.com
Subject: [PATCH] SCSI as module lossage in 2.5.1[56]
Message-ID: <20020520120756.A8951@friction.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI as a module (CONFIG_SCSI=m) loses in 2.5.1[56] because scsi_mod.o
needs drivers/block/ll_rw_blk.c:blk_max_pfn and that symbol isn't exported.

Fix below. Please apply.

-ch
Christopher Hoover
mailto:ch@hpl.hp.com
mailto:ch@murgatroid.com

diff -X dontdiff.txt -Naur linux-2.5.16.orig/drivers/block/ll_rw_blk.c linux-2.5.16/drivers/block/ll_rw_blk.c
--- linux-2.5.16.orig/drivers/block/ll_rw_blk.c	Sat May 18 00:45:57 2002
+++ linux-2.5.16/drivers/block/ll_rw_blk.c	Mon May 20 11:49:57 2002
@@ -1926,6 +1926,7 @@
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
 EXPORT_SYMBOL(blk_attempt_remerge);
+EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_queue_max_sectors);
 EXPORT_SYMBOL(blk_queue_max_phys_segments);
