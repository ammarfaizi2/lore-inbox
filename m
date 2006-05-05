Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWEERgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWEERgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWEERgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:36:10 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:53892 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751685AbWEERgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:36:08 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173606.9030.49873.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 4/8] ppc64 - Specify amount of kernel memory at boot time
Date: Fri,  5 May 2006 18:36:07 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the kernelcore= parameter for ppc64.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-103_x86coremem/arch/powerpc/kernel/prom.c linux-2.6.17-rc3-mm1-zonesizing-104_ppc64coremem/arch/powerpc/kernel/prom.c
--- linux-2.6.17-rc3-mm1-zonesizing-103_x86coremem/arch/powerpc/kernel/prom.c	2006-05-03 09:41:31.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-104_ppc64coremem/arch/powerpc/kernel/prom.c	2006-05-03 09:48:06.000000000 +0100
@@ -1064,6 +1064,15 @@ static int __init early_init_dt_scan_cho
 		}
 	}
 
+	/* Check if ZONE_EASYRCLM should be populated */
+	if (strstr(cmd_line, "kernelcore=")) {
+		unsigned long core_pages;
+		char *opt = strstr(cmd_line, "kernelcore=");
+		opt += 11;
+		core_pages = memparse(opt, &opt) >> PAGE_SHIFT;
+		set_required_kernelcore(core_pages);
+	}
+
 	/* break now */
 	return 1;
 }
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-103_x86coremem/arch/ppc/mm/init.c linux-2.6.17-rc3-mm1-zonesizing-104_ppc64coremem/arch/ppc/mm/init.c
--- linux-2.6.17-rc3-mm1-zonesizing-103_x86coremem/arch/ppc/mm/init.c	2006-05-03 09:42:16.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-104_ppc64coremem/arch/ppc/mm/init.c	2006-05-03 09:48:06.000000000 +0100
@@ -213,6 +213,15 @@ void MMU_setup(void)
 		}
 		__max_memory = maxmem;
 	}
+
+	/* Check if ZONE_EASYRCLM should be populated */
+	if (strstr(cmd_line, "kernelcore=")) {
+		unsigned long core_pages;
+		char *opt = strstr(cmd_line, "kernelcore=");
+		opt += 11;
+		core_pages = memparse(opt, &opt) >> PAGE_SHIFT;
+		set_required_kernelcore(core_pages);
+	}
 }
 
 /*
