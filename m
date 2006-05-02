Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWEBMSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWEBMSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 08:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWEBMSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 08:18:46 -0400
Received: from everest.sosdg.org ([66.93.203.161]:34022 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S964775AbWEBMSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 08:18:45 -0400
Date: Tue, 2 May 2006 08:18:43 -0400
From: Coywolf Qi Hunt <qiyong@freeforge.net>
To: akpm@osdl.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de
Subject: [patch] stripe_to_pdidx() cleanup
Message-ID: <20060502121843.GA24153@everest.sosdg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Cleanup: Remove unnecessary variable x in stripe_to_pdidx().

Signed-off-by: Coywolf Qi Hunt <qiyong@freeforge.net>
---

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3184360..7df6840 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1033,13 +1033,12 @@ static void end_reshape(raid5_conf_t *co
 
 static int stripe_to_pdidx(sector_t stripe, raid5_conf_t *conf, int disks)
 {
-	int sectors_per_chunk = conf->chunk_size >> 9;
-	sector_t x = stripe;
 	int pd_idx, dd_idx;
-	int chunk_offset = sector_div(x, sectors_per_chunk);
-	stripe = x;
-	raid5_compute_sector(stripe*(disks-1)*sectors_per_chunk
-			     + chunk_offset, disks, disks-1, &dd_idx, &pd_idx, conf);
+	int sectors_per_chunk = conf->chunk_size >> 9;
+	int chunk_offset = sector_div(stripe, sectors_per_chunk);
+
+	raid5_compute_sector(stripe*(disks-1)*sectors_per_chunk + chunk_offset,
+				disks, disks-1, &dd_idx, &pd_idx, conf);
 	return pd_idx;
 }
 

-- 
Coywolf Qi Hunt
