Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVEDREX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVEDREX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVEDREX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:04:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43929 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261173AbVEDREI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:04:08 -0400
Date: Wed, 4 May 2005 18:03:59 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] device-mapper: [2/5] __unlock_fs void
Message-ID: <20050504170359.GO10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make __unlock_fs() void.

From: Christoph Hellwig <hch@lst.de>
--- diff/drivers/md/dm.c	2005-04-21 16:06:40.000000000 +0100
+++ source/drivers/md/dm.c	2005-04-21 16:07:21.000000000 +0100
@@ -1009,18 +1009,16 @@
 	return 0;
 }
 
-static int __unlock_fs(struct mapped_device *md)
+static void __unlock_fs(struct mapped_device *md)
 {
 	if (!test_and_clear_bit(DMF_FS_LOCKED, &md->flags))
-		return 0;
+		return;
 
 	thaw_bdev(md->frozen_bdev, md->frozen_sb);
 	bdput(md->frozen_bdev);
 
 	md->frozen_sb = NULL;
 	md->frozen_bdev = NULL;
-
-	return 0;
 }
 
 /*
