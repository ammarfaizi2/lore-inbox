Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSLPKMl>; Mon, 16 Dec 2002 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbSLPKLu>; Mon, 16 Dec 2002 05:11:50 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:19217 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266760AbSLPKLG>; Mon, 16 Dec 2002 05:11:06 -0500
Date: Mon, 16 Dec 2002 10:19:12 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 19/19
Message-ID: <20021216101912.GT7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linear target was getting the start sector wrong when doing a
dm_get_device(). [Kevin Corry]
--- diff/drivers/md/dm-linear.c	2002-11-18 10:11:54.000000000 +0000
+++ source/drivers/md/dm-linear.c	2002-12-16 09:43:39.000000000 +0000
@@ -43,7 +43,7 @@
 		goto bad;
 	}
 
-	if (dm_get_device(ti, argv[0], ti->begin, ti->len,
+	if (dm_get_device(ti, argv[0], lc->start, ti->len,
 			  dm_table_get_mode(ti->table), &lc->dev)) {
 		ti->error = "dm-linear: Device lookup failed";
 		goto bad;
