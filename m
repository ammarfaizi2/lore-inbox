Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWEPBNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWEPBNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWEPBNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:13:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:52885 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750939AbWEPBNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:13:24 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 May 2006 11:13:07 +1000
Message-Id: <1060516011307.2723@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 3] md: Fix inverted test for 'repair' directive.
References: <20060516111036.2649.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We should be able to write 'repair' to /sys/block/mdX/md/sync_action,
however due to and inverted test, that always given EINVAL.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-16 11:09:25.000000000 +1000
+++ ./drivers/md/md.c	2006-05-16 11:09:41.000000000 +1000
@@ -2318,7 +2318,7 @@ action_store(mddev_t *mddev, const char 
 	} else {
 		if (cmd_match(page, "check"))
 			set_bit(MD_RECOVERY_CHECK, &mddev->recovery);
-		else if (cmd_match(page, "repair"))
+		else if (!cmd_match(page, "repair"))
 			return -EINVAL;
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
