Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbULGTse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbULGTse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbULGTis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:38:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41995 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261902AbULGTf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:29 -0500
Date: Tue, 7 Dec 2004 20:35:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] bio.c: make bio_destructor static (fwd)
Message-ID: <20041207193522.GC7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 18:44:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] bio.c: make bio_destructor static


bio_destructor in fs/bio.c isn't used outside of this file, and after 
quickly thinking about it I didn't find a reason why it should.

The patch below makes it static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Jens Axboe <axboe@suse.de>

--- linux-2.6.10-rc1-mm2-full/fs/bio.c.old	2004-10-30 13:53:41.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/bio.c	2004-10-30 13:56:16.000000000 +0200
@@ -91,7 +91,7 @@
 /*
  * default destructor for a bio allocated with bio_alloc()
  */
-void bio_destructor(struct bio *bio)
+static void bio_destructor(struct bio *bio)
 {
 	const int pool_idx = BIO_POOL_IDX(bio);
 	struct biovec_pool *bp = bvec_array + pool_idx;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

