Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSL0Vpz>; Fri, 27 Dec 2002 16:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSL0Vpz>; Fri, 27 Dec 2002 16:45:55 -0500
Received: from shay.ecn.purdue.edu ([128.46.209.11]:61641 "EHLO
	shay.ecn.purdue.edu") by vger.kernel.org with ESMTP
	id <S264790AbSL0Vpz>; Fri, 27 Dec 2002 16:45:55 -0500
From: Kevin Corry <corry@ecn.purdue.edu>
Message-Id: <200212272154.gBRLs6kj013449@shay.ecn.purdue.edu>
Subject: [PATCH] dm.c : Correctly initialize bio clone-info index
To: joe@fib011235813.fsnet.co.uk (Joe Thornber)
Date: Fri, 27 Dec 2002 16:54:06 -0500 (EST)
Cc: dm-devel@sistina.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the clone-info's index to the original bio's index. Required to
properly handle stacking DM devices.

--- linux-2.5.53a/drivers/md/dm.c	Mon Dec 23 23:21:04 2002
+++ linux-2.5.53b/drivers/md/dm.c	Fri Dec 27 14:50:29 2002
@@ -475,7 +482,7 @@
 	ci.io->md = md;
 	ci.sector = bio->bi_sector;
 	ci.sector_count = bio_sectors(bio);
-	ci.idx = 0;
+	ci.idx = bio->bi_idx;
 
 	atomic_inc(&md->pending);
 	while (ci.sector_count)
