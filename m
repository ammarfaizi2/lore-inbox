Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311148AbSCHVhq>; Fri, 8 Mar 2002 16:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311145AbSCHVhg>; Fri, 8 Mar 2002 16:37:36 -0500
Received: from rj.sgi.com ([204.94.215.100]:38815 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311148AbSCHVhT>;
	Fri, 8 Mar 2002 16:37:19 -0500
Date: Fri, 8 Mar 2002 13:37:08 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop null ptr deference in __alloc_pages
In-Reply-To: <18990000.1015622208@flay>
Message-ID: <Pine.LNX.4.33.0203081325560.18968-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Martin J. Bligh wrote:

> >> If you applied an SGI patch that makes the zonelist contain all the zones
> >> of your machine, then the zonelist should not be NULL.
> >> If you allocate memory with gfp_mask & GFP_ZONEMASK == GFP_NORMAL from a
> >> HIGHMEM only node, then the first entry on the corresponding zonelist
> >> should be the first NORMAL zone on some other node.
> >> Am I missing something here ?
> >
> > You're missing the fact that I'm missing the SGI patch ;-)
Oh, I see. I was missing something then...;-)


>
> I should have also mentioned that:
>
> 1) I shouldn't need the SGI patch, though it might help performance.
Why shouldn't you need it ? It is NUMA generic, and totally arch
independent.
And it actually helps performance. I also allows the kernel to have a
single memory allocation path. I think it is cleaner than calling _alloc_pages()
from numa.c

> 2) The kernel panics without my fix, and runs fine with it.
I hope so  :-)
But your fix is at the same time useless and harmless for UMA machines.
OTOH, the SGI patch doesn't modify __alloc_pages(). I think I'm a little
too picky here...

Cheers,
Samuel.



