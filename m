Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135474AbRDZOW5>; Thu, 26 Apr 2001 10:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRDZOWt>; Thu, 26 Apr 2001 10:22:49 -0400
Received: from www.wen-online.de ([212.223.88.39]:43536 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135474AbRDZOWb>;
	Thu, 26 Apr 2001 10:22:31 -0400
Date: Thu, 26 Apr 2001 16:21:55 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104261100490.19012-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0104261608460.334-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Rik van Riel wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
>
> > 1. pagecache is becoming swapcache and must be aged before anything is
> > done.  Meanwhile we're calling refill_inactive_scan() so fast that noone
> > has a chance to touch a page.   Age becomes a simple counter.. I think.
> > When you hit a big surge, swap pages are at the back of all lists, so all
> > of your valuable cache gets reclaimed before we write even one swap page.
>
> Does the patch I sent to linux-mm@kvack.org last night help in
> this ?
>
> I found that the way refill_inactive_scan() and swap_out() are being
> called from the main loop in refill_inactive() aren't equal and have
> fixed that in a way which (IMHO) also beautifies the code a bit.
>
> (and makes sure background aging doesn't get out of hand with a few
> simple checks)

That patch livelocked my box with only ~1000 pages on any list.

I can go back and test some more if you want.  (I've seen this so
many times here that I generally just curse a lot [frustration] and
burn the whole tree to it's roots as soon as it shows up)

SysRq: Show Memory
Mem-info:
Free pages:        1404kB (     0kB HighMem)
( Active: 975, inactive_dirty: 28, inactive_clean: 0, free: 351 (351 702 1053) )
0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB = 512kB)
1*4kB 5*8kB 1*16kB 0*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 892kB)
= 0kB)
Swap cache: add 72, delete 63, find 17/67
Free swap:       264864kB
32752 pages of RAM
0 pages of HIGHMEM
1183 reserved pages
27657 pages shared
9 pages swap cached
0 pages in page table cache
Buffer memory:      112kB

