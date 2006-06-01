Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWFAFNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWFAFNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWFAFNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:13:49 -0400
Received: from mx1.suse.de ([195.135.220.2]:20695 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751475AbWFAFNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:13:47 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:37 +1000
Message-Id: <1060601051337.27577@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 10] md: Fix bug that stops raid5 resync from happening
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As data_disks is *less* than raid_disks, the current test here is
obviously wrong.  And as the difference is already available in
conf->max_degraded, it makes much more sense to use that.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-06-01 15:03:29.000000000 +1000
+++ ./drivers/md/raid5.c	2006-06-01 15:05:28.000000000 +1000
@@ -2858,7 +2858,7 @@ static inline sector_t sync_request(mdde
 	 * to resync, then assert that we are finished, because there is
 	 * nothing we can do.
 	 */
-	if (mddev->degraded >= (data_disks - raid_disks) &&
+	if (mddev->degraded >= conf->max_degraded &&
 	    test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
 		sector_t rv = (mddev->size << 1) - sector_nr;
 		*skipped = 1;
