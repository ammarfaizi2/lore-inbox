Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUIEGN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUIEGN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIEGN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:13:57 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:40119 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266243AbUIEGNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:13:54 -0400
Message-ID: <413AAE92.3040208@yahoo.com.au>
Date: Sun, 05 Sep 2004 16:13:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/3] account free buddy areas
References: <413AA7B2.4000907@yahoo.com.au> <413AA7F8.3050706@yahoo.com.au>
In-Reply-To: <413AA7F8.3050706@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 1/3
> 
> 
> ------------------------------------------------------------------------
> 
> 
> 
> Keep track of the number of free pages of each order in the buddy allocator.
> 
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
> 
> 
> ---
> 
>  linux-2.6-npiggin/include/linux/mmzone.h |    1 +
>  linux-2.6-npiggin/mm/page_alloc.c        |   22 ++++++++--------------
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff -puN mm/page_alloc.c~vm-free-order-pages mm/page_alloc.c
> --- linux-2.6/mm/page_alloc.c~vm-free-order-pages	2004-09-05 14:53:53.000000000 +1000
> +++ linux-2.6-npiggin/mm/page_alloc.c	2004-09-05 14:53:53.000000000 +1000
> @@ -216,6 +216,7 @@ static inline void __free_pages_bulk (st
>  		page_idx &= mask;
>  	}
>  	list_add(&(base + page_idx)->lru, &area->free_list);
> +	area->nr_free++;
>  }
>  

Ahh, yes _that_ is why I got an offset in page_alloc.c

Obviously this function needs an area->nr_free-- in the loop somewhere around
list_del(&buddy1->lru);

I have actually tested the complete patchset with this addition, I just forgot
to update the patch.
