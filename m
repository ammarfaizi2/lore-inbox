Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288794AbSANFhi>; Mon, 14 Jan 2002 00:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSANFhT>; Mon, 14 Jan 2002 00:37:19 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:42002 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288799AbSANFhQ>;
	Mon, 14 Jan 2002 00:37:16 -0500
Date: Sun, 13 Jan 2002 22:34:38 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113223438.A19324@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org> <20020113153602.GA19130@fenrus.demon.nl> <E16PzHb-00006g-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16PzHb-00006g-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 14, 2002 at 06:03:43AM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:03:43AM +0100, Daniel Phillips wrote:
> On January 13, 2002 04:36 pm, Arjan van de Ven wrote:
> > On Sun, Jan 13, 2002 at 04:18:29PM +0100, Roman Zippel wrote:
> > 
> > > What somehow got lost in this discussion, that both patches don't
> > > necessarily conflict with each other, they both attack the same problem
> > > with different approaches, which complement each other. I prefer to get
> > > the best of both patches.
> > 
> > If you do this (and I've seen the results of doing both at once vs only
> > either of then vs pure) then there's NO benifit for the preemption left.
> 
> Sorry, that's incorrect.  I stated why earlier in this thread and akpm signed 
> off on it.  With preempt you get ASAP (i.e., as soon as the outermost 
> spinlock is done) process scheduling.  With hand-coded scheduling points you 
> get 'as soon as it happens to hit a scheduling point'.
> 
> That is not the only benefit, just the most obvious one.

My understanding of this situation is as follows:
	The pure preempt measurements show some improvement on synthetic
	latency benchmarks that have not been shown to have any relationship
	to any real application

	The LL measurements show _better_ results on similar benchmarks.

	Some people find preempt improves "feel"
	Some people find LL improves "feel"

	The interactions of these improvements with Ingos scheduler, aa mm, and
	other recent patches are exceptionally murky

	We have one benchmark that shows that kernel compiles run on different 
	untarred trees show a slight advantage for preempt+Ingo via some
	unknown mechanism. This benchmark, aside from its dubious repeatability 
	tests something that seems to have no relationship to _anything_  at all
	by running a huge number of compile processes.

	Nobody has answered my question about the conflict between SMP per-cpu caching
	and preempt. Since NUMA is apparently the future of MP in the PC world and
	the future of Linux servers, it's interesting to consider this tradeoff.
	
	Nobody has answered the question about how to make sure all processes
	make progress with preempt.

	Nobody has offered a single benchmark of actual application code benefits
	from either preempt or LL.

	Nobody has clearly explained how to avoid what I claim to be the inevitable 
	result of preempt -- priority inheritance locks (not just semaphores).
	What we have is some "we'll figure that out when we get to it".

	It's not even clear how preempt is supposed to interact with SCHED_FIFO.


As far as your "most obvious" "benefit". It's neither obvious that it happens
or obvious that it is a benefit.  According to the measurements I've seen, Andrew
reduces latency _more_ than preempt. Andrews argument, as I understand it, is that
the longest latencies are within spinlocks anyways so increasing speed of preempt
outside those locks misses the problem. If he is correct, then if you are correct,
it doesn't matter - preempt is reducing already short latencies. 

BTW: there is a detailed explanation of how priority inherit works in Solaris in the
UNIX Internals book. It's worth reading and thinking about.

I'm not at all sure that putting preempt into 2.5 is a bad idea. I think that 2.4
has a long lifetime ahead of it and the debacle that will follow putting preempt into 2.5
will eventually discredit the entire idea for at least a year or two.
But
I think that there are some much more important scheduling issues that are being ignored to
"improve the feel" of DVD playing. The key one is some idea of being able to assure processes
of some rate of progress.  This is not classical RT, but it is important to multimedia and 
databases and also to some applications we are interested in looking at. 




---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

