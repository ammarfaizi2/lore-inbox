Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSFOTYQ>; Sat, 15 Jun 2002 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315471AbSFOTYP>; Sat, 15 Jun 2002 15:24:15 -0400
Received: from holomorphy.com ([66.224.33.161]:7595 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314584AbSFOTYP>;
	Sat, 15 Jun 2002 15:24:15 -0400
Date: Sat, 15 Jun 2002 12:23:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: beautify nr_free_pages()
Message-ID: <20020615192357.GR25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nr_free_pages() is overly verbose. The following is perhaps clearer and
gets to the point with fewer lines of code and inside of 80 columns.

Against 2.5.21


Cheers,
Bill



===== mm/page_alloc.c 1.67 vs edited =====
--- 1.67/mm/page_alloc.c	Mon Jun  3 08:25:10 2002
+++ edited/mm/page_alloc.c	Sat Jun 15 12:10:41 2002
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
 
