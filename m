Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWEPSsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWEPSsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbWEPSsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:48:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751623AbWEPSsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:48:53 -0400
Date: Tue, 16 May 2006 20:48:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/bio.c: possible cleanups
Message-ID: <20060516184850.GR10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the follwing needlessly global function static:
  - __bio_clone()
- don't mark the following _global_ functions as inline:
  - bio_phys_segments()
  - bio_hw_segments()
- remove the following unused EXPORT_SYMBOL's:
  - bio_phys_segments
  - bio_hw_segments
  - bio_map_kern
  - bio_copy_user
  - bio_uncopy_user

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 23 Apr 2006

 fs/bio.c            |   12 +++---------
 include/linux/bio.h |    1 -
 2 files changed, 3 insertions(+), 10 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/bio.h.old	2006-04-23 12:02:44.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/bio.h	2006-04-23 12:02:50.000000000 +0200
@@ -286,7 +286,6 @@
 extern int bio_phys_segments(struct request_queue *, struct bio *);
 extern int bio_hw_segments(struct request_queue *, struct bio *);
 
-extern void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, gfp_t);
 
 extern void bio_init(struct bio *);
--- linux-2.6.17-rc1-mm3-full/fs/bio.c.old	2006-04-23 12:02:57.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/bio.c	2006-04-23 12:06:04.000000000 +0200
@@ -229,7 +229,7 @@
 	}
 }
 
-inline int bio_phys_segments(request_queue_t *q, struct bio *bio)
+int bio_phys_segments(request_queue_t *q, struct bio *bio)
 {
 	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
 		blk_recount_segments(q, bio);
@@ -237,7 +237,7 @@
 	return bio->bi_phys_segments;
 }
 
-inline int bio_hw_segments(request_queue_t *q, struct bio *bio)
+int bio_hw_segments(request_queue_t *q, struct bio *bio)
 {
 	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
 		blk_recount_segments(q, bio);
@@ -254,7 +254,7 @@
  *	the actual data it points to. Reference count of returned
  * 	bio will be one.
  */
-void __bio_clone(struct bio *bio, struct bio *bio_src)
+static void __bio_clone(struct bio *bio, struct bio *bio_src)
 {
 	request_queue_t *q = bdev_get_queue(bio_src->bi_bdev);
 
@@ -1243,21 +1243,15 @@
 EXPORT_SYMBOL(bio_free);
 EXPORT_SYMBOL(bio_endio);
 EXPORT_SYMBOL(bio_init);
-EXPORT_SYMBOL(__bio_clone);
 EXPORT_SYMBOL(bio_clone);
-EXPORT_SYMBOL(bio_phys_segments);
-EXPORT_SYMBOL(bio_hw_segments);
 EXPORT_SYMBOL(bio_add_page);
 EXPORT_SYMBOL(bio_add_pc_page);
 EXPORT_SYMBOL(bio_get_nr_vecs);
 EXPORT_SYMBOL(bio_map_user);
 EXPORT_SYMBOL(bio_unmap_user);
-EXPORT_SYMBOL(bio_map_kern);
 EXPORT_SYMBOL(bio_pair_release);
 EXPORT_SYMBOL(bio_split);
 EXPORT_SYMBOL(bio_split_pool);
-EXPORT_SYMBOL(bio_copy_user);
-EXPORT_SYMBOL(bio_uncopy_user);
 EXPORT_SYMBOL(bioset_create);
 EXPORT_SYMBOL(bioset_free);
 EXPORT_SYMBOL(bio_alloc_bioset);

