Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUJ3Qpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUJ3Qpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUJ3Qpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:45:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36356 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261209AbUJ3QpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:45:22 -0400
Date: Sat, 30 Oct 2004 18:44:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] bio.c: make bio_destructor static
Message-ID: <20041030164450.GN4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bio_destructor in fs/bio.c isn't used outside of this file, and after 
quickly thinking about it I didn't find a reason why it should.

The patch below makes it static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

