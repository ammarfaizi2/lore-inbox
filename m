Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSFBV7H>; Sun, 2 Jun 2002 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSFBV7G>; Sun, 2 Jun 2002 17:59:06 -0400
Received: from holomorphy.com ([66.224.33.161]:26530 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315424AbSFBV7F>;
	Sun, 2 Jun 2002 17:59:05 -0400
Date: Sun, 2 Jun 2002 14:58:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: correct inaccurate comment regarding zone_table's usage
Message-ID: <20020602215843.GJ14918@holomorphy.com>
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

The comment describing the usage of zone_table[] assumes the existence
of an unsigned char page->zone field from the original implementation
of page->zone size reduction. This patch corrects the comment to
accurately describe the lookup mechanism used by page_zone() and also
to mention explicitly the sole user of the table, page_zone().

Against 2.5.19.

Cheers,
Bill


===== mm/page_alloc.c 1.64 vs edited =====
--- 1.64/mm/page_alloc.c	Sun Jun  2 14:51:50 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 14:55:49 2002
@@ -31,7 +31,10 @@
 LIST_HEAD(inactive_list);
 pg_data_t *pgdat_list;
 
-/* Used to look up the address of the struct zone encoded in page->zone */
+/*
+ * Used by page_zone() to look up the address of the struct zone whose
+ * id is encoded in the upper bits of page->flags
+ */
 zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
 EXPORT_SYMBOL(zone_table);
 
