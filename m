Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267784AbTAHJqr>; Wed, 8 Jan 2003 04:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267785AbTAHJqq>; Wed, 8 Jan 2003 04:46:46 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:39686 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267784AbTAHJqk>; Wed, 8 Jan 2003 04:46:40 -0500
Date: Wed, 8 Jan 2003 09:54:50 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/10] dm: Correct clone info initialisation
Message-ID: <20030108095450.GC2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the clone-info's index to the original bio's index.
Required to properly handle stacking DM devices. [Kevin Corry]
--- diff/drivers/md/dm.c	2002-12-30 10:17:13.000000000 +0000
+++ source/drivers/md/dm.c	2003-01-02 11:10:22.000000000 +0000
@@ -475,7 +475,7 @@
 	ci.io->md = md;
 	ci.sector = bio->bi_sector;
 	ci.sector_count = bio_sectors(bio);
-	ci.idx = 0;
+	ci.idx = bio->bi_idx;
 
 	atomic_inc(&md->pending);
 	while (ci.sector_count)
