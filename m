Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTFIOZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTFIOYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:24:07 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:53766 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264379AbTFIOXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:23:09 -0400
Date: Mon, 9 Jun 2003 15:36:43 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] dm: Lift dm_div_up()
Message-ID: <20030609143643.GE11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pull dm_div_up() out of dm-table.c into dm.h
--- diff/drivers/md/dm-table.c	2003-06-09 15:05:08.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-06-09 15:05:13.000000000 +0100
@@ -56,14 +56,6 @@
 };
 
 /*
- * Ceiling(n / size)
- */
-static inline unsigned long div_up(unsigned long n, unsigned long size)
-{
-	return dm_round_up(n, size) / size;
-}
-
-/*
  * Similar to ceiling(log_size(n))
  */
 static unsigned int int_log(unsigned long n, unsigned long base)
@@ -71,7 +63,7 @@
 	int result = 0;
 
 	while (n > 1) {
-		n = div_up(n, base);
+		n = dm_div_up(n, base);
 		result++;
 	}
 
@@ -664,7 +656,7 @@
 
 	/* allocate the space for *all* the indexes */
 	for (i = t->depth - 2; i >= 0; i--) {
-		t->counts[i] = div_up(t->counts[i + 1], CHILDREN_PER_NODE);
+		t->counts[i] = dm_div_up(t->counts[i + 1], CHILDREN_PER_NODE);
 		total += t->counts[i];
 	}
 
@@ -691,7 +683,7 @@
 	unsigned int leaf_nodes;
 
 	/* how many indexes will the btree have ? */
-	leaf_nodes = div_up(t->num_targets, KEYS_PER_NODE);
+	leaf_nodes = dm_div_up(t->num_targets, KEYS_PER_NODE);
 	t->depth = 1 + int_log(leaf_nodes, CHILDREN_PER_NODE);
 
 	/* leaf layer has already been set up */
--- diff/drivers/md/dm.h	2003-06-09 15:05:08.000000000 +0100
+++ source/drivers/md/dm.h	2003-06-09 15:05:13.000000000 +0100
@@ -135,6 +135,14 @@
 }
 
 /*
+ * Ceiling(n / size)
+ */
+static inline unsigned long dm_div_up(unsigned long n, unsigned long size)
+{
+	return dm_round_up(n, size) / size;
+}
+
+/*
  * The device-mapper can be driven through one of two interfaces;
  * ioctl or filesystem, depending which patch you have applied.
  */
