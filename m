Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUDRFKc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUDRFKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:10:32 -0400
Received: from florence.buici.com ([206.124.142.26]:42112 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264119AbUDRFKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:10:25 -0400
Date: Sat, 17 Apr 2004 22:10:24 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marc Singer <elf@buici.com>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418051024.GA19595@flea>
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea> <4081F809.4030606@yahoo.com.au> <20040418041748.GW743@holomorphy.com> <408206E8.5000600@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408206E8.5000600@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 02:41:12PM +1000, Nick Piggin wrote:
> William Lee Irwin III wrote:
> >On Sun, Apr 18, 2004 at 01:37:45PM +1000, Nick Piggin wrote:
> >
> >>swappiness is pretty arbitrary and unfortunately it means
> >>different things to machines with different sized memory.
> >>Also, once you *have* gone past the reclaim_mapped threshold,
> >>mapped pages aren't really given any preference above
> >>unmapped pages.
> >>I have a small patchset which splits the active list roughly
> >>into mapped and unmapped pages. It might hopefully solve your
> >>problem. Would you give it a try? It is pretty stable here.
> >
> >
> >It would be interesting to see the results of this on Marc's system.
> >It's a more comprehensive solution than tweaking numbers.
> >
> 
> Well, here is the current patch against 2.6.5-mm6. -mm is
> different enough from -linus now that it is not 100% trivial
> to patch (mainly the rmap and hugepages work).

Will this work against 2.6.5 without -mm6?

As an aside, I've been using SVN to manage my kernel sources.  While
I'd be thrilled to make it work, it simply doesn't seem to have the
heavy lifting capability to handle the kernel work.  I know the
rudiments of using BK.  What I'd like is some sort of HOWTO with
example of common tasks for kernel development.  Know of any?

> Marc if you could test this it would be great. I've been doing
> very swap heavy tests for the last 24 hours on a SMP system
> here, so it should be fairly stable.

I'm game.

> It replaces /proc/sys/vm/swappiness with
> /proc/sys/vm/mapped_page_cost, which is in units of unmapped
> pages. I have found 8 to be pretty good, so that is the
> default. Higher makes it less likely to evict mapped pages.

Sounds good.

Cheers.
