Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUKOUtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUKOUtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKOUsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:48:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58261 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261698AbUKOUqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:46:04 -0500
Date: Mon, 15 Nov 2004 12:45:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] low discontig highmem_start_page
Message-ID: <13880000.1100551550@flay>
In-Reply-To: <Pine.LNX.4.44.0411152035020.4131-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0411152035020.4131-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, November 15, 2004 20:37:28 +0000 Hugh Dickins <hugh@veritas.com> wrote:

> In the case of i386 CONFIG_DISCONTIGMEM CONFIG_HIGHMEM without highmem,
> highmem_start_page was wrongly initialized (from a NULL zone_mem_map),
> causing __change_page_attr to BUG on boot.

Thanks, I'm not suprised that was broken - I never test without highmem ;-)

M.
 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> --- 2.6.10-rc2/arch/i386/mm/discontig.c	2004-11-15 16:20:26.000000000 +0000
> +++ linux/arch/i386/mm/discontig.c	2004-11-15 17:01:26.000000000 +0000
> @@ -468,7 +468,7 @@ void __init set_max_mapnr_init(void)
>  	if (high0->spanned_pages > 0)
>  	      	highmem_start_page = high0->zone_mem_map;
>  	else
> -		highmem_start_page = pfn_to_page(max_low_pfn+1); 
> +		highmem_start_page = pfn_to_page(max_low_pfn - 1) + 1; 
>  	num_physpages = highend_pfn;
>  #else
>  	num_physpages = max_low_pfn;
> 
> 


