Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264336AbRFGGjj>; Thu, 7 Jun 2001 02:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264341AbRFGGj3>; Thu, 7 Jun 2001 02:39:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45100 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264336AbRFGGjT>; Thu, 7 Jun 2001 02:39:19 -0400
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
	<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
	<m1wv6p5uqp.fsf@frodo.biederman.org> <3B1EA748.6B9C1194@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 00:35:36 -0600
In-Reply-To: <3B1EA748.6B9C1194@sgi.com>
Message-ID: <m1g0dc6blz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com> writes:

> "Eric W. Biederman" wrote:
> 
> > The hard rule will always be that to cover all pathological cases swap
> > must be greater than RAM.  Because in the worse case all RAM will be
> > in thes swap cache.  That this is more than just the worse case in 2.4
> > is problematic.  I.e. In the worst case:
> > Virtual Memory = RAM + (swap - RAM).
> 
> Hmmm....so my 512M laptop only really has 256M?  Um...I regularlly run
> more than 256M of programs.  I don't want it to swap -- its a special, weird
> condition if I do start swapping.  I don't want to waste 1G of HD (5%) for
> something I never want to use.  IRIX runs just fine with swap<RAM.  In
> Irix, your Virtual Memory = RAM + swap.  Seems like the Linux kernel requires
> more swap than other old OS's (SunOS3 (virtual mem = min(mem,swap)).
> I *thought* I remember that restriction being lifted in SunOS4 when they
> upgraded the VM.  Even though I worked there for 6 years, that was
> 6 years ago...

There are cetain scenario's where you can't avoid virtual mem =
min(RAM,swap). Which is what I was trying to say, (bad formula).  What
happens is that pages get referenced  evenly enough and quickly enough
that you simply cannot reuse the on disk pages.  Basically in the
worst case all of RAM is pretty much in flight doing I/O.  This is
true of all paging systems.

However just because in the worst case virtual mem = min(RAM,swap), is
no reason other cases should use that much swap.  If you are doing a
lot of swapping it is more efficient to plan on mem = min(RAM,swap) as
well, because frequently you can save on I/O operations by simply
reusing the existing swap page.

> 
> > You can't improve the worst case.  We can improve the worst case that
> > many people are facing.
> 
> ---
>     Other OS's don't have this pathological 'worst case' scenario.  Even
> my Windows [vm]box seems to operate fine with swap<MEM.  On IRIX,
> virtual space closely approximates physical + disk memory.

It's a theoretical worst case and they all have it.  In practice it is
very hard to find a work load where practically every page in the
system is close to the I/O point howerver.

Except for removing pages that aren't used paging with swap < RAM is
not useful.  Simply removing pages that aren't in active use but might
possibly be used someday is a common case, so it is worth supporting.

> 
> > It's worth complaining about.  It is also worth digging into and find
> > out what the real problem is.  I have a hunch that this hole
> > conversation on swap sizes being irritating is hiding the real
> > problem.
> 
> ---
>     Okay, admission of ignorance.  When we speak of "swap space",
> is this term inclusive of both demand paging space and
> swap-out-entire-programs space or one or another?

Linux has no method to swap out an entire program so when I speak of
swapping I'm actually thinking paging.

Eric
