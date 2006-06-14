Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWFNBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWFNBEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWFNBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:04:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18149 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964855AbWFNBER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:17 -0400
Date: Tue, 13 Jun 2006 18:04:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010406.859.32283.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
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
