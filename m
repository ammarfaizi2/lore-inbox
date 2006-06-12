Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWFLVPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWFLVPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFLVPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:15:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38825 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932299AbWFLVOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:20 -0400
Date: Mon, 12 Jun 2006 14:14:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211412.20862.5280.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 17/21] swap_prefetch: Conversion of nr_writeback to ZVC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: swap_prefetch: conversion of nr_writeback to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_writeback to per zone counter

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-10 15:09:12.691768066 -0700
+++ linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-10 15:18:17.095560797 -0700
@@ -381,7 +381,7 @@ static int prefetch_suitable(void)
 		get_page_state_node(&ps, node);
 
 		/* We shouldn't prefetch when we are doing writeback */
-		if (ps.nr_writeback) {
+		if (node_page_state(node, NR_WRITEBACK)) {
 			node_clear(node, sp_stat.prefetch_nodes);
 			continue;
 		}
