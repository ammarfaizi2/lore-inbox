Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUABNjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUABNjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:39:09 -0500
Received: from smtp5.hy.skanova.net ([195.67.199.134]:5619 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265533AbUABNjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:39:05 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
	<20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com>
	<1073034412.4429.1.camel@laptop.fenrus.com> <m2k74a8vyr.fsf@telia.com>
	<20040102105915.GO5523@suse.de> <m2brpm8sc2.fsf@telia.com>
	<20040102121904.GQ5523@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2004 14:38:51 +0100
In-Reply-To: <20040102121904.GQ5523@suse.de>
Message-ID: <m2vfnu79n8.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> I just looked but could not find anything about it, there's been some
> talk on this list. But it doesn't look like it ever got documented in
> text writing. That needs to be fixed for sure, thanks for the patch. It
> probably wants documenting in fs/bio.c:bio_add_page() too.

OK, here is an updated patch.

Improved documentation for blk_queue_merge_bvec() and bio_add_page().


 linux-petero/drivers/block/ll_rw_blk.c |    8 +++++---
 linux-petero/fs/bio.c                  |    4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~block-api-doc drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c~block-api-doc	2004-01-02 13:54:38.000000000 +0100
+++ linux-petero/drivers/block/ll_rw_blk.c	2004-01-02 13:55:50.000000000 +0100
@@ -173,9 +173,11 @@ EXPORT_SYMBOL(blk_queue_prep_rq);
  * are dynamic, and thus we have to query the queue whether it is ok to
  * add a new bio_vec to a bio at a given offset or not. If the block device
  * has such limitations, it needs to register a merge_bvec_fn to control
- * the size of bio's sent to it. Per default now merge_bvec_fn is defined for
- * a queue, and only the fixed limits are honored.
- *
+ * the size of bio's sent to it. Note that a block device *must* allow a
+ * single page to be added to an empty bio. The block device driver may want
+ * to use the bio_split() function to deal with these bio's. Per default
+ * no merge_bvec_fn is defined for a queue, and only the fixed limits are
+ * honored.
  */
 void blk_queue_merge_bvec(request_queue_t *q, merge_bvec_fn *mbfn)
 {
diff -puN fs/bio.c~block-api-doc fs/bio.c
--- linux/fs/bio.c~block-api-doc	2004-01-02 14:00:13.000000000 +0100
+++ linux-petero/fs/bio.c	2004-01-02 14:37:41.000000000 +0100
@@ -290,7 +290,9 @@ int bio_get_nr_vecs(struct block_device 
  *
  *	Attempt to add a page to the bio_vec maplist. This can fail for a
  *	number of reasons, such as the bio being full or target block
- *	device limitations.
+ *	device limitations. The target block device must not disallow bio's
+ *	smaller than PAGE_SIZE, so it is always possible to add a single
+ *	page to an empty bio.
  */
 int bio_add_page(struct bio *bio, struct page *page, unsigned int len,
 		 unsigned int offset)

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
