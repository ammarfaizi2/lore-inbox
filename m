Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269639AbRHQEXD>; Fri, 17 Aug 2001 00:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRHQEWx>; Fri, 17 Aug 2001 00:22:53 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:23566 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S269639AbRHQEWj>; Fri, 17 Aug 2001 00:22:39 -0400
Date: Fri, 17 Aug 2001 12:23:37 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: <tpepper@vato.org>, f5ibh <f5ibh@db0bm.ampr.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9 does not compile [better PATCH]
In-Reply-To: <5.1.0.14.2.20010816232513.0461bae0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0108171221210.9276-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lvm does not compile either.

Here's the complete patch for 2.4.9

Jeff

--- linux/drivers/md/lvm.c.org	Fri Aug 17 12:07:35 2001
+++ linux/drivers/md/lvm.c	Fri Aug 17 12:09:05 2001
@@ -2326,7 +2326,7 @@

 	/* save availiable i/o statistic data */
 	if (old_lv->lv_stripes < 2) {	/* linear logical volume */
-		end = min(old_lv->lv_current_le, new_lv->lv_current_le);
+		end = min(__u32, old_lv->lv_current_le, new_lv->lv_current_le);
 		for (l = 0; l < end; l++) {
 			new_lv->lv_current_pe[l].reads +=
 				old_lv->lv_current_pe[l].reads;
@@ -2340,7 +2340,7 @@

 		old_stripe_size = old_lv->lv_allocated_le / old_lv->lv_stripes;
 		new_stripe_size = new_lv->lv_allocated_le / new_lv->lv_stripes;
-		end = min(old_stripe_size, new_stripe_size);
+		end = min(__u32, old_stripe_size, new_stripe_size);

 		for (i = source = dest = 0; i < new_lv->lv_stripes; i++) {
 			for (j = 0; j < end; j++) {
--- linux/drivers/md/lvm-snap.c.org	Fri Aug 17 12:09:35 2001
+++ linux/drivers/md/lvm-snap.c	Fri Aug 17 12:10:30 2001
@@ -360,8 +360,8 @@

 	blksize_org = lvm_get_blksize(org_phys_dev);
 	blksize_snap = lvm_get_blksize(snap_phys_dev);
-	max_blksize = max(blksize_org, blksize_snap);
-	min_blksize = min(blksize_org, blksize_snap);
+	max_blksize = max(__u32, blksize_org, blksize_snap);
+	min_blksize = min(__u32, blksize_org, blksize_snap);
 	max_sectors = KIO_MAX_SECTORS * (min_blksize>>9);

 	if (chunk_size % (max_blksize>>9))
@@ -369,7 +369,7 @@

 	while (chunk_size)
 	{
-		nr_sectors = min(chunk_size, max_sectors);
+		nr_sectors = min(__u32, chunk_size, max_sectors);
 		chunk_size -= nr_sectors;

 		iobuf->length = nr_sectors << 9;
@@ -486,7 +486,7 @@

 	buckets = lv->lv_remap_end;
 	max_buckets = calc_max_buckets();
-	buckets = min(buckets, max_buckets);
+	buckets = min(__u32, buckets, max_buckets);
 	while (buckets & (buckets-1))
 		buckets &= (buckets-1);

--- linux/fs/ntfs/unistr.c.org	Fri Aug 17 12:18:13 2001
+++ linux/fs/ntfs/unistr.c	Fri Aug 17 12:18:25 2001
@@ -23,6 +23,7 @@

 #include <linux/string.h>
 #include <asm/byteorder.h>
+#include <linux/kernel.h>

 #include "unistr.h"
 #include "macros.h"
@@ -96,7 +97,7 @@
 	__u32 cnt;
 	wchar_t c1, c2;

-	for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
+	for (cnt = 0; cnt < min(__u32, name1_len, name2_len); ++cnt)
 	{
 		c1 = le16_to_cpu(*name1++);
 		c2 = le16_to_cpu(*name2++);

