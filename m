Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRDEWkP>; Thu, 5 Apr 2001 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRDEWkF>; Thu, 5 Apr 2001 18:40:05 -0400
Received: from [63.68.113.130] ([63.68.113.130]:5260 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S129143AbRDEWjx>;
	Thu, 5 Apr 2001 18:39:53 -0400
Date: Thu, 5 Apr 2001 15:38:41 -0700
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: wookie@osdlab.org
Subject: Re: a quest for a better scheduler
Message-ID: <20010405153841.A2452@osdlab.org>
In-Reply-To: <20010404151632.A2144@kochanski> <18230000.986424894@hellman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <18230000.986424894@hellman>; from x@xman.org on Wed, Apr 04, 2001 at 03:54:54PM -0700
From: "Timothy D. Witham" <wookie@osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I have been following this thread and thinking that everybody has some truth in
what they are saying but with the absence of a repeatable test environment there 
really isn't a way of arriving at a data driven decision.

Given the following conditions.

1)The diversity of the problem sets that developers are working on results in a
  real concern that another developers solution to their performance issue 
  might result in a worsening of my performance situation. 

2)Most of the developers have a given set of tests that they use when they
  make changes to determine if they change did what they want.

3)The Open Source Development Lab has the faculties for providing a large scale 
  testing environment on several different configurations that remain the same over 
  time. 

  I propose that we work on setting up a straight forward test harness that allows 
developers to quickly test a kernel patch against various performance yardsticks.
If we use the same set of hardware for the generation of the performance data 
from patch to patch there will be a correlation between the runs allowing for 
a real comparison of the different changes.

The following should be taken only as a starting point.

  As for the base hardware configurations I propose:
	2 way with 1 GB main memory and 2 IDE drives
	4 way with 4 GB main memory and 16 disk drives
	8 way with 8 GB main memory and 24 disk drives

  The types of applications that I have heard people express concern are:

	Web infrastructure: 
		Apache 
		TUX 
		Jabber

	Corporate infrastructure: 
		NFS 
		raw TCP/IP performance
		Samba 

	Database performance: 
		Raw storage I/O performance
		 OLTP workload

	General usage: 
		compile speed (usually measured by kernel compile)

   The OSDL also has the ability to make some of the "for fee" benchmarks
available for use for testing that is done onsite (network access to OSDL
machines counts as onsite) so that people don't have to purchase individual 
copies.  Things like SECMAIL2001, SPECSFS2.0 and SEPCWEB99 come to mind.

Comments, suggestions, volunteers?

-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2455     (fax)

On Wed, Apr 04, 2001 at 03:54:54PM -0700, Christopher Smith wrote:
> --On Wednesday, April 04, 2001 15:16:32 -0700 Tim Wright <timw@splhi.com> 
> wrote:
> > On Wed, Apr 04, 2001 at 03:23:34PM +0200, Ingo Molnar wrote:
> >> nope. The goal is to satisfy runnable processes in the range of NR_CPUS.
> >> You are playing word games by suggesting that the current behavior
> >> prefers 'low end'. 'thousands of runnable processes' is not 'high end'
> >> at all, it's 'broken end'. Thousands of runnable processes are the sign
> >> of a broken application design, and 'fixing' the scheduler to perform
> >> better in that case is just fixing the symptom. [changing the scheduler
> >> to perform better in such situations is possible too, but all solutions
> >> proposed so far had strings attached.]
> >
> > Ingo, you continue to assert this without giving much evidence to back it
> > up. All the world is not a web server. If I'm running a large OLTP
> > database with thousands of clients, it's not at all unreasonable to
> > expect periods where several hundred (forget the thousands) want to be
> > serviced by the database engine. That sounds like hundreds of schedulable
> > entities be they processes or threads or whatever. This sort of load is
> > regularly run on machine with 16-64 CPUs.
> 
> Actually, it's not just OLTP, anytime you are doing time sharing between 
> hundreds of users (something POSIX systems are supposed to be good at) this 
> will happen.
> 
> > Now I will admit that it is conceivable that you can design an
> > application that finds out how many CPUs are available, creates threads
> > to match that number and tries to divvy up the work between them using
> > some combination of polling and asynchronous I/O etc. There are, however
> > a number of problems with this approach:
> 
> Actually, one way to semi-support this approach is to implement 
> many-to-many threads as per the Solaris approach. This also requires 
> significant hacking of both the kernel and the runtime, and certainly is 
> significantly more error prone than trying to write a flexible scheduler.
> 
> One problem you didn't highlight that even the above case does not happily 
> identify is that for security reasons you may very well need each user's 
> requests to take place in a different process. If you don't, then you have 
> to implement a very well tested and secure user-level security mechanism to 
> ensure things like privacy (above and beyond the time-sharing).
> 
> The world is filled with a wide variety of types of applications, and 
> unless you know two programming approaches are functionaly equivalent (and 
> event driven/polling I/O vs. tons of running processes are NOT), you 
> shouldn't say one approach is "broken". You could say it's a "broken" 
> approach to building web servers. Unfortunately, things like kernels and 
> standard libraries should work well in the general case.
> 
> --Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2455     (fax)

