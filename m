Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWFNBEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWFNBEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWFNBDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5576 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964838AbWFNBDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:42 -0400
Date: Tue, 13 Jun 2006 18:03:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010335.859.25587.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 11/21] swap_prefetch: Conversion of nr_slab to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_prefetch: Use NR_SLAB

This removes a potential problem for swap_prefetch. Use NR_SLAB
and remove the comment stating the problem.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-12 11:30:59.995187077 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-12 11:55:06.458392224 -0700
@@ -389,14 +389,11 @@ static int prefetch_suitable(void)
 		/*
 		 * >2/3 of the ram on this node is mapped, slab, swapcache or
 		 * dirty, we need to leave some free for pagecache.
-		 * Note that currently nr_slab is innacurate on numa because
-		 * nr_slab is incremented on the node doing the accounting
-		 * even if the slab is being allocated on a remote node. This
-		 * would be expensive to fix and not of great significance.
 		 */
 		limit = node_page_state(node, NR_MAPPED) +
 			node_page_state(node, NR_ANON) +
-			ps.nr_slab + ps.nr_dirty +
+			node_page_state(node, NR_SLAB) +
+			ps.nr_dirty +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
