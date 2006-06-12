Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWFLVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWFLVOS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFLVOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31401 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932282AbWFLVNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:42 -0400
Date: Mon, 12 Jun 2006 14:13:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211326.20862.28655.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 08/21] swap_prefetch: Split NR_ANON off NR_MAPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_prefetch: add NR_ANON

Separated out by request from Andrew.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-10 14:57:06.644921771 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-10 15:39:44.582122436 -0700
@@ -395,6 +395,7 @@ static int prefetch_suitable(void)
 		 * would be expensive to fix and not of great significance.
 		 */
 		limit = node_page_state(node, NR_MAPPED) +
+			node_page_state(node, NR_ANON) +
 			ps.nr_slab + ps.nr_dirty +
 			ps.nr_unstable + total_swapcache_pages;
 		if (limit > ns->prefetch_watermark) {
