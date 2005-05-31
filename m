Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVEaQus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVEaQus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEaQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:49:13 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:32920 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261963AbVEaQnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:43:32 -0400
Date: Tue, 31 May 2005 18:42:26 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
Subject: Re: RT patch acceptance
In-Reply-To: <1117556283.2569.26.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10505311825010.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, Steven Rostedt wrote:

> On Tue, 2005-05-31 at 14:09 +0200, Esben Nielsen wrote:
> > On Tue, 31 May 2005, James Bruce wrote:
> 
> > > It is only better in that if you need provable hard-RT *right now*, then 
> > > you have to use a nanokernel.  
> > 
> > What do you mean by "provable"? Security critical? Forget about
> > nanokernels then. The WHOLE system has to be validated. If you want to a
> > system good enough to put (a lot of) money on it: Test, test, test.
> 
> Interesting. I use to work for Martin Mariette in the early 90s testing
> modules for aircraft engine controls.  The code was about ten years old,
> and that is because it was going under ten years of testing.  The
> operating system was custom made since at the time there were no
> commercially available (that I knew) RTOS that could go under the
> scrutiny of the Military Specs.
> 
> Later, while working at Lockheed, we had WindRiver over and they would
> only give a small broken down (basically all features removed) OS that
> Lockheed would be responsible for testing.

Exactly the point: Once you use some of their add-ons it is no
certified. This corresponds to use Linux in _any_  way - nano or preempt
RT.

> 
> When someone mentions Hard-RT, this is what I think about.  These are
> the RTOS that control the airplanes that people fly in. If something
> were to go wrong, people will die. 
 
Well, I consider "hard RT" as something where deadlines are mission
critical. Doesn't need to involve human lives. How secure you need to be
depends on the consequences.  
Where I work it boils down to that the system behaves the same in the real
world as in test. It is not that we can prove teoretically that we can
schedule but that we are confident that some new load we see when we go
out in the real world  doesn't dramatically alter our timing of our
critical tasks. But even with an RTOS that have indeed happened for us
because people have forgotten  stuff to use priority inheritance or
because a system call was blocking under special circumstances. 
For security critical stuff I am under the impression that the most
important stuff is to make a lot of paperwork such that if something goes
wrong no body can blame you....

> 
> I no longer deal with that type of RT, now I still work with
> applications that run on aircraft, but would not have the plane crash if
> something was to go wrong.  The system still had to be of a softer-RT to
> give the required response, usually navigational.  This is someplace
> that a Linux with -RT or a nano kernel can go.  The -RT patch may be
> nicer since some applications are first written generically, and then
> later need to become -RT for some reason or another.  With the nano
> approach this may take more effort.  But at the moment, I'm working to
> get -RT with some extra features for other things, but this is what I've
> heard from others.
> 
> > I can't see it would be easier prove that a nano-kernel with various
> > needed mutex and queuing mechanism works correct than it is to prove that
> > the Linux scheduler with mutex and queueing mechanisms works correctly.
> > Both systems does the same thing and is most likely based on the same
> > principles!
> 
> Since the nano-kernel would be much smaller than the kernel, you don't
> need to worry about a bad design as much that can cause a problem.  I
> don't know how easy it would be to separate all the paths that an RT
> task uses, and make sure that there's not a lock that an RT task takes
> that isn't taken someplace else that a non RT task can take for a long
> time (even with PI).  It's just that the kernel is so big to find
> everything.  This isn't impossible, but very difficult to check out.
> 
My point was that you have to consider the whole thing, nano + Linux
kernels. Anyplace where a irq_disable()/preempt_disable() is used you are
in trouble wrt. having RT at all. I can't see nano is dealing with it much
better than PREEMPT_RT is: Both replace spinlock's with something which
doesn't use those primitives.
As for local RT behaviour, i.e. making sure your tasks doesn't go into
non-RT locks, I agree that nano-kernels is easier as it is smaller. But as
soon as you start to make large applications emedding different
timescales, importings stacks from the outside you start to get
into similar troubles.

For me the solution is relatively clear in both cases : A static code
checkers marking calls safe/non-safe combined with expert knowledge about
the system.

> -- Steve
> 

Esben


