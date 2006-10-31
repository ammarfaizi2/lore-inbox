Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWJaGAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWJaGAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161569AbWJaGAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:00:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:50342 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161568AbWJaGAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:00:52 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 31 Oct 2006 17:00:46 +1100
Message-Id: <1061031060046.5034@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@suse.de
Subject: [PATCH 001 of 6] md: Send online/offline uevents when an md array starts/stops.
References: <20061031164814.4884.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows udev to do something intelligent when an
array becomes available.

cc: gregkh@suse.de
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 ++
 1 file changed, 2 insertions(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-10-31 16:40:52.000000000 +1100
+++ ./drivers/md/md.c	2006-10-31 16:41:02.000000000 +1100
@@ -3200,6 +3200,7 @@ static int do_md_run(mddev_t * mddev)
 
 	mddev->changed = 1;
 	md_new_event(mddev);
+	kobject_uevent(&mddev->gendisk->kobj, KOBJ_ONLINE);
 	return 0;
 }
 
@@ -3313,6 +3314,7 @@ static int do_md_stop(mddev_t * mddev, i
 
 			module_put(mddev->pers->owner);
 			mddev->pers = NULL;
+			kobject_uevent(&mddev->gendisk->kobj, KOBJ_OFFLINE);
 			if (mddev->ro)
 				mddev->ro = 0;
 		}
