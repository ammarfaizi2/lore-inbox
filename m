Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVDLSSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVDLSSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVDLKbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:31:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:54983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262106AbVDLKa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:30:56 -0400
Message-Id: <200504121030.j3CAUeUO005113@shell0.pdx.osdl.net>
Subject: [patch 002/198] Avoid deadlock in sync_page_io by using GFP_NOIO
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@cse.unsw.edu.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Neil Brown <neilb@cse.unsw.edu.au>

..as sync_page_io can be called on the write-out path.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/md/md.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/md/md.c~avoid-deadlock-in-sync_page_io-by-using-gfp_noio drivers/md/md.c
--- 25/drivers/md/md.c~avoid-deadlock-in-sync_page_io-by-using-gfp_noio	2005-04-12 03:21:04.115511248 -0700
+++ 25-akpm/drivers/md/md.c	2005-04-12 03:21:04.121510336 -0700
@@ -332,7 +332,7 @@ static int bi_complete(struct bio *bio, 
 static int sync_page_io(struct block_device *bdev, sector_t sector, int size,
 		   struct page *page, int rw)
 {
-	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
+	struct bio *bio = bio_alloc(GFP_NOIO, 1);
 	struct completion event;
 	int ret;
 
_
