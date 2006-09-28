Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWI1TPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWI1TPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWI1TPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:15:20 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:33528 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1030321AbWI1TPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:15:18 -0400
Date: Thu, 28 Sep 2006 20:14:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Adam Litke <agl@us.ibm.com>
cc: akpm@osdl.org, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH] mm: Make filemap_nopage use NOPAGE_SIGBUS
In-Reply-To: <1159470592.12797.23334.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609282013360.9244@blonde.wat.veritas.com>
References: <1159470592.12797.23334.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2006 19:14:48.0016 (UTC) FILETIME=[5D51F500:01C6E332]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Adam Litke wrote:
> Hi Andrew.  This is just a "nice to have" cleanup patch.  Any chance on
> getting it merged (lest I forget about it again)?  Thanks.
> 
> While reading trough filemap_nopage() I found the 'return NULL'
> statements a bit confusing since we already have two constants defined
> for ->nopage error conditions.  Since a NULL return value really means
> NOPAGE_SIGBUS, just return that to make the code more readable.
> 
> Signed-off-by: Adam Litke <agl@us.ibm.com> 

That's long confused and irritated me, gladly
Acked-by: Hugh Dickins <hugh@veritas.com>

> 
>  filemap.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> diff -upN reference/mm/filemap.c current/mm/filemap.c
> --- reference/mm/filemap.c
> +++ current/mm/filemap.c
> @@ -1454,7 +1454,7 @@ outside_data_content:
>  	 * accessible..
>  	 */
>  	if (area->vm_mm == current->mm)
> -		return NULL;
> +		return NOPAGE_SIGBUS;
>  	/* Fall through to the non-read-ahead case */
>  no_cached_page:
>  	/*
> @@ -1479,7 +1479,7 @@ no_cached_page:
>  	 */
>  	if (error == -ENOMEM)
>  		return NOPAGE_OOM;
> -	return NULL;
> +	return NOPAGE_SIGBUS;
>  
>  page_not_uptodate:
>  	if (!did_readaround) {
> @@ -1548,7 +1548,7 @@ page_not_uptodate:
>  	 */
>  	shrink_readahead_size_eio(file, ra);
>  	page_cache_release(page);
> -	return NULL;
> +	return NOPAGE_SIGBUS;
>  }
>  EXPORT_SYMBOL(filemap_nopage);
>  
> -- 
> Adam Litke - (agl at us.ibm.com)
> IBM Linux Technology Center
> 
