Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWFNBJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWFNBJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWFNBDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:03:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5605 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964843AbWFNBD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:03:27 -0400
Date: Tue, 13 Jun 2006 18:03:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010319.859.65813.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
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
