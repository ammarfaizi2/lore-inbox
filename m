Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266575AbUG0TOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUG0TOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUG0TOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:14:48 -0400
Received: from ozlabs.org ([203.10.76.45]:59108 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266575AbUG0TOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:14:04 -0400
Date: Tue, 27 Jul 2004 12:14:43 -0700
From: Martin Pool <mbp@sourcefrog.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] lost error code in rescan_partitions
Message-ID: <20040727191443.GA9564@happy.site>
Mail-Followup-To: Martin Pool <mbp@sourcefrog.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch to 2.6.8 fixes a path where an error from reloading the
partition table could be lost.

Index: linux-2.6/fs/partitions/check.c
===================================================================
--- linux-2.6.orig/fs/partitions/check.c	2004-06-18 15:16:27.000000000 -0700
+++ linux-2.6/fs/partitions/check.c	2004-07-27 12:09:54.437261728 -0700
@@ -407,7 +407,7 @@
 	if (disk->fops->revalidate_disk)
 		disk->fops->revalidate_disk(disk);
 	if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
-		return res;
+		return -EIO;
 	for (p = 1; p < state->limit; p++) {
 		sector_t size = state->parts[p].size;
 		sector_t from = state->parts[p].from;
@@ -420,7 +420,7 @@
 #endif
 	}
 	kfree(state);
-	return res;
+	return 0;
 }
 
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)


-- 
Martin
