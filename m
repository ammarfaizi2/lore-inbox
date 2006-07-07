Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWGGXSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWGGXSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWGGXSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:18:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:61391 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932380AbWGGXSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:18:36 -0400
Date: Fri, 7 Jul 2006 16:18:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060707231815.3790.4586.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 01/11] swap_prefetch: Remove incorrect use of ZONE_HIGHMEM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_prefetch: Remove useless reference to HIGHMEM reserves.

HIGHMEM "reserves" are always zero. Remove the addition of the highmem
reserves.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/swap_prefetch.c	2006-07-03 13:47:22.656121359 -0700
+++ linux-2.6.17-mm6/mm/swap_prefetch.c	2006-07-04 08:30:07.805828891 -0700
@@ -277,8 +277,7 @@ static void examine_free_limits(void)
 
 		ns = &sp_stat.node[z->zone_pgdat->node_id];
 		idx = zone_idx(z);
-		ns->lowfree[idx] = z->pages_high * 3 +
-			z->lowmem_reserve[ZONE_HIGHMEM];
+		ns->lowfree[idx] = z->pages_high * 3;
 		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
 
 		if (z->free_pages > ns->highfree[idx]) {
