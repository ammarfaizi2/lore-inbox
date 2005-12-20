Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVLTIz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVLTIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLTIzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:55:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63931 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750890AbVLTIzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:55:11 -0500
Date: Tue, 20 Dec 2005 17:53:31 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (mod_page_state info)[7/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220173120.1B16.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is add easy reclaim zone information for mod_page_state().

This is new patch at take 4.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


--
Index: zone_reclaim/include/linux/page-flags.h
===================================================================
--- zone_reclaim.orig/include/linux/page-flags.h	2005-12-15 19:48:30.000000000 +0900
+++ zone_reclaim/include/linux/page-flags.h	2005-12-15 21:01:09.000000000 +0900
@@ -109,7 +109,8 @@ struct page_state {
 	unsigned long pswpin;		/* swap reads */
 	unsigned long pswpout;		/* swap writes */
 
-	unsigned long pgalloc_high;	/* page allocations */
+	unsigned long pgalloc_easy_reclaim; /* page allocations */
+	unsigned long pgalloc_high;
 	unsigned long pgalloc_normal;
 	unsigned long pgalloc_dma32;
 	unsigned long pgalloc_dma;
@@ -121,22 +122,26 @@ struct page_state {
 	unsigned long pgfault;		/* faults (major+minor) */
 	unsigned long pgmajfault;	/* faults (major only) */
 
-	unsigned long pgrefill_high;	/* inspected in refill_inactive_zone */
+	unsigned long pgrefill_easy_reclaim;/* inspected in refill_inactive_zone */
+	unsigned long pgrefill_high;
 	unsigned long pgrefill_normal;
 	unsigned long pgrefill_dma32;
 	unsigned long pgrefill_dma;
 
-	unsigned long pgsteal_high;	/* total highmem pages reclaimed */
+	unsigned long pgsteal_easy_reclaim; /* total pages reclaimed */
+	unsigned long pgsteal_high;
 	unsigned long pgsteal_normal;
 	unsigned long pgsteal_dma32;
 	unsigned long pgsteal_dma;
 
-	unsigned long pgscan_kswapd_high;/* total highmem pages scanned */
+	unsigned long pgscan_kswapd_easy_reclaim; /* total pages scanned */
+	unsigned long pgscan_kswapd_high;
 	unsigned long pgscan_kswapd_normal;
 	unsigned long pgscan_kswapd_dma32;
 	unsigned long pgscan_kswapd_dma;
 
-	unsigned long pgscan_direct_high;/* total highmem pages scanned */
+	unsigned long pgscan_direct_easy_reclaim;/* total pages scanned */
+	unsigned long pgscan_direct_high;
 	unsigned long pgscan_direct_normal;
 	unsigned long pgscan_direct_dma32;
 	unsigned long pgscan_direct_dma;
@@ -183,7 +188,9 @@ extern void __mod_page_state_offset(unsi
 #define state_zone_offset(zone, member)					\
 ({									\
 	unsigned offset;						\
-	if (is_highmem(zone))						\
+	if (is_easy_reclaim(zone))					\
+		offset = offsetof(struct page_state, member##_easy_reclaim);\
+	else if (is_highmem(zone))					\
 		offset = offsetof(struct page_state, member##_high);	\
 	else if (is_normal(zone))					\
 		offset = offsetof(struct page_state, member##_normal);	\

-- 
Yasunori Goto 


