Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753521AbWKGWJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbWKGWJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbWKGWJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:09:27 -0500
Received: from ns.suse.de ([195.135.220.2]:11656 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753492AbWKGWJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:09:22 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:09:26 +1100
Message-Id: <1061107220926.12477@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH 001 of 9] md: Change ONLINE/OFFLINE events to a single CHANGE event
References: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It turns out that CHANGE is preferred to ONLINE/OFFLINE for various reasons
(not least of which being that udev understands it already).

So remove the recently added KOBJ_OFFLINE (no-one is likely to care
anyway) and change the ONLINE to a CHANGE event

Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-11-06 11:21:25.000000000 +1100
+++ ./drivers/md/md.c	2006-11-06 11:22:14.000000000 +1100
@@ -3200,7 +3200,7 @@ static int do_md_run(mddev_t * mddev)
 
 	mddev->changed = 1;
 	md_new_event(mddev);
-	kobject_uevent(&mddev->gendisk->kobj, KOBJ_ONLINE);
+	kobject_uevent(&mddev->gendisk->kobj, KOBJ_CHANGE);
 	return 0;
 }
 
@@ -3314,7 +3314,6 @@ static int do_md_stop(mddev_t * mddev, i
 
 			module_put(mddev->pers->owner);
 			mddev->pers = NULL;
-			kobject_uevent(&mddev->gendisk->kobj, KOBJ_OFFLINE);
 			if (mddev->ro)
 				mddev->ro = 0;
 		}
