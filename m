Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422867AbWBBC2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422867AbWBBC2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 21:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbWBBC2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 21:28:18 -0500
Received: from ozlabs.org ([203.10.76.45]:19368 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422867AbWBBC2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 21:28:18 -0500
Date: Thu, 2 Feb 2006 13:25:55 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix cpu hotplug
Message-ID: <20060202022555.GA11005@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

CPU hotplug was broken by the __meminit changes. Avoid the madness of
creating a mem+cpu hotplug init attribute and just make them __devinit.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/mm/page_alloc.c
===================================================================
--- build.orig/mm/page_alloc.c	2006-02-02 12:20:50.000000000 +1100
+++ build/mm/page_alloc.c	2006-02-02 13:14:56.000000000 +1100
@@ -1799,7 +1799,7 @@ void zonetable_add(struct zone *zone, in
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
-static int __meminit zone_batchsize(struct zone *zone)
+static int __devinit zone_batchsize(struct zone *zone)
 {
 	int batch;
 
@@ -1893,7 +1893,7 @@ static struct per_cpu_pageset
  * Dynamically allocate memory for the
  * per cpu pageset array in struct zone.
  */
-static int __meminit process_zones(int cpu)
+static int __devinit process_zones(int cpu)
 {
 	struct zone *zone, *dzone;
 
@@ -1934,7 +1934,7 @@ static inline void free_zone_pagesets(in
 	}
 }
 
-static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
+static int __devinit pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
 {
