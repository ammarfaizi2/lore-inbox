Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWBJFcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWBJFcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWBJFcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:32:39 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:51023 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751111AbWBJFci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:32:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mLQTE2zG8QvKMHwSvwBABFYBIFFOGMKMMro7Fv0E0zcym61UyV1C3FVKEmbHUjZ5XfxAwmIjNTEydXikOqsRIPXwd+JCWm5ph5ZAjTqUksZvpI+uCP+gYloe7m9FdKUGsCUN6NwlAwPbIYhOC4iQKTqiJQMs3IDph4ac6JKU8JA=  ;
Message-ID: <43EC2572.7010100@yahoo.com.au>
Date: Fri, 10 Feb 2006 16:32:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
References: <200602101355.41421.kernel@kolivas.org> <20060209205559.409c0290.akpm@osdl.org> <43EC1E0E.6060702@yahoo.com.au> <200602101626.12824.kernel@kolivas.org>
In-Reply-To: <200602101626.12824.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Just so it's clear I understand, is this what you (both) had in mind?
> Inline so it's not built for !CONFIG_SWAP_PREFETCH
> 

Close...

> Index: linux-2.6.16-rc2-ck1/mm/swap.c
> ===================================================================
> --- linux-2.6.16-rc2-ck1.orig/mm/swap.c	2006-02-09 21:53:37.000000000 +1100
> +++ linux-2.6.16-rc2-ck1/mm/swap.c	2006-02-10 16:22:45.000000000 +1100
> @@ -156,6 +156,13 @@ void fastcall lru_cache_add_active(struc
>  	put_cpu_var(lru_add_active_pvecs);
>  }
>  
> +inline void lru_cache_add_tail(struct page *page)

Is this inline going to do what you intend?

> +{
> +	struct zone *zone = page_zone(page);
> +

     spin_lock_irq(&zone->lru_lock);

> +	add_page_to_inactive_list_tail(zone, page);

     spin_unlock_irq(&zone->lru_lock);

> +}
> +
>  static void __lru_add_drain(int cpu)
>  {
>  	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
