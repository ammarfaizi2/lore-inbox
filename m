Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293514AbSCEDHv>; Mon, 4 Mar 2002 22:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSCEDHg>; Mon, 4 Mar 2002 22:07:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39173 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293514AbSCEDHP>; Mon, 4 Mar 2002 22:07:15 -0500
Date: Mon, 4 Mar 2002 22:05:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <Pine.LNX.4.44L.0203042225340.2181-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020304215448.24212A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Rik van Riel wrote:

> On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> > On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> > > This could be expressed as:
> > >
> > > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> > > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA
> >
> > Highmem? Let's assume you speak about "normal" and "dma" only of course.
> >
> > And that's not always the right zonelist layout. If an allocation asks for
> > ram from a certain node, like during the ram bindings, we should use the
> > current layout of the numa zonelist. If node A is the preferred, than we
> > should allocate from node A first,
> 
> You're forgetting about the fact that this NUMA box only
> has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
> HIGHMEM zones...
> 
> This makes the fallback pattern somewhat more complex.

Both HIMEM (on CPU) and NUMA nodes remind me somewhat of the days when
"band switched" memory was supposed to be the answer to limited addressing
space. The trick was to have things in the right place and not eat up the
capacity with moving data. I think you're right that the problem is not as
simple several posters have suggested. I'm afraid someone will have to do
some clever adaptive work here, the speed of the connects to the memory
will change as both evolve. And it's easier to make a node smaller than
put them closer together. 

I'm awaiting the IBM paper(s) on this, I don't find my Hypercube and PVM
experience to fit well anymore :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

