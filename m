Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRASHlc>; Fri, 19 Jan 2001 02:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130860AbRASHlW>; Fri, 19 Jan 2001 02:41:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1031 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130325AbRASHlH>; Fri, 19 Jan 2001 02:41:07 -0500
Date: Fri, 19 Jan 2001 03:51:01 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pre5 VM feedback..
In-Reply-To: <940cq0$6fe$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101190345210.5038-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 Jan 2001, Linus Torvalds wrote:

> In article <3A63A9AE.345CBAF3@mandrakesoft.com>,
> Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
> >$!@#@! pre6 is already out :)
> 
> Yes, and for heavens sake don't use it, because the reiserfs merge got
> some dirty inode logic wrong. pre7 fixes just that one line and should
> be ok again.
> 
> >Anyway, this may be a totally subjective (and incorrect) perception, but
> >it seems to me like the recent 2.4.x-test kernels and thereafter start
> >swapping things out really quickly.  Case in point:  "diff -urN
> >linux.vanilla linux" command swaps out Konqueror and Netscape Mail, even
> >though I was using them only a few minutes ago.
> 
> Yes. It's really nice for some stuff, but a bit too aggressive for
> normal use, I think.
> 
> If you want to play with tuning, I'd suggest something like
> 
>  - make SWAP_SHIFT bigger (try with 7 instead of 5)
> 
>  - do the "self-swap-out" only for __GFP_VM allocations, and add the
>    __GFP_VM flag to all page fault allocations (ie __GPF_VM would be a
>    flag that says "this allocation will grow my RSS"). 
> 
> The latter is kind of debatable - some allocations can't easily be put
> in one category or the other (ie page cache growing - do we do it
> because of the page cache or because we want to map the page?)

The swapin readahead code tries to allocate (1 << page_cluster) pages at
each swapin. 

This means there's a big chance of having (1 << page_cluster)
"self-swap-out"'s at each swapin if we're under low memory.

Nasty. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
