Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWEERgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWEERgC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWEERgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:36:00 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:46468 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751679AbWEERfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:35:47 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173546.9030.8449.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 3/8] x86 - Specify amount of kernel memory at boot time
Date: Fri,  5 May 2006 18:35:46 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the kernelcore= parameter for x86.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-102_addzone/arch/i386/kernel/setup.c linux-2.6.17-rc3-mm1-zonesizing-103_x86coremem/arch/i386/kernel/setup.c
--- linux-2.6.17-rc3-mm1-zonesizing-102_addzone/arch/i386/kernel/setup.c	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-103_x86coremem/arch/i386/kernel/setup.c	2006-05-03 09:47:22.000000000 +0100
@@ -943,6 +943,18 @@ static void __init parse_cmdline_early (
 		else if (!memcmp(from, "vmalloc=", 8))
 			__VMALLOC_RESERVE = memparse(from+8, &from);
 
+		/*
+		 * kernelcore=size sets the amount of memory for use for
+		 * kernel allocations that cannot be reclaimed easily.
+		 * The remaining memory is set aside for easy reclaim
+		 * for features like memory remove or huge page allocations
+		 */
+		else if (!memcmp(from, "kernelcore=",11)) {
+			unsigned long core_pages;
+			core_pages = memparse(from+11, &from) >> PAGE_SHIFT;
+			set_required_kernelcore(core_pages);
+		}
+
 	next_char:
 		c = *(from++);
 		if (!c)
