Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753546AbWKGWJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbWKGWJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWKGWJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:09:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37833 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753491AbWKGWJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:09:27 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:09:31 +1100
Message-Id: <1061107220931.12489@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 9] md: Fix sizing problem with raid5-reshape and CONFIG_LBD=n
References: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I forgot to has the size-in-blocks to (loff_t) before shifting up to a size-in-bytes.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-06 11:21:24.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-06 11:28:51.000000000 +1100
@@ -3659,7 +3659,7 @@ static void end_reshape(raid5_conf_t *co
 		bdev = bdget_disk(conf->mddev->gendisk, 0);
 		if (bdev) {
 			mutex_lock(&bdev->bd_inode->i_mutex);
-			i_size_write(bdev->bd_inode, conf->mddev->array_size << 10);
+			i_size_write(bdev->bd_inode, (loff_t)conf->mddev->array_size << 10);
 			mutex_unlock(&bdev->bd_inode->i_mutex);
 			bdput(bdev);
 		}
