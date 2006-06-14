Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWFNBJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWFNBJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWFNBIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:08:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13541 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964854AbWFNBEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:00 -0400
Date: Tue, 13 Jun 2006 18:03:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010350.859.70164.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
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
