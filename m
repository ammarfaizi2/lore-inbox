Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSLPKJO>; Mon, 16 Dec 2002 05:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266701AbSLPKH4>; Mon, 16 Dec 2002 05:07:56 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:3087 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266686AbSLPKGx>; Mon, 16 Dec 2002 05:06:53 -0500
Date: Mon, 16 Dec 2002 10:14:59 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 13/19
Message-ID: <20021216101459.GN7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

md->pending was being incremented for each clone rather than just
once. [Kevin Corry]
--- diff/drivers/md/dm.c	2002-12-16 09:41:16.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:21.000000000 +0000
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
 
