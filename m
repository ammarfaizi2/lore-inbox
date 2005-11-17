Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVKQOAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKQOAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKQOAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:00:10 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:47805 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750829AbVKQOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:00:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-mm@kvack.org
Subject: [PATCH] mm: is_dma_zone
Date: Fri, 18 Nov 2005 00:59:50 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1912
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200511180059.51211.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple is_dma helper function to remain consistent with respect to
avoiding the use of ZONE_* outside the headers.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/mmzone.h |    5 +++++
 mm/swap_prefetch.c     |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

---

Index: linux-2.6.14-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/mmzone.h
+++ linux-2.6.14-mm2/include/linux/mmzone.h
@@ -425,6 +425,11 @@ static inline int is_normal(struct zone 
 	return zone == zone->zone_pgdat->node_zones + ZONE_NORMAL;
 }
 
+static inline int is_dma(struct zone *zone)
+{
+	return zone == zone->zone_pgdat->node_zones + ZONE_DMA;
+}
+
 /* These two functions are used to setup the per zone pages min values */
 struct ctl_table;
 struct file;
Index: linux-2.6.14-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/swap_prefetch.c
+++ linux-2.6.14-mm2/mm/swap_prefetch.c
@@ -180,7 +180,7 @@ static struct page *prefetch_get_page(vo
 			continue;
 
 		/* We don't prefetch into DMA */
-		if (zone_idx(z) == ZONE_DMA)
+		if (is_dma(z))
 			continue;
 
 		free = z->free_pages;
