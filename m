Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVAHVM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVAHVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVAHVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:12:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30855 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261492AbVAHVMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:12:53 -0500
Date: Sat, 8 Jan 2005 21:12:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       <linux-ia64@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       <linux-mm@kvack.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Christoph Lameter wrote:
> This patch introduces __GFP_ZERO as an additional gfp_mask element to allow
> to request zeroed pages from the page allocator.
> ...
> --- linux-2.6.10.orig/mm/memory.c	2005-01-04 12:16:41.000000000 -0800
> +++ linux-2.6.10/mm/memory.c	2005-01-04 12:16:49.000000000 -0800
> @@ -1650,10 +1650,9 @@
> 
>  		if (unlikely(anon_vma_prepare(vma)))
>  			goto no_mem;
> -		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +		page = alloc_page_vma(GFP_HIGHZERO, vma, addr);
>  		if (!page)
>  			goto no_mem;
> -		clear_user_highpage(page, addr);
> 
>  		spin_lock(&mm->page_table_lock);
>  		page_table = pte_offset_map(pmd, addr);

Christoph, a late comment: doesn't this effectively replace
do_anonymous_page's clear_user_highpage by clear_highpage, which would
be a bad idea (inefficient? or corrupting?) on those few architectures
which actually do something with that user addr?

Hugh

