Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288593AbSAUVz1>; Mon, 21 Jan 2002 16:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSAUVzP>; Mon, 21 Jan 2002 16:55:15 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:20240 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288511AbSAUVzI>;
	Mon, 21 Jan 2002 16:55:08 -0500
Date: Mon, 21 Jan 2002 14:54:38 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121145438.B18422@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <E16ShcU-0001ip-00@starship.berlin> <20020121095051.B14139@hq.fsmlabs.com> <1011648179.850.473.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1011648179.850.473.camel@phantasy>; from rml@tech9.net on Mon, Jan 21, 2002 at 04:22:58PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 04:22:58PM -0500, Robert Love wrote:
> On Mon, 2002-01-21 at 11:50, yodaiken@fsmlabs.com wrote:
> > On Mon, Jan 21, 2002 at 05:48:30PM +0100, Daniel Phillips wrote:
> 
> > > Consider a thread reading from disk in such a way that readahead is no help, 
> > > i.e., perhaps the disk is fragmented.  At each step the IO thread schedules a 
> > > read and sleeps until the read completes, then schedules the next one.  At 
> > > the same time there is a hog in the kernel, or perhaps there is 
> > > competition from other tasks using the kernel.  In any event, it will 
> > > frequently transpire that at the time the disk IO completes there is somebody 
> > > in the kernel.  Without preemption the IO thread has to wait until the kernel 
> > > hog blocks, hits a scheduling point or exits the kernel.
> > 
> > 
> > So your claim is that:
> > 	Preemption improves latency when there are both kernel cpu bound
> > 	tasks and tasks that are I/O bound with very low cache hit
> > 	rates?
> > 
> > Is that it?
> > 
> > Can you give me an example of a CPU bound task that runs
> > mostly in kernel? Doesn't that seem like a kernel bug?
> 
> It doesn't have to run mostly in the kernel.  It just has to be in the
> kernel when the I/O-bound tasks awakes.  Further, there are plenty of

How does that work? Won't the switch happen on exit from the kernel?

> what we consider CPU-bound tasks that are interactive and/or
> graphics-oriented and this adds much to their time in the kernel.

I'm not sure what an "interactive and/or graphics-oriented" CPU bound
task might be. Is there a definition?

> In a given period of time, a CPU bound task can run at any allotment
> within it is given.  On the other hand, an I/O-bound task spends much
> time blocked and thus can only run when I/O is available and it is
> awake.  It is thus advantageous to schedule it within the bounds of the
> I/O being available, and as tightly in those bounds as possible.  This
> more fairly distributes scheduling to all tasks.  Same goes for RT
> tasks, interactive tasks, etc.

So you think of an "I/O bound task" as  "an I/O bound task that spends
most of its timeblocked". Won't the latencies of such tasks already be
pretty high? I'd think that better caching and read-ahead is the correct
fix.


> The result is faster wake-up-to-run and thus higher throughput.  I just
> sent some dbench scores to correlate this.
> 
> > I still keep missing these reports. Can you help me here?
> > (Obviously "my laptop seems more effervescent" is not what I'm looking
> >  for.)
> 
> While we certainly need tangible empirical benefits, users finding their
> desktop experience smoother and thus more enjoyable is just about the
> best thing we can ask for.

It depends on what you want. 

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

