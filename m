Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSLPKEG>; Mon, 16 Dec 2002 05:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLPKC2>; Mon, 16 Dec 2002 05:02:28 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:15888 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266560AbSLPKCT>; Mon, 16 Dec 2002 05:02:19 -0500
Date: Mon, 16 Dec 2002 10:10:25 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 7/19
Message-ID: <20021216101025.GH7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in the dm-stripe.c constructor failing top check if enough
destinations are handed in. [Heinz Mauelshagen]
--- diff/drivers/md/dm-stripe.c	2002-12-16 09:40:48.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2002-12-16 09:40:53.000000000 +0000
@@ -131,6 +131,15 @@
 		return -EINVAL;
 	}
 
+	/*
+	 * Do we have enough arguments for that many stripes ?
+	 */
+	if (argc != (2 + 2 * stripes)) {
+		ti->error = "dm-stripe: Not enough destinations "
+			"specified";
+		return -EINVAL;
+	}
+
 	sc = alloc_context(stripes);
 	if (!sc) {
 		ti->error = "dm-stripe: Memory allocation for striped context "
@@ -151,13 +160,6 @@
 	 * Get the stripe destinations.
 	 */
 	for (i = 0; i < stripes; i++) {
-		if (argc < 2) {
-			ti->error = "dm-stripe: Not enough destinations "
-				"specified";
-			kfree(sc);
-			return -EINVAL;
-		}
-
 		argv += 2;
 
 		r = get_stripe(ti, sc, i, argv);
