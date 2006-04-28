Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWD1CwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWD1CwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWD1CwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:52:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52973 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965197AbWD1Cvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:51:49 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:51:44 +1000
Message-Id: <1060428025144.30770@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 5] md: Change ENOTSUPP to EOPNOTSUPP
References: <20060428124313.29510.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because that is what you get if a BIO_RW_BARRIER isn't supported !

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-04-28 12:17:27.000000000 +1000
+++ ./drivers/md/raid1.c	2006-04-28 12:17:27.000000000 +1000
@@ -315,7 +315,7 @@ static int raid1_end_write_request(struc
 		if (r1_bio->bios[mirror] == bio)
 			break;
 
-	if (error == -ENOTSUPP && test_bit(R1BIO_Barrier, &r1_bio->state)) {
+	if (error == -EOPNOTSUPP && test_bit(R1BIO_Barrier, &r1_bio->state)) {
 		set_bit(BarriersNotsupp, &conf->mirrors[mirror].rdev->flags);
 		set_bit(R1BIO_BarrierRetry, &r1_bio->state);
 		r1_bio->mddev->barriers_work = 0;
@@ -1404,7 +1404,7 @@ static void raid1d(mddev_t *mddev)
 			unplug = 1;
 		} else if (test_bit(R1BIO_BarrierRetry, &r1_bio->state)) {
 			/* some requests in the r1bio were BIO_RW_BARRIER
-			 * requests which failed with -ENOTSUPP.  Hohumm..
+			 * requests which failed with -EOPNOTSUPP.  Hohumm..
 			 * Better resubmit without the barrier.
 			 * We know which devices to resubmit for, because
 			 * all others have had their bios[] entry cleared.
