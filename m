Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277813AbRJIQaM>; Tue, 9 Oct 2001 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277816AbRJIQaH>; Tue, 9 Oct 2001 12:30:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51975 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277813AbRJIQ3u>; Tue, 9 Oct 2001 12:29:50 -0400
Date: Tue, 9 Oct 2001 13:08:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <20011009173937.M15943@athlon.random>
Message-ID: <Pine.LNX.4.21.0110091303380.5604-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Oct 2001, Andrea Arcangeli wrote:

> On Tue, Oct 09, 2001 at 11:34:47AM -0200, Marcelo Tosatti wrote:
> > The problem may well be in the memory balancing Andrea, but I'm not trying
> > to hide it with the infinite loop.
> 
> I assumed fixing the oom faliures with highmem was the main reason of
> the infinite loop.
> 
> > The infinite loop is just a guarantee that we'll have a reliable way of
> > throttling the allocators which can block. Not doing the infinite loop is
> 
> Throttling have nothing to do with the infinite loop.

Sorry but the infinite loop does throttles page reclamation until there
is enough memory for the process allocating memory to go on.

> > just way too fragile IMO and it is _prone_ to fail in intensive
> > loads. 
> 
> It is too fragile if the vm is doing the wrong actions and so we must
> loop over and over again before it finally does the right thing.
> 
> If allocation fails that's a nice feedback that tell us "the memory
> balancing is at least inefficient in doing the right thing, looping
> would only waste more cache and more time for the allocation".
> 
> Think a list where pages can be only freeable or unfreeable.  Now scan
> _all_ the pages and free all the freeable ones. Finished. If it failed
> and it couldn't free anything it means there was nothing to free so
> we're oom. How can that be "fragile"?

That is fragile IMHO, Andrea.

The infinite loop is simple, reliable logic which shows to works (as long
as the OOM killer is working correctly).

> In real life it isn't as simple as that, there's some "race" effect
> caming from the schedules in between, there are multiple lists, there's
> swapout etc... so it's a little more complex than just "freeable" and
> "unfreeable" and a single list, but it can be done, 2.2 does that too,
> if we loop over and over again and we do no progress in the right
> direction I prefer to know about that via an allocation faliure rather
> than by just getting sucking performance. Also an allocation faliure is
> a minor problem compared to a deadlock that the infinite loop cannot
> prevent.

If the OOM killer is doing its job correctly, a deadlock will not happen.

> > If the problem is the highmem balancing, I'll love to get your fixes and
> > integrate with the infinite loop logic, which is a separated (related,
> > yes, but separate) thing.
> 
> The infinite loop shouldn't do anything except introducing the deadlock
> after that (otherwise it means I failed :), but you're free to go in
> your direction if you think it's the right one of course (like I'm free
> to go in my direction since I think it's the right one).

Sure. :) 

