Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWEAFaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWEAFaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEAFao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:30:44 -0400
Received: from ns.suse.de ([195.135.220.2]:18602 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750897AbWEAFal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:41 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:36 +1000
Message-Id: <1060501053036.22973@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 11] md: Remove nuisance message at shutdown
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At shutdown, we switch all arrays to read-only, which creates
a message for every instantiated array, even those which aren't
actually active.

So remove the message for non-active arrays.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-01 15:10:18.000000000 +1000
+++ ./drivers/md/md.c	2006-05-01 15:10:18.000000000 +1000
@@ -2898,7 +2898,7 @@ static int do_md_stop(mddev_t * mddev, i
 		if (disk)
 			set_capacity(disk, 0);
 		mddev->changed = 1;
-	} else
+	} else if (mddev->pers)
 		printk(KERN_INFO "md: %s switched to read-only mode.\n",
 			mdname(mddev));
 	err = 0;
