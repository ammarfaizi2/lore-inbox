Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWD1CuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWD1CuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWD1CuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:50:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:59010 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965179AbWD1CuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:50:20 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:50:15 +1000
Message-Id: <1060428025015.30731@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: [PATCH 001 of 5] md: Avoid oops when attempting to fix read errors on raid10
References: <20060428124313.29510.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We should add to the counter for the rdev *after* checking
if the rdev is NULL !!!

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-04-28 12:13:20.000000000 +1000
+++ ./drivers/md/raid10.c	2006-04-28 12:13:20.000000000 +1000
@@ -1435,9 +1435,9 @@ static void raid10d(mddev_t *mddev)
 						sl--;
 						d = r10_bio->devs[sl].devnum;
 						rdev = conf->mirrors[d].rdev;
-						atomic_add(s, &rdev->corrected_errors);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
+							atomic_add(s, &rdev->corrected_errors);
 							if (sync_page_io(rdev->bdev,
 									 r10_bio->devs[sl].addr +
 									 sect + rdev->data_offset,
