Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279747AbRJ3CZi>; Mon, 29 Oct 2001 21:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279749AbRJ3CZ3>; Mon, 29 Oct 2001 21:25:29 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:56929 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279747AbRJ3CZK>; Mon, 29 Oct 2001 21:25:10 -0500
Date: Mon, 29 Oct 2001 21:25:46 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029212546.B17506@redhat.com>
In-Reply-To: <20011029.173400.35036258.davem@redhat.com> <Pine.LNX.4.33.0110291736010.7778-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110291736010.7778-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 29, 2001 at 05:42:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 05:42:07PM -0800, Linus Torvalds wrote:
> 
> On Mon, 29 Oct 2001, David S. Miller wrote:
> >
> > I'm asking him to show the case that "breaks for something
> > else".
> 
> Guys, guys, calm down.

I'm trying to be.  Dave just rubs me the wrong way with his inability to 
think about the problem for a minute instead of insisting on proof that
incorrect behaviour can happen.  Damnit, it's supposed to be a kernel on 
its way towards being more stable, not less.  This is especially insulting 
when you can bother to go through the work of it as a thought experiment in 
less than 5 minutes to realise what could happen.

Dave: please read the above paragraph again.  Now, can you see why I'm 
arguing for doing the optimization in the *correct* way first?  The 
microbenchmark will always "prove" that avoiding the tlb flush is a win.  
The test to prove that the failure case can happen is non-trivial, and 
proving the real world win/loss is lengthy task involving lots of 
benchmarks and effort.  Please just sit down and think for 5 minutes and 
acknowledge that it is a possibility!

> The difference in call frequency would, on large machines, probably be on
> the order of several magnitudes, which will certainly cut the overhead
> down to the noise while satisfying people who have architectures that can
> cache things for a long time.
> 
> Agreed?

Which is exactly what was in the back of my mind in the first place.  I 
didn't write the patch as the distraction of going off on yet another 
tangent when I'm this > < close to being done with the battle I'm currently 
in just doesn't make sense.  I'm sorry, but I'm not the best person for 
doing a brain dump when in the middle of something, plus I assume that 
people can think about the how and why of things for themselves.  You'll 
note that I never denied that the microoptimization in question is a win; 
I fully well expect it to be.  However, from the point of view of stability 
we *want* to be conservative and correct.  If Al had to demonstrate with 
'sploits that a possible vfs race could occur every time he found one, 
wouldn't he be wasting time that could be better spent finding and fixing 
other problems???  Dave, please accept that other people's opinions 
occasionally hold value and reconsider reacting negatively without thinking 
first.

		-ben
-- 
Fish.
