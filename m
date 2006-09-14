Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWINRh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWINRh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWINRh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:37:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750829AbWINRhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:37:25 -0400
Date: Thu, 14 Sep 2006 10:37:05 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: mel@csn.ul.ie, akpm@osdl.org
Subject: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
Message-ID: <20060914173705.GC19807@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For ppc in our cross-compile build farm (PLM), there is an error 
compiling file ppc/mm/init.c:  

  CC      arch/ppc/mm/init.o
  CC      arch/powerpc/kernel/init_task.o
arch/ppc/mm/init.c: In function 'paging_init':
arch/ppc/mm/init.c:381: error: subscripted value is neither array nor pointer
arch/ppc/mm/init.c:383: warning: passing argument 1 of '/' makes pointer from integer without a cast
make[1]: [arch/ppc/mm/init.o] Error 1 (ignored)


This is caused by an error/oversight in file 
'have-power-use-add_active_range-and-free_area_init_nodes.patch'

Here is a patch to fix that patch.

Thanks;
Judith Lebzelter
OSDL


--- arch/ppc/mm/init.c.old	2006-09-14 09:40:51.964543641 -0700
+++ arch/ppc/mm/init.c	2006-09-14 10:04:46.814015750 -0700
@@ -359,7 +359,7 @@
 void __init paging_init(void)
 {
 	unsigned long start_pfn, end_pfn;
-	unsigned long max_zone_pfns;
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
 #ifdef CONFIG_HIGHMEM
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = pte_offset_kernel(pmd_offset(pgd_offset_k
