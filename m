Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWDYSTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWDYSTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWDYSTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:19:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:47463 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932263AbWDYSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:19:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:from;
        b=Va10Kr3tCRaj2rxHUNyMRGzcj/boZA7Z4mB4EqURp0ng8B8FVolA4ChkmyQ8caAsh/bp2upCGNP4WGNBirOS9bfTR7BV+OXQYZaxbtM93n+dn98Inc1F0CJA/25a9kR3UMkmU8spE96JwL/B1JZQnoki63Xp387Vzk4W1Qj4XJ8=
Date: Tue, 25 Apr 2006 11:18:02 -0700 (PDT)
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, axboe@suse.de
Subject: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Message-ID: <Pine.LNX.4.64.0604251112490.5810@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With likely/unlikely profiling (see the recent patch dwalker@mvista.com sent), on my not-so-busy-typical-development system it shows more than 80K misses and no hits. So I guess it makes sense to revert.

I don't know BIO code very well, but I hope this data is useful for the experts.

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 1755c05..499da1c 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1432,7 +1432,7 @@ static int ll_back_merge_fn(request_queu
  	}
  	if (unlikely(!bio_flagged(req->biotail, BIO_SEG_VALID)))
  		blk_recount_segments(q, req->biotail);
-	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
+	if (likely(!bio_flagged(bio, BIO_SEG_VALID)))
  		blk_recount_segments(q, bio);
  	len = req->biotail->bi_hw_back_size + bio->bi_hw_front_size;
  	if (BIOVEC_VIRT_MERGEABLE(__BVEC_END(req->biotail), __BVEC_START(bio)) &&
