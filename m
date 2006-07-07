Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWGGXUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWGGXUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWGGXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6096 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932383AbWGGXTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:19:18 -0400
Date: Fri, 7 Jul 2006 16:19:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060707231906.3790.47804.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 11/11] Fix i386 SRAT check for MAX_NR_ZONES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 SRAT: Fix MAX_NR_ZONES check

We cannot check MAX_NR_ZONES since it not defined in the preprocessor
anymore. So remove the check.

The maximum number of zones per node for i386 is 3 since i386 does
not support ZONE_DMA32.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/arch/i386/kernel/srat.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/kernel/srat.c	2006-07-03 13:47:12.667481297 -0700
+++ linux-2.6.17-mm6/arch/i386/kernel/srat.c	2006-07-04 07:59:13.710812064 -0700
@@ -42,7 +42,7 @@
 #define PXM_BITMAP_LEN (MAX_PXM_DOMAINS / 8) 
 static u8 pxm_bitmap[PXM_BITMAP_LEN];	/* bitmap of proximity domains */
 
-#define MAX_CHUNKS_PER_NODE	4
+#define MAX_CHUNKS_PER_NODE	3
 #define MAXCHUNKS		(MAX_CHUNKS_PER_NODE * MAX_NUMNODES)
 struct node_memory_chunk_s {
 	unsigned long	start_pfn;
@@ -135,9 +135,6 @@ static void __init parse_memory_affinity
 		 "enabled and removable" : "enabled" ) );
 }
 
-#if MAX_NR_ZONES != 4
-#error "MAX_NR_ZONES != 4, chunk_to_zone requires review"
-#endif
 /* Take a chunk of pages from page frame cstart to cend and count the number
  * of pages in each zone, returned via zones[].
  */
