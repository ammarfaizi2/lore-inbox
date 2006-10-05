Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWJEHNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWJEHNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWJEHNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:13:32 -0400
Received: from ns1.suse.de ([195.135.220.2]:36994 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751166AbWJEHNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:13:31 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 5 Oct 2006 17:13:26 +1000
Message-Id: <1061005071326.6578@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md: Fix bug where new drives added to an md array sometimes don't sync properly.
References: <20061005171233.6542.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a nasty bug in md in 2.6.18 affecting at least raid1.
This fixes it (and has already been sent to stable@kernel.org).

### Comments for Changeset

This fixes a bug introduced in 2.6.18. 

If a drive is added to a raid1 using older tools (mdadm-1.x or
raidtools) then it will be included in the array without any resync
happening.

It has been submitted for 2.6.18.1.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    1 +
 1 file changed, 1 insertion(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-09-29 11:51:39.000000000 +1000
+++ ./drivers/md/md.c	2006-10-05 16:40:51.000000000 +1000
@@ -3849,6 +3849,7 @@ static int hot_add_disk(mddev_t * mddev,
 	}
 	clear_bit(In_sync, &rdev->flags);
 	rdev->desc_nr = -1;
+	rdev->saved_raid_disk = -1;
 	err = bind_rdev_to_array(rdev, mddev);
 	if (err)
 		goto abort_export;
