Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSLPJ73>; Mon, 16 Dec 2002 04:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbSLPJ72>; Mon, 16 Dec 2002 04:59:28 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:39950 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266555AbSLPJ6v>; Mon, 16 Dec 2002 04:58:51 -0500
Date: Mon, 16 Dec 2002 10:06:57 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2/19
Message-ID: <20021216100657.GC7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An error value was not being checked correctly in open_dev().
[Kevin Corry]
--- diff/drivers/md/dm-table.c	2002-11-28 11:30:39.000000000 +0000
+++ source/drivers/md/dm-table.c	2002-12-16 09:40:30.000000000 +0000
@@ -356,7 +356,7 @@
 		return -ENOMEM;
 
 	r = blkdev_get(d->bdev, d->mode, 0, BDEV_RAW);
-	if (!r)
+	if (r)
 		return r;
 
 	r = bd_claim(d->bdev, _claim_ptr);
