Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUFNSR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUFNSR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUFNSR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:17:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10459 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263741AbUFNSPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:15:53 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 5/5: dm-raid1.c: Use list_for_each_entry_safe
Date: Mon, 14 Jun 2004 13:19:00 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406141309.31127.kevcorry@us.ibm.com>
In-Reply-To: <200406141309.31127.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141319.00716.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-raid1.c: In rh_exit(), use list_for_each_entry_safe instead of
list_for_each_safe.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-raid1.c	2004-06-14 09:30:12.916701520 +0000
+++ source/drivers/md/dm-raid1.c	2004-06-14 09:30:17.978931944 +0000
@@ -187,13 +187,11 @@
 static void rh_exit(struct region_hash *rh)
 {
 	unsigned int h;
-	struct region *reg;
-	struct list_head *tmp, *tmp2;
+	struct region *reg, *nreg;
 
 	BUG_ON(!list_empty(&rh->quiesced_regions));
 	for (h = 0; h < rh->nr_buckets; h++) {
-		list_for_each_safe (tmp, tmp2, rh->buckets + h) {
-			reg = list_entry(tmp, struct region, hash_list);
+		list_for_each_entry_safe(reg, nreg, rh->buckets + h, hash_list) {
 			BUG_ON(atomic_read(&reg->pending));
 			mempool_free(reg, rh->region_pool);
 		}
