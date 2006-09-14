Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWINSLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWINSLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWINSLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:11:34 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:38617 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750870AbWINSLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:11:34 -0400
Date: Thu, 14 Sep 2006 19:11:32 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
In-Reply-To: <20060914173705.GC19807@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Judith Lebzelter wrote:

> For ppc in our cross-compile build farm (PLM), there is an error
> compiling file ppc/mm/init.c:
>
>  CC      arch/ppc/mm/init.o
>  CC      arch/powerpc/kernel/init_task.o
> arch/ppc/mm/init.c: In function 'paging_init':
> arch/ppc/mm/init.c:381: error: subscripted value is neither array nor pointer
> arch/ppc/mm/init.c:383: warning: passing argument 1 of '/' makes pointer from integer without a cast
> make[1]: [arch/ppc/mm/init.o] Error 1 (ignored)
>
>
> This is caused by an error/oversight in file
> 'have-power-use-add_active_range-and-free_area_init_nodes.patch'
>
> Here is a patch to fix that patch.
>

Looks good. Thanks

Acked-by: Mel Gorman <mel@csn.ul.ie>


> Thanks;
> Judith Lebzelter
> OSDL
>
>
> --- arch/ppc/mm/init.c.old	2006-09-14 09:40:51.964543641 -0700
> +++ arch/ppc/mm/init.c	2006-09-14 10:04:46.814015750 -0700
> @@ -359,7 +359,7 @@
> void __init paging_init(void)
> {
> 	unsigned long start_pfn, end_pfn;
> -	unsigned long max_zone_pfns;
> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> #ifdef CONFIG_HIGHMEM
> 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
> 	pkmap_page_table = pte_offset_kernel(pmd_offset(pgd_offset_k
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
