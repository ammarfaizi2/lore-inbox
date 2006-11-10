Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932829AbWKJKES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbWKJKES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbWKJKES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:04:18 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:7308 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S932829AbWKJKER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:04:17 -0500
Date: Fri, 10 Nov 2006 10:04:15 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Aaron Durbin <adurbin@google.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: Fix partial page check to ensure unusable memory
 is not being marked usable.
In-Reply-To: <8f95bb250611091327j14cc96adwf66c0ed0ecf3b8ba@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611101002530.27174@skynet.skynet.ie>
References: <8f95bb250611091327j14cc96adwf66c0ed0ecf3b8ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006, Aaron Durbin wrote:

> Fix partial page check in e820_register_active_regions to ensure
> partial pages are
> not being marked as active in the memory pool.
>
> Signed-off-by: Aaron Durbin <adurbin@google.com>
>

Acked-by: Mel Gorman <mel@csn.ul.ie.ie>

This bug is in 2.6.19-rc5 and the patch will be needed for 2.6.19.

Thanks Aaron.

> ---
> This was causing a machine to reboot w/ an area in the e820 that was less
> than the page size because the upper address was being use to mark a hole as
> active in the memory pool.
>
> arch/x86_64/kernel/e820.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
> index a75c829..855b561 100644
> --- a/arch/x86_64/kernel/e820.c
> +++ b/arch/x86_64/kernel/e820.c
> @@ -278,7 +278,7 @@ e820_register_active_regions(int nid, un
> 								>> 
> PAGE_SHIFT;
>
> 		/* Skip map entries smaller than a page */
> -		if (ei_startpfn > ei_endpfn)
> +		if (ei_startpfn >= ei_endpfn)
> 			continue;
>
> 		/* Check if end_pfn_map should be updated */
> -- 
> 1.4.2.GIT
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
