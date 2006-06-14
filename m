Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWFNBDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWFNBDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWFNBDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57031 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964838AbWFNBDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:08 -0400
Date: Tue, 13 Jun 2006 18:02:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010259.859.25586.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
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
