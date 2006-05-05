Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWEERgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWEERgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWEERgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:36:43 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:64900 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751678AbWEERg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:36:28 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173627.9030.70416.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 5/8] x86_64 - Specify amount of kernel memory at boot time
Date: Fri,  5 May 2006 18:36:27 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the kernelcore= parameter for x64_64.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-104_ppc64coremem/arch/x86_64/kernel/setup.c linux-2.6.17-rc3-mm1-zonesizing-105_x8664coremem/arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc3-mm1-zonesizing-104_ppc64coremem/arch/x86_64/kernel/setup.c	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-105_x8664coremem/arch/x86_64/kernel/setup.c	2006-05-03 09:48:56.000000000 +0100
@@ -372,6 +372,12 @@ static __init void parse_cmdline_early (
 		if (!memcmp(from, "mem=", 4))
 			parse_memopt(from+4, &from); 
 
+		if (!memcmp(from, "kernelcore=", 11)) {
+			unsigned long core_pages;
+			core_pages = memparse(from+11, &from) >> PAGE_SHIFT;
+			set_required_kernelcore(core_pages);
+		}
+
 		if (!memcmp(from, "memmap=", 7)) {
 			/* exactmap option is for used defined memory */
 			if (!memcmp(from+7, "exactmap", 8)) {
