Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSFVWfq>; Sat, 22 Jun 2002 18:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSFVWfp>; Sat, 22 Jun 2002 18:35:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36209 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316919AbSFVWfn>; Sat, 22 Jun 2002 18:35:43 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com>
	<m1r8j1rwbp.fsf@frodo.biederman.org>
	<20020621105055.D13973@work.bitmover.com>
	<m1lm97rx16.fsf@frodo.biederman.org>
	<20020622122656.W23670@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Jun 2002 16:25:29 -0600
In-Reply-To: <20020622122656.W23670@work.bitmover.com>
Message-ID: <m1hejvrlwm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Sat, Jun 22, 2002 at 12:25:09PM -0600, Eric W. Biederman wrote:
> > To specifics, I don't see the point of OSlets on a single cpu that is
> > hyper threaded.  Traditional threading appears to make more sense to
> > me.  Similarly I don't see the point in the 2-4 cpu range.
> 
> In general I agree with you here, but I think you haven't really considered
> all the options.  I can see the benefit on a *single* CPU.  There are all
> sorts of interesting games you could play in the area of fault tolerance
> and containment.  Imagine a system, like what IBM has, that runs lots of
> copies of Linux with the mmap sharing turned off.  ISPs would love
> it.

Hmm. Perhaps.  But you are fundamentally susceptible to the base
kernel, and the hardware on the machine.

> Jeff Dike pointed out that if UML can run one kernel in user space, why
> not N?  And if so, the OS clustering stuff could be done on top of
> UML and then "ported" to real hardware.  I think that's a great idea,
> and you can carry it farther, you could run multiple kernels just for
> fault containment.  See Sun's domains, DEC's Galaxy.

Right.  A clustered environment is accessible.  For the most part I
don't have a problem (except check pointing) that is facilitated by
running linux under linux.

Currently my problem to solve is compute clusters.  My current worries
are not can I scale a kernel to 64 cpus.  My practical worries are
will my user space to 1000 dual processor machines. 

The important point for me is that there are a fair number of
fundamentally hard problems to get multiple kernels look like one.
Especially when you start with a maximum decoupling.  And you seem to
assume that solving these problems are trivial.

Maybe it is maintainable when you get done but there is a huge amount
of work to get there.  I haven't heard of a distributed OS as anything
other than a dream, or a prototype with scaling problems.

> > Given that there are some scales when you don't want/need more than
> > one kernel, who has a machine where OSlets start to pay off?  They
> > don't exist in commodity hardware, so being proactive now looks
> > stupid.
> 
> Not as stupid as having a kernel noone can maintain and not being able
> to do anything about it.  There seems to be a subthread of elitist macho
> attitude along the lines of "oh, it won't be that bad, and besides,
> if you aren't good enough to code in a fine grained locked, soft real
> time, preempted, NUMA aware, then you just shouldn't be in the kernel".
> I'm not saying you are saying that, but I've definitely heard it on
> the list.  

Hmm.  I see a bulk of the on-going kernel work composed of projects to
make the whole kernel easier to maintain.  Especially interesting is
the work that makes drivers relatively easy, and free from all of this
cruft.

Running some numbers (wc -l kernel/*.c fs/*.c mm/*.c)
1.2.12: 18813 lines
2.2.12: 37510 lines
2.5.14: 55701 lines

So the core kernel is growing, but a fairly slow rate.  Only worrying
about the 60 thousand lines of generic kernel code is much better than
worrying about the 3 million lines of driver code.

And since you thought it was an interesting statistic:
grep CONFIG_SMP kernel/*.c fs/*.c mm/*.c init/*.c | wc -l
 44

So most of the code that cares about SMP is not in the core of the
kernel, but is mostly the code that actually implements SMP support.

So in thinking about I agree that the constant simplification work
that is done to the linux kernel looks like one of the most important
activities long term.

> It's a great thing for bragging rights but it's a horrible thing from
> the sustainability point of view.  

Given that the simplification efforts tend to be some of the highest
priority activities in the kernel, and the easiest patches to get
accepted.  I don't get the feeling that we are walking into a long
term maintenance problem.

As for bragging rights, my kernel work tends to be some of the easiest
code I have to write.  I have no doubts that C is a high level
programming language.

Eric
