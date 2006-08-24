Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWHXHlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWHXHlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWHXHlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:41:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:34772 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750766AbWHXHlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:41:01 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:41:01 +1000
Message-Id: <1060824074101.19135@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 4] md: Fix recent breakage of md/raid1 array checking
References: <20060824173647.19026.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A recent patch broke the ability to do a 
user-request check of a raid1.
This patch fixes the breakage and also moves a comment that
was dislocated by the same patch.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-08-24 17:09:42.000000000 +1000
+++ ./drivers/md/raid1.c	2006-08-24 17:21:35.000000000 +1000
@@ -1644,15 +1644,16 @@ static sector_t sync_request(mddev_t *md
 		return 0;
 	}
 
-	/* before building a request, check if we can skip these blocks..
-	 * This call the bitmap_start_sync doesn't actually record anything
-	 */
 	if (mddev->bitmap == NULL &&
 	    mddev->recovery_cp == MaxSector &&
+	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    conf->fullsync == 0) {
 		*skipped = 1;
 		return max_sector - sector_nr;
 	}
+	/* before building a request, check if we can skip these blocks..
+	 * This call the bitmap_start_sync doesn't actually record anything
+	 */
 	if (!bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
 	    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
 		/* We can skip this block, and probably several more */
