Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWELGIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWELGIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWELGIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:08:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:16071 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750951AbWELGIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:08:15 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:59 +1000
Message-Id: <1060512060759.8061@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 006 of 8] md/bitmap: Remove dead code from md/bitmap.
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bitmap_active is never called, and the BITMAP_ACTIVE flag is
never users or tested, so discard them both.

Also remove some out-of-date 'todo' comments.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |   22 ----------------------
 1 file changed, 22 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-12 15:58:57.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-12 15:59:53.000000000 +1000
@@ -14,9 +14,6 @@
  *
  * flush after percent set rather than just time based. (maybe both).
  * wait if count gets too high, wake when it drops to half.
- * allow bitmap to be mirrored with superblock (before or after...)
- * allow hot-add to re-instate a current device.
- * allow hot-add of bitmap after quiessing device
  */
 
 #include <linux/module.h>
@@ -70,23 +67,6 @@ static inline char * bmname(struct bitma
 	return bitmap->mddev ? mdname(bitmap->mddev) : "mdX";
 }
 
-
-/*
- * test if the bitmap is active
- */
-int bitmap_active(struct bitmap *bitmap)
-{
-	unsigned long flags;
-	int res = 0;
-
-	if (!bitmap)
-		return res;
-	spin_lock_irqsave(&bitmap->lock, flags);
-	res = bitmap->flags & BITMAP_ACTIVE;
-	spin_unlock_irqrestore(&bitmap->lock, flags);
-	return res;
-}
-
 #define WRITE_POOL_SIZE 256
 
 /*
@@ -1496,8 +1476,6 @@ int bitmap_create(mddev_t *mddev)
 	if (!bitmap->bp)
 		goto error;
 
-	bitmap->flags |= BITMAP_ACTIVE;
-
 	/* now that we have some pages available, initialize the in-memory
 	 * bitmap from the on-disk bitmap */
 	start = 0;
