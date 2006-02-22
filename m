Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWBVDEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWBVDEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWBVDEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:04:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40923 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750973AbWBVDEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:04:41 -0500
Date: Tue, 21 Feb 2006 19:04:27 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove zone_mem_map 
In-Reply-To: <43FBAEBA.2020300@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0602211900450.23557@schroedinger.engr.sgi.com>
References: <43FBAEBA.2020300@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, KAMEZAWA Hiroyuki wrote:

> This patch removes zone_mem_map.

Note that IA64 does not seem to depend on zone_mem_map...

> Index: test/include/asm-generic/memory_model.h
> ===================================================================
> --- test.orig/include/asm-generic/memory_model.h
> +++ test/include/asm-generic/memory_model.h
> @@ -47,9 +47,9 @@ extern unsigned long page_to_pfn(struct
> 
>  #define page_to_pfn(pg)			\
>  ({	struct page *__pg = (pg);		\
> -	struct zone *__zone = page_zone(__pg);	\
> -	(unsigned long)(__pg - __zone->zone_mem_map) +	\
> -	 __zone->zone_start_pfn;			\
> +	struct pglist_data *__pgdat = NODE_DATA(page_to_nid(__pg));	\
> +	(unsigned long)(__pg - __pgdat->node_mem_map) +	\
> +	 __pgdat->node_start_pfn;			\
>  })

NODE_DATA is an arch specific lookup, If it always is a table lookup
then the performance will be comparable to page_zone because that also 
involves one table lookup.
