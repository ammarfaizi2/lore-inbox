Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSFTT6h>; Thu, 20 Jun 2002 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSFTT6g>; Thu, 20 Jun 2002 15:58:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:20966 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315438AbSFTT6f>; Thu, 20 Jun 2002 15:58:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] beautify nr_free_pages()
Date: Fri, 21 Jun 2002 06:02:46 +1000
Message-Id: <E17L88l-000369-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: (via Rusty) William Lee Irwin III <wli@holomorphy.com>
  nr_free_pages() is overly verbose. The following is perhaps clearer and
  gets to the point with fewer lines of code and inside of 80 columns.
  
  Against 2.5.21
  
  
  Cheers,
  Bill
  
  
  
  ===== mm/page_alloc.c 1.67 vs edited =====

--- trivial-2.5.23/mm/page_alloc.c.orig	Fri Jun 21 05:33:30 2002
+++ trivial-2.5.23/mm/page_alloc.c	Fri Jun 21 05:33:30 2002
@@ -495,16 +495,13 @@
  */
 unsigned int nr_free_pages(void)
 {
-	unsigned int sum;
-	zone_t *zone;
-	pg_data_t *pgdat = pgdat_list;
+	unsigned int i, sum = 0;
+	pg_data_t *pgdat;
+
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+		for (i = 0; i < MAX_NR_ZONES; ++i)
+			sum += pgdat->node_zones[i].free_pages;
 
-	sum = 0;
-	while (pgdat) {
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
-			sum += zone->free_pages;
-		pgdat = pgdat->node_next;
-	}
 	return sum;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
