Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTHUPCQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTHUPCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:02:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34251 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262719AbTHUPCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:02:12 -0400
Date: Thu, 21 Aug 2003 16:02:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [PATCH] bio.c: reduce verbosity at boot
Message-ID: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux is really far too verbose at boot time.  I don't think these messages
add anything to either the end user experience or debug ability.

Index: fs/bio.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/bio.c,v
retrieving revision 1.2
diff -u -p -r1.2 bio.c
--- fs/bio.c	29 Jul 2003 17:25:49 -0000	1.2
+++ fs/bio.c	21 Aug 2003 14:58:40 -0000
@@ -793,10 +793,6 @@ static void __init biovec_init_pools(voi
 					mempool_free_slab, bp->slab);
 		if (!bp->pool)
 			panic("biovec: can't init mempool\n");
-
-		printk("biovec pool[%d]: %3d bvecs: %3d entries (%d bytes)\n",
-						i, bp->nr_vecs, pool_entries,
-						size);
 	}
 }
 
@@ -809,8 +805,6 @@ static int __init init_bio(void)
 	bio_pool = mempool_create(BIO_POOL_SIZE, mempool_alloc_slab, mempool_free_slab, bio_slab);
 	if (!bio_pool)
 		panic("bio: can't create mempool\n");
-
-	printk("BIO: pool of %d setup, %ZuKb (%Zd bytes/bio)\n", BIO_POOL_SIZE, BIO_POOL_SIZE * sizeof(struct bio) >> 10, sizeof(struct bio));
 
 	biovec_init_pools();
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
