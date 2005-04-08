Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVDHA60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVDHA60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVDHAzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:55:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:15058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262642AbVDHAv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:51:56 -0400
Date: Thu, 7 Apr 2005 17:52:25 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 6/6] mm/bootmem.c: use generic round_up_pow2() macro
Message-ID: <20050408005225.GG4260@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408004428.GA4260@njw.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Wilson <njw@osdl.org>

Use the generic round_up_pow2() instead of a custom rounding method.

Signed-off-by: Nick Wilson <njw@osdl.org>
---


 bootmem.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/mm/bootmem.c
===================================================================
--- linux.orig/mm/bootmem.c	2005-04-07 15:13:56.000000000 -0700
+++ linux/mm/bootmem.c	2005-04-07 15:46:41.000000000 -0700
@@ -57,7 +57,7 @@ static unsigned long __init init_bootmem
 	pgdat->pgdat_next = pgdat_list;
 	pgdat_list = pgdat;
 
-	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
+	mapsize = round_up_pow2(mapsize, sizeof(long));
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
 	bdata->node_boot_start = (start << PAGE_SHIFT);
 	bdata->node_low_pfn = end;
@@ -178,7 +178,7 @@ __alloc_bootmem_core(struct bootmem_data
 	} else
 		preferred = 0;
 
-	preferred = ((preferred + align - 1) & ~(align - 1)) >> PAGE_SHIFT;
+	preferred = round_up_pow2(preferred, align) >> PAGE_SHIFT;
 	preferred += offset;
 	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
 	incr = align >> PAGE_SHIFT ? : 1;
@@ -219,7 +219,7 @@ found:
 	 */
 	if (align < PAGE_SIZE &&
 	    bdata->last_offset && bdata->last_pos+1 == start) {
-		offset = (bdata->last_offset+align-1) & ~(align-1);
+		offset = round_up_pow2(bdata->last_offset, align);
 		BUG_ON(offset > PAGE_SIZE);
 		remaining_size = PAGE_SIZE-offset;
 		if (size < remaining_size) {
_
