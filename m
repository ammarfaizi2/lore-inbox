Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbRLFELW>; Wed, 5 Dec 2001 23:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284968AbRLFELR>; Wed, 5 Dec 2001 23:11:17 -0500
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:21159 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284966AbRLFELF>; Wed, 5 Dec 2001 23:11:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Date: Wed, 5 Dec 2001 15:09:44 -0500
X-Mailer: KMail [version 1.3.1]
Cc: lm@bitmover.com (Larry McVoy), Martin.Bligh@us.ibm.com (Martin J. Bligh),
        riel@conectiva.com.br (Rik van Riel), hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16BmUZ-0008CI-00@the-village.bc.nu>
In-Reply-To: <E16BmUZ-0008CI-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206041104.LBRX17345.femail42.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 December 2001 07:34 pm, Alan Cox wrote:
> > So either way, you wind up with SMP on one die.  (You can't make chips
> > TOO much smaller because it becomes less economical to cut the wafer up
> > that small.  Harvesting and connecting the chips at finer granularity
> > increases
>
> Except for VIA (where they cant really make them much smaller) the
> mainstream x86 dies are _gigantic_

Yeah.  Exactly.  Especially Intel's own.  Itanium's enormous, and I mentioned 
how Pentium 4 had pushed pipelining slightly beyond where you really get all 
that much benefit from it.

They've grown to take advantage of larger transistor budgets, but that's 
starting to hit limits on how big you can usefully make them before you get 
serious diminishing returns and problems with clock skew and signal 
propogation delays and other such fun.  (Hence the experiments with clockless 
processors, etc.)  The longer the wire, the longer it takes a signal to go 
down it.  You want contained modules so you can clock them fast (hence 
pipeline stages).

Athlon hasn't gone pipeline happy the way P4 has, so they don't suffer as 
badly from pipeline stalls, but it already has three execution cores (and 
requesite monstrous front-end decoding and scheduling stuff to those cores), 
with no plans to add a fourth core because the third isn't busy enough that 
they think it would help.

Yet manufacturing is going to continue to shrink the density, giving you more 
area to work with and a higher transistor budget, which is about 80% of 
Moore's Law.  Despite gloom and doom predictions since at least the early 
1980's has got four or five more doublings to go before we even have to worry 
about increasing the number of layers to get extra space.  So where's that 
extra transistor budget going to go?  Bigger L1 cache?  Fun, but the main 
benefit of a really huge cache isn't on a UP system, but on SMP.  The benefit 
of an L1 cache is one of them "integral of somevalue/x" functions, the 
increase in which falls off pretty rapidly the bigger it gets: the more bytes 
of cache the greater percentage chance your next piece of data will be in 
cache, but also the more transistors are guaranteed to be sitting idle 
because they do NOT contain data you need this cycle.  A point of diminishing 
returns definitely exists here.

You also can't make the chips infinitely small because it's not worth the 
money (manufacturing expense).  Beyond a certain point, more chips per wafer 
aren't that much cheaper because the taxidermy to test, cut, connect, mount, 
package, and ship them becomes a bigger percentage of the cost.  And you 
still want to amortize your factory, so reducing per-chip manufacturing 
expense won't reduce cost noticeably anyway as long as new manufacturing 
processes require billions to get the new line up and running. 

Intel is trying to transition to VLIW as a way to use more linked execution 
cores to do SOMETHING useful with the extra transistor budget, and 
Transmeta's even trying to get VLIW to do something USEFUL, but it's a 
different programming model that'll take a while to transition to, and it 
requires intelligent compilers finding paralellism in the chip, which isn't 
easy.

Or, you could use the execution units to run independent threads, which Intel 
is ALREADY experimenting with (SMT instead of SMP), but that's really just a 
way of backfitting SMP-on-a-die onto the existing linked-core design without 
having to redo your process counter and cache circuitry.  And again this 
requires compilers to catch up, which won't happen for a while, and even then 
a programmer could really do a better job of telling the computer what to do.

So the logical thing to do is SMP on a single die (which IBM at least has 
been attempting).  Not only does it convert transistors into execution speed 
efficiently, it allows you to have a flaming big L1 and L2 cache in a way 
that it's more likely to accomplish something useful.

And THAT'S what makes SMP interesting in the future.  To me anyway.  I could 
be wrong...

Rob
