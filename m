Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSFQGwC>; Mon, 17 Jun 2002 02:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316777AbSFQGta>; Mon, 17 Jun 2002 02:49:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316780AbSFQGsN>;
	Mon, 17 Jun 2002 02:48:13 -0400
Message-ID: <3D0D871F.89089870@zip.com.au>
Date: Sun, 16 Jun 2002 23:52:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 8/19] go back to 256 requests per queue
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The request queue was increased from 256 slots to 512 in 2.5.20.  The
throughput of `dbench 128' on Randy's 384 megabyte machine fell 40%.

We do need to understand why that happened, and what we can learn from
it.  But in the meanwhile I'd suggest that we go back to 256 slots so
that this known problem doesn't impact people's evaluation and tuning
of 2.5 performance.



--- 2.5.22/drivers/block/ll_rw_blk.c~256-requests	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/drivers/block/ll_rw_blk.c	Sun Jun 16 23:22:46 2002
@@ -2002,8 +2002,8 @@ int __init blk_dev_init(void)
 	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
 	if (queue_nr_requests < 32)
 		queue_nr_requests = 32;
-	if (queue_nr_requests > 512)
-		queue_nr_requests = 512;
+	if (queue_nr_requests > 256)
+		queue_nr_requests = 256;
 
 	/*
 	 * Batch frees according to queue length

-
