Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313680AbSEEVvw>; Sun, 5 May 2002 17:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313682AbSEEVvv>; Sun, 5 May 2002 17:51:51 -0400
Received: from dsl-213-023-038-176.arcor-ip.net ([213.23.38.176]:41915 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313680AbSEEVvv>;
	Sun, 5 May 2002 17:51:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 1/10] suppress allocation warnings for radix-tree allocations
Date: Sun, 5 May 2002 23:51:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD59BAD.37BD6A51@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174TuG-0004As-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 May 2002 22:53, Andrew Morton wrote:
> The recently-added page allocation failure warning generates a lot of
> noise due to radix-tree node allocation failures.  Those messages are
> not interesting.
> 
> But I think the warning is otherwise useful - "I got an allocation
> failure and then it crashed" is better than "it crashed".
> 
> The patch suppresses the message for ratnode allocation failures.
> 
> =====================================
> 
> --- 2.5.13/mm/vmscan.c~radix-tree-warning	Sun May  5 13:31:59 2002
> +++ 2.5.13-akpm/mm/vmscan.c	Sun May  5 13:31:59 2002
> @@ -58,6 +58,7 @@ swap_out_add_to_swap_cache(struct page *
>  	int ret;
>  
>  	current->flags &= ~PF_MEMALLOC;
> +	current->flags |= PF_RADIX_TREE;


Isn't that really 'PF_NO_WARN_ALLOC'?

-- 
Daniel
