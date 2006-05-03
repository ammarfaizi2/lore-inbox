Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWECVA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWECVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWECVA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:00:59 -0400
Received: from palrel10.hp.com ([156.153.255.245]:34227 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751162AbWECVA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:00:58 -0400
Date: Wed, 3 May 2006 16:00:55 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: aeb@cwi.nl
Subject: [PATCH] make kernel ignore bogus partitions
Message-ID: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/1
Sometimes partitions claim to be larger than the reported capacity of a
disk device. This patch makes the kernel ignore those partitions.

Signed-off-by: Mike Miller <mike.miller@hp.com>
Signed-off-by: Stephen Cameron <steve.cameron@hp.com>

Please consider this for inclusion.


 fs/partitions/check.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.14/fs/partitions/check.c~partition_vs_capacity	2006-01-06 09:32:14.000000000 -0600
+++ linux-2.6.14-root/fs/partitions/check.c	2006-01-06 11:24:50.000000000 -0600
@@ -382,6 +382,11 @@ int rescan_partitions(struct gendisk *di
 		sector_t from = state->parts[p].from;
 		if (!size)
 			continue;
+		if (from+size-1 > get_capacity(disk)) {
+			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
+				disk->disk_name, p);
+			continue;
+		}
 		add_partition(disk, p, from, size);
 #ifdef CONFIG_BLK_DEV_MD
 		if (state->parts[p].flags)

_

