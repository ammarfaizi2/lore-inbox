Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRJKXay>; Thu, 11 Oct 2001 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277065AbRJKXae>; Thu, 11 Oct 2001 19:30:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:745 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277064AbRJKXaZ>;
	Thu, 11 Oct 2001 19:30:25 -0400
Date: Thu, 11 Oct 2001 19:30:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christian Ullrich <chris@chrullrich.de>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <Pine.GSO.4.21.0110111835360.24742-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110111929060.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Rediffed against 13-pre1:
--- linux/fs/partitions/check.c	Thu Oct 11 19:25:03 2001
+++ linux/fs/partitions/check.c.fixed	Thu Oct 11 18:39:41 2001
@@ -386,6 +386,12 @@
 	if (!size || minors == 1)
 		return;
 
+	if (dev->sizes) {
+		dev->sizes[first_minor] = size >> (BLOCK_SIZE_BITS - 9);
+		for (i = first_minor + 1; i < end_minor; i++)
+			dev->sizes[i] = 0;
+	}
+	blk_size[dev->major] = dev->sizes;
 	check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);
 
  	/*
@@ -395,7 +401,6 @@
 	if (dev->sizes != NULL) {	/* optional safeguard in ll_rw_blk.c */
 		for (i = first_minor; i < end_minor; i++)
 			dev->sizes[i] = dev->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
-		blk_size[dev->major] = dev->sizes;
 	}
 }
 


