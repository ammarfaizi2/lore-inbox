Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWJWHIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWJWHIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWJWHIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:08:18 -0400
Received: from ns.suse.de ([195.135.220.2]:59018 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751645AbWJWHIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:08:07 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 23 Oct 2006 17:08:01 +1000
Message-Id: <1061023070801.29256@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 4] md: Fix up maintenance of ->degraded in multipath.
References: <20061023170347.29132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A recent fix which made sure ->degraded was initialised properly
exposed a second bug - ->degraded wasn't been updated when drives
failed or were hot-added.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/multipath.c |    2 ++
 1 file changed, 2 insertions(+)

diff .prev/drivers/md/multipath.c ./drivers/md/multipath.c
--- .prev/drivers/md/multipath.c	2006-10-23 16:34:54.000000000 +1000
+++ ./drivers/md/multipath.c	2006-10-23 16:35:38.000000000 +1000
@@ -277,6 +277,7 @@ static void multipath_error (mddev_t *md
 			set_bit(Faulty, &rdev->flags);
 			set_bit(MD_CHANGE_DEVS, &mddev->flags);
 			conf->working_disks--;
+			mddev->degraded++;
 			printk(KERN_ALERT "multipath: IO failure on %s,"
 				" disabling IO path. \n	Operation continuing"
 				" on %d IO paths.\n",
@@ -336,6 +337,7 @@ static int multipath_add_disk(mddev_t *m
 				blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 			conf->working_disks++;
+			mddev->degraded--;
 			rdev->raid_disk = path;
 			set_bit(In_sync, &rdev->flags);
 			rcu_assign_pointer(p->rdev, rdev);
