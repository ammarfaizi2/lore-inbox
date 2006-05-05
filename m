Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWEERhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWEERhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWEERhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:37:20 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:3717 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751687AbWEERgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:36:48 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173647.9030.50529.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 6/8] ia64 - Specify amount of kernel memory at boot time
Date: Fri,  5 May 2006 18:36:47 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the kernelcore= parameter for ia64.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-105_x8664coremem/arch/ia64/kernel/efi.c linux-2.6.17-rc3-mm1-zonesizing-106_ia64coremem/arch/ia64/kernel/efi.c
--- linux-2.6.17-rc3-mm1-zonesizing-105_x8664coremem/arch/ia64/kernel/efi.c	2006-05-03 09:41:30.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-106_ia64coremem/arch/ia64/kernel/efi.c	2006-05-04 13:53:14.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/efi.h>
+#include <linux/mm.h>
 
 #include <asm/io.h>
 #include <asm/kregs.h>
@@ -420,6 +421,10 @@ efi_init (void)
 			mem_limit = memparse(cp + 4, &cp);
 		} else if (memcmp(cp, "max_addr=", 9) == 0) {
 			max_addr = GRANULEROUNDDOWN(memparse(cp + 9, &cp));
+		} else if (memcmp(cp, "kernelcore=",11) == 0) {
+			unsigned long core_pages;
+			core_pages = memparse(cp+11, &cp) >> PAGE_SHIFT;
+			set_required_kernelcore(core_pages);
 		} else {
 			while (*cp != ' ' && *cp)
 				++cp;
