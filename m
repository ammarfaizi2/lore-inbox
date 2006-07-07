Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWGGXTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWGGXTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWGGXTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63695 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932381AbWGGXSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:18:39 -0400
Date: Fri, 7 Jul 2006 16:18:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060707231820.3790.21411.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 02/11] Remove two strange uses of MAX_NR_ZONES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix strange uses of MAX_NR_ZONES

Sometimes we use MAX_NR_ZONES - x to refer to a zone. Make that
explicit.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/x86_64/mm/init.c	2006-07-03 13:47:14.329487884 -0700
+++ linux-2.6.17-mm6/arch/x86_64/mm/init.c	2006-07-03 14:33:13.479261596 -0700
@@ -536,7 +536,7 @@ int memory_add_physaddr_to_nid(u64 start
 int arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
-	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
+	struct zone *zone = pgdat->node_zones + ZONE_NORMAL;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
Index: linux-2.6.17-mm6/arch/i386/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/mm/init.c	2006-07-03 13:47:12.740718955 -0700
+++ linux-2.6.17-mm6/arch/i386/mm/init.c	2006-07-03 14:33:13.481214600 -0700
@@ -657,7 +657,7 @@ void __init mem_init(void)
 int arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdata = &contig_page_data;
-	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
+	struct zone *zone = pgdata->node_zones + ZONE_HIGHMEM;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
