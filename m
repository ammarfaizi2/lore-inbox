Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285336AbRLNLwv>; Fri, 14 Dec 2001 06:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbRLNLwl>; Fri, 14 Dec 2001 06:52:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48531 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285336AbRLNLwe>;
	Fri, 14 Dec 2001 06:52:34 -0500
Date: Fri, 14 Dec 2001 14:49:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [patch] mempool-2.5.1-D0
Message-ID: <Pine.LNX.4.33.0112141446030.8724-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch against -pre11 fixes a possible deadlock pointed out by
Arjan: gfp_nowait needs to exclude __GFP_IO as well, to avoid some of the
deeper deadlocks where the first ->alloc() would generate IO.

	Ingo

--- linux/mm/mempool.c.orig	Fri Dec 14 12:34:08 2001
+++ linux/mm/mempool.c	Fri Dec 14 12:35:53 2001
@@ -185,7 +185,7 @@
 	struct list_head *tmp;
 	int curr_nr;
 	DECLARE_WAITQUEUE(wait, current);
-	int gfp_nowait = gfp_mask & ~__GFP_WAIT;
+	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);

 repeat_alloc:
 	element = pool->alloc(gfp_nowait, pool->pool_data);


