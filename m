Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWFLVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWFLVSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWFLVSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:18:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61615 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932302AbWFLVOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:08 -0400
Date: Mon, 12 Jun 2006 14:13:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211357.20862.99520.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 14/21] swap_prefetch: Conversion of nr_dirty to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_prefetch: Convert nr_dirty to zone count

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-12 12:55:29.984174144 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-12 12:55:33.862840200 -0700
@@ -393,7 +393,7 @@ static int prefetch_suitable(void)
 		limit = node_page_state(node, NR_MAPPED) +
 			node_page_state(node, NR_ANON) +
 			node_page_state(node, NR_SLAB) +
-			ps.nr_dirty +
+			node_page_state(node, NR_DIRTY) +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
