Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSABBnc>; Tue, 1 Jan 2002 20:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286584AbSABBnM>; Tue, 1 Jan 2002 20:43:12 -0500
Received: from fep04.swip.net ([130.244.199.132]:52711 "EHLO
	fep04-svc.swip.net") by vger.kernel.org with ESMTP
	id <S286575AbSABBnE>; Tue, 1 Jan 2002 20:43:04 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel BUG at scsi_merge.c:83
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2002 02:38:01 +0100
Message-ID: <m2zo3xr0qu.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While doing some stress testing on the 2.5.2-pre5 kernel, I am hitting
a kernel BUG at scsi_merge.c:83, followed by a kernel panic. The
problem is that scsi_alloc_sgtable fails because the request contains
too many physical segments. I think this patch is the correct fix:

--- linux-2.5.2-pre5/drivers/scsi/scsi.c	Fri Dec 28 12:38:01 2001
+++ linux-2.5-packet/drivers/scsi/scsi.c	Wed Jan  2 02:27:45 2002
@@ -201,11 +201,6 @@
 	/* Hardware imposed limit. */
 	blk_queue_max_hw_segments(q, SHpnt->sg_tablesize);
 
-	/*
-	 * When we remove scsi_malloc soonish, this can die too
-	 */
-	blk_queue_max_phys_segments(q, PAGE_SIZE / sizeof(struct scatterlist));
-
 	blk_queue_max_sectors(q, SHpnt->max_sectors);
 
 	if (!SHpnt->use_clustering)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
