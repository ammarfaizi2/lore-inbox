Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSLPKGn>; Mon, 16 Dec 2002 05:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLPKFP>; Mon, 16 Dec 2002 05:05:15 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:27916 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266548AbSLPKFI>; Mon, 16 Dec 2002 05:05:08 -0500
Date: Mon, 16 Dec 2002 10:13:14 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 11/19
Message-ID: <20021216101314.GL7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blk_run_queues() call to encourage pending io to flush
when we're doing a dm_suspend().
--- diff/drivers/md/dm.c	2002-12-16 09:41:08.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:12.000000000 +0000
@@ -722,6 +722,7 @@
 	 * Then we wait for the already mapped ios to
 	 * complete.
 	 */
+	blk_run_queues();
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
