Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285096AbRLLIkr>; Wed, 12 Dec 2001 03:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285097AbRLLIkh>; Wed, 12 Dec 2001 03:40:37 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24076 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285096AbRLLIkU>; Wed, 12 Dec 2001 03:40:20 -0500
Message-ID: <3C1717C3.82CC4A63@zip.com.au>
Date: Wed, 12 Dec 2001 00:39:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <3C151F7B.44125B1@zip.com.au>, <3C151F7B.44125B1@zip.com.au>; <20011211011158.A4801@athlon.random> <3C15B0B3.1399043B@zip.com.au>,
		<3C15B0B3.1399043B@zip.com.au>; from akpm@zip.com.au on Mon, Dec 10, 2001 at 11:07:31PM -0800 <20011211144223.E4801@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> 
> [ big snip.  Addressed in other email ]
> 
> it should be simple, mainline swapouts more, so it's less likely to
> trash away some useful cache.
> 
> just try -aa after a:
> 
>         echo 10 >/proc/sys/vm/vm_mapped_ratio
> 
> it should swapout more and better preserve the cache.

-aa swapout balancing seems very good indeed to me.

> > > > In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_others().
> > > > So we're madly trying to swap pages out and finding that there's no swap
> > > > space.  I beleive that when we find there's no swap left we should move
> > > > the page onto the active list so we don't keep rescanning it pointlessly.
> > >
> > > yes, however I think the swap-flood with no swap isn't a very
> > > interesting case to optimize.
> >
> > Running swapless is a valid configuration, and the kernel is doing
> 
> I'm not saying it's not valid or non interesting.
> 
> It's the mix "I'm running out of memory and I'm swapless" that is the
> case not interesting to optimize.
> 
> If you're swapless it means you've enough memory and that you're not
> running out of swap. Otherwise _you_ (not the kernel) are wrong not
> having swap.

um.  Spose so.
 
> ...
> 
> > The VM code lacks comments, and nobody except yourself understands
> > what it is supposed to be doing.  That's a bug, don't you think?
> 
> Lack of documentation is not a bug, period. Also it's not true that I'm
> the only one who understands it. For istance Linus understand it
> completly, I am 100% sure.
> 
> Anyways I wrote a dozen of slides on the VM with some graph showing the
> design of the VM if anybody can better learn from a slide than from the
> code.

That's good.  Your elevator design slides were very helpful.  However
offline documentation tends to go stale.   A nice big block comment
maintained by a programmer who cares goes a loooog way.

> I believe the slides are useful to understand the design, but if you
> want to change one line of code slides or not you've to read the code.
> Everybody is complaining about documentation. This is a red-herring.
> There's no documentation that allows you to hack the previous VM code.
> I'd ask how many of the people happy with the previous documentation
> were effectively VM developers. Except for some possible misleading
> comment in the current code that we may have not updated yet, I don't
> think there's been a regression in documentation.
> 

Sigh.  Just because the current core kernel looks like it was
scrawled in crayon by an infant doesn't mean that everyone has
to eschew literate, mature, competent and maintainable programming
practices.

-
