Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289387AbSA1UZT>; Mon, 28 Jan 2002 15:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSA1UYW>; Mon, 28 Jan 2002 15:24:22 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:43909 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289398AbSA1UXf>;
	Mon, 28 Jan 2002 15:23:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.18pre4aa1
Date: Mon, 28 Jan 2002 21:28:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020124002342.A630@earthlink.net> <E16V8Te-00008L-00@starship.berlin> <20020128162916.B1309@athlon.random>
In-Reply-To: <20020128162916.B1309@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VIO8-0000CO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 04:29 pm, Andrea Arcangeli wrote:
> On Mon, Jan 28, 2002 at 10:53:25AM +0100, Daniel Phillips wrote:
> > On January 25, 2002 01:09 am, Andrea Arcangeli wrote:
> > > On Thu, Jan 24, 2002 at 07:27:43AM +0100, Daniel Phillips wrote:
> > > > On January 24, 2002 06:23 am, rwhron@earthlink.net wrote:
> > > > Even when mostly uncached, dbench still produces flaky results.
> > [...]
> > > the only problem with
> > > dbench is that you can trivially cheat and change the kernel in a broken
> > > way, but optimal _only_ for dbench, just to get stellar dbench numbers,
> > 
> > No, this is not the only problem.  DBench is just plain *flaky*.  You 
don't
> > appear to be clear on why.  In short, dbench has two main flaws:
> > 
> >   - It's extremely sensitive to scheduling.  If one process happens to 
make
> >     progress then it gets more heavily cached and its progress becomes 
even
> >     greater.  The benchmark completes much more quickly in this case, 
whereas
> >     if all processes progress at nearly the same rate (by chance) it runs
> >     more slowly.
> > 
> >   - It can happen (again by chance) that dbench files get deleted while 
still
> >     in cache, and this process completes in a fraction of the time that 
real 
> >     disk IO would require.
> > 
> > I've seen successsive runs of dbench *under identical conditions* (that 
is, 
> > from a clean reboot etc.) vary by as much as 30%.  Others report even 
greater 
> > variance.  Can we please agree that dbench is useless for benchmarks?
> 
> I never seen it to vary 30% on the same kernel.

Just ask around.  Marcelo or Andrew Morton would be a good place to start.

> Anyways dbench tells you mostly about elevator etc... it's a good test
> to check the elevator is working properly, the ++ must be mixed with the
> dots etc... if the elevator is aggressive enough. Of course that means
> the elevator is not perfectly fair but that's the whole point about
> having an elevator. It is also an interesting test for page replacement,
> but with page replacement it would be possible to write a broken
> algorithm that produces good numbers, that's the thing I believe to be
> bad about dbench (oh, like tiotest fake numbers too of course). Other
> than this it just shows rmap12a has an elevator not aggressive enough
> which is probably true, I doubt it has anything to do with the VM
> changes in rmap (of course rmap design significant overhead is helping
> to slow it down too though), more likely the bomb_segments logic from
> Andrew that Rik has included, infact the broken page replacement that
> lefts old stuff in cache if something might generate more unfairness
> that should generate faster dbench numbers for rmap, but on this last
> bit I'm not 100% sure (AFIK to get a fast dbench by cheating with the vm
> you need to make sure to cache lots of the readahead as well (also the
> one not used yet), but I'm not 100% sure on the effect of lefting old
> pollution in cache rather than recycling it, I never attempted it).

Interesting analysis.  It's a hint at how hard the elevator problem really 
is.  Fairness as in 'equal load distribution' is not the best policy under 
heavy load, just as it is not the best policy under heavy swapping.  Exactly 
what kind of unfairness is best, though, is a deep, difficult question.  I'll 
bet it doesn't get seriously addressed even in this kernel cycle, or at best, 
very late in the cycle after the big infrastructure changes settle down.

-- 
Daniel
