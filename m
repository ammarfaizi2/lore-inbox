Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSFVXKp>; Sat, 22 Jun 2002 19:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSFVXKo>; Sat, 22 Jun 2002 19:10:44 -0400
Received: from bitmover.com ([192.132.92.2]:45802 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316935AbSFVXKn>;
	Sat, 22 Jun 2002 19:10:43 -0400
Date: Sat, 22 Jun 2002 16:10:45 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020622161045.X23670@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <m1r8j1rwbp.fsf@frodo.biederman.org> <20020621105055.D13973@work.bitmover.com> <m1lm97rx16.fsf@frodo.biederman.org> <20020622122656.W23670@work.bitmover.com> <m1hejvrlwm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1hejvrlwm.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Jun 22, 2002 at 04:25:29PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 04:25:29PM -0600, Eric W. Biederman wrote:
> The important point for me is that there are a fair number of
> fundamentally hard problems to get multiple kernels look like one.
> Especially when you start with a maximum decoupling.  And you seem to
> assume that solving these problems are trivial.

No such assumption was made.  Poke through my slides, you'll see that I
think it will take a reasonable amount of effort to get there.  I actually
spelled out the staffing and the time estimates.  Start asking around and
you'll find that senior people who _have_ gone the multi threading route
agree that this approach gets you to the same place with less than 1/10th
the amount of work.  The last guy who agreed with that statement was the
guy who headed up the threading design and implementation of Solaris,
he's at Netapp now.

In fairness to you, I'm doing the same thing you are: I'm arguing about
something I haven't done.  On the other hand, I have been through (twice)
the thing that you are saying is no problem and every person who has been
there agrees with me that it sucks.  It's doable, but it's a nightmare to
maintain, it easily increases the subtlety of kernel interactions by an
order of magnitude, probably closer to two orders.

And I have done enough of what I've described to know it can be done.
People who have deep knowledge of the fine grained approach have tried
to prove that I was wrong and failed, repeatedly.  They may not agree
that this is a better way but they can't show that it won't work.

> Maybe it is maintainable when you get done but there is a huge amount
> of work to get there.  I haven't heard of a distributed OS as anything
> other than a dream, or a prototype with scaling problems.

This is a distributed OS on one system, that's a lot easier than a
distributed OS across machine boundaries.  And if you are worried about
scaling problems, you don't understand the design.  The OS cluster idea
multi threads all data structures for free.  No locks on 99% of the 
data structures that you would need locks on in an SMP os.

Think about this fact: if you have lock contention you don't scale.  So
you thread until you don't.  Go do the math that shows how tiny of a 
fraction of 1% of lock contention screws your scaling, everyone has 
bumped up against those curves.  So the goal of any multithreaded OS
is ZERO lock contention.  Makes you wonder why the locks are there
in the first place.  They are trying to get to where I want to go but
they are definitely doing it the hard way.

> > Not as stupid as having a kernel noone can maintain and not being able
> > to do anything about it.  There seems to be a subthread of elitist macho
> > attitude along the lines of "oh, it won't be that bad, and besides,
> > if you aren't good enough to code in a fine grained locked, soft real
> > time, preempted, NUMA aware, then you just shouldn't be in the kernel".
> > I'm not saying you are saying that, but I've definitely heard it on
> > the list.  
> 
> Hmm.  I see a bulk of the on-going kernel work composed of projects to
> make the whole kernel easier to maintain.  
[...]
> I don't get the feeling that we are walking into a long
> term maintenance problem.

I don't mean to harp on this, but if you are going to comment on how
hard it is to maintain a kernel could you please give us some idea of
why it is you think as you do?  Do you have some prior experience with a
project of this size that shows what you believe to be true in practice?
You keep suggesting that there isn't a problem, that we aren't headed for
a problem.  Why is that?  Do you know something I don't?  I've certainly
seen what happens to a kernel source base as it goes through this process
a few times and my experience is that what you are saying is the opposite
of what happens.  So if you've got some different experience, how about
sharing it?  Maybe there is some way to do what you are suggesting will
happen, but I haven't ever seen it personally, nor have I ever heard
of it occurring in any long lived project.  All projects become more
complex as time goes on, it's a direct result of the demands placed on
any successful project.

> So in thinking about I agree that the constant simplification work
> that is done to the linux kernel looks like one of the most important
> activities long term.

What constant simplification work?  The generic part of the kernel does
more or less what it did a few years ago yet is has grown at a pretty fast
clip.  Talk to the embedded people and ask them if they think it has gotten
simpler.  By what standard has the kernel become less complex?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
