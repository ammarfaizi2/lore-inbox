Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUKCRDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUKCRDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbUKCRDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:03:24 -0500
Received: from fmr12.intel.com ([134.134.136.15]:52424 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261729AbUKCRDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:03:20 -0500
Date: Wed, 3 Nov 2004 09:24:21 -0800
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200411031724.iA3HOLl0017096@snoqualmie.dp.intel.com>
To: arjan@infradead.org, metolent@snoqualmie.dp.intel.com
Subject: Re: [patch] remove direct mem_map refs for x86-64
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From SRS0+fff01e338c482ba0c24b+437+infradead.org+arjan@canuck.srs.infradead.org  Wed Nov  3 08:54:21 2004
>On Wed, 2004-11-03 at 08:47 -0800, Matt Tolentino wrote:
>> -                       page = pgdat->node_mem_map + i;
>> -		total++;
>> +			page = pfn_to_page(pgdat->node_start_pfn + i);
>> +			total++;
>
>this can't be correct... pfn_to_page starts to count from address 0
>while the original code starts from the start of the node..

Yep, you're right.  I've been thinking about single nodes too much
lately.

matt


diff -urN linux-2.6.10-rc1-mm2-vanilla/arch/x86_64/mm/init.c linux-2.6.10-rc1-mm2/arch/x86_64/mm/init.c
--- linux-2.6.10-rc1-mm2-vanilla/arch/x86_64/mm/init.c	2004-11-03 06:50:01.939974040 -0500
+++ linux-2.6.10-rc1-mm2/arch/x86_64/mm/init.c	2004-11-03 07:26:15.922478464 -0500
@@ -466,7 +466,7 @@
 		/*
 		 * Only count reserved RAM pages
 		 */
-		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
+		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
 			reservedpages++;
 #endif
 
