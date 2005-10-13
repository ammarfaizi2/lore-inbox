Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVJMTBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVJMTBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVJMTBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:01:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60841 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932157AbVJMTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:01:52 -0400
Date: Thu, 13 Oct 2005 12:01:50 -0700 (PDT)
From: hawkes@sgi.com
To: linux-kernel@vger.kernel.org
Cc: hawkes@sgi.com
Message-Id: <20051013190150.13195.77414.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] 2.6.14-rc4: wider use of for_each_*cpu() in mm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 'mm' change the explicit use of a for-loop using NR_CPUS into the
general for_each_cpu() constructs.  This widens the scope of potential
future optimizations of the general constructs, as well as takes
advantage of the existing optimizations of first_cpu() and next_cpu(),
which is advantageous when the true CPU count is much smaller than NR_CPUS.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c	2005-10-13 09:29:53.000000000 -0700
+++ linux/mm/page_alloc.c	2005-10-13 09:30:36.000000000 -0700
@@ -1305,12 +1305,9 @@
 		} else
 			printk("\n");
 
-		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+		for_each_cpu(cpu) {
 			struct per_cpu_pageset *pageset;
 
-			if (!cpu_possible(cpu))
-				continue;
-
 			pageset = zone_pcp(zone, cpu);
 
 			for (temperature = 0; temperature < 2; temperature++)
