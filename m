Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWFLVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWFLVNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFLVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:13:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42671 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751620AbWFLVNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:14 -0400
Date: Mon, 12 Jun 2006 14:13:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211305.20862.34292.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 04/21] swap_prefetch: Convert nr_mapped to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_prefetch: nr_mapped conversion

This is separate on request by Andrew.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-10 22:04:26.763047220 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-12 11:29:47.664697453 -0700
@@ -394,7 +394,8 @@ static int prefetch_suitable(void)
 		 * even if the slab is being allocated on a remote node. This
 		 * would be expensive to fix and not of great significance.
 		 */
-		limit = ps.nr_mapped + ps.nr_slab + ps.nr_dirty +
+		limit = node_page_state(node, NR_MAPPED) +
+			ps.nr_slab + ps.nr_dirty +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
 			node_clear(node, sp_stat.prefetch_nodes);
