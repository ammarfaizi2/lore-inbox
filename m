Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSLKMMP>; Wed, 11 Dec 2002 07:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbSLKMMO>; Wed, 11 Dec 2002 07:12:14 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:3854 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267130AbSLKMMM>; Wed, 11 Dec 2002 07:12:12 -0500
Date: Wed, 11 Dec 2002 12:19:53 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Kevin Corry <corryk@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c  -  device-mapper I/O path fixes
Message-ID: <20021211121953.GC20782@reti>
References: <02121016034706.02220@boiler> <20021211121749.GA20782@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211121749.GA20782@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

md->pending was being incremented for each clone rather than just
once. [Kevin Corry]

--- diff/drivers/md/dm.c	2002-12-11 12:00:34.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-11 12:00:39.000000000 +0000
@@ -310,7 +310,6 @@
 	 * anything, the target has assumed ownership of
 	 * this io.
 	 */
-	atomic_inc(&io->md->pending);
 	atomic_inc(&io->io_count);
 	r = ti->type->map(ti, clone);
 	if (r > 0)
@@ -424,6 +423,7 @@
 	ci.sector_count = bio_sectors(bio);
 	ci.idx = 0;
 
+	atomic_inc(&md->pending);
 	while (ci.sector_count)
 		__clone_and_map(&ci);
 
