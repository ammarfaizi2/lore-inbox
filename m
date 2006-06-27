Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030711AbWF0HJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711AbWF0HJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030732AbWF0HI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:08:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:61603 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030684AbWF0HFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:42 +1000
Message-Id: <1060627070542.26034@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 12] md: Fix usage of wrong variable in raid1
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Though it rarely matters, we should be using 's' rather than
r1_bio->sector here.

### Diffstat output
 ./drivers/md/raid1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-06-27 12:15:16.000000000 +1000
+++ ./drivers/md/raid1.c	2006-06-27 12:17:33.000000000 +1000
@@ -1145,7 +1145,7 @@ static int end_sync_write(struct bio *bi
 		long sectors_to_go = r1_bio->sectors;
 		/* make sure these bits doesn't get cleared. */
 		do {
-			bitmap_end_sync(mddev->bitmap, r1_bio->sector,
+			bitmap_end_sync(mddev->bitmap, s,
 					&sync_blocks, 1);
 			s += sync_blocks;
 			sectors_to_go -= sync_blocks;
