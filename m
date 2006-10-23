Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWJWHH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWJWHH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWJWHH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:07:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21707 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751643AbWJWHHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:07:54 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 23 Oct 2006 17:07:48 +1000
Message-Id: <1061023070748.29223@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@kernel.org
Subject: [PATCH 001 of 4] md: Fix bug where spares don't always get rebuilt properly when they become live.
References: <20061023170347.29132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If save_raid_disk is >= 0, then the device could be a device that is 
already in sync that is being re-added.  So we need to default this
value to -1.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    1 +
 1 file changed, 1 insertion(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-10-23 16:34:55.000000000 +1000
+++ ./drivers/md/md.c	2006-10-23 16:35:05.000000000 +1000
@@ -2003,6 +2003,7 @@ static mdk_rdev_t *md_import_device(dev_
 	kobject_init(&rdev->kobj);
 
 	rdev->desc_nr = -1;
+	rdev->saved_raid_disk = -1;
 	rdev->flags = 0;
 	rdev->data_offset = 0;
 	rdev->sb_events = 0;
