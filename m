Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSLPKFB>; Mon, 16 Dec 2002 05:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLPKEI>; Mon, 16 Dec 2002 05:04:08 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:40459 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266640AbSLPKDs>; Mon, 16 Dec 2002 05:03:48 -0500
Date: Mon, 16 Dec 2002 10:11:55 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 9/19
Message-ID: <20021216101155.GJ7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

queue_io() was checking the DMF_SUSPENDED flag rather than the new
DMF_BLOCK_IO flag.  This meant suspend could deadlock under load.
--- diff/drivers/md/dm.c	2002-12-16 09:40:58.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:03.000000000 +0000
@@ -206,7 +206,7 @@
 
 	down_write(&md->lock);
 
-	if (!test_bit(DMF_SUSPENDED, &md->flags)) {
+	if (!test_bit(DMF_BLOCK_IO, &md->flags)) {
 		up_write(&md->lock);
 		free_deferred(di);
 		return 1;
