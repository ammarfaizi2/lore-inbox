Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSFBWPz>; Sun, 2 Jun 2002 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSFBWPy>; Sun, 2 Jun 2002 18:15:54 -0400
Received: from holomorphy.com ([66.224.33.161]:32162 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316883AbSFBWPx>;
	Sun, 2 Jun 2002 18:15:53 -0400
Date: Sun, 2 Jun 2002 15:15:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: convert BAD_RANGE() to an inline function
Message-ID: <20020602221530.GM14918@holomorphy.com>
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

BAD_RANGE() is too complex to merit being a macro definition. The
following patch converts it to an inline function.

Against 2.5.19.


Cheers,
Bill


===== mm/page_alloc.c 1.67 vs edited =====
--- 1.67/mm/page_alloc.c	Sun Jun  2 15:10:36 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 15:13:24 2002
@@ -46,12 +46,16 @@
 /*
  * Temporary debugging check.
  */
-#define BAD_RANGE(zone, page)						\
-(									\
-	(((page) - mem_map) >= ((zone)->zone_start_mapnr+(zone)->size))	\
-	|| (((page) - mem_map) < (zone)->zone_start_mapnr)		\
-	|| ((zone) != page_zone(page))					\
-)
+static inline int BAD_RANGE(zone_t *zone, struct page *page)
+{
+	if (page - mem_map >= zone->zone_start_mapnr + zone->size)
+		return 1;
+	if (page - mem_map < zone->zone_start_mapnr)
+		return 1;
+	if (zone != page_zone(page))
+		return 1;
+	return 0;
+}
 
 /*
  * Freeing function for a buddy system allocator.
