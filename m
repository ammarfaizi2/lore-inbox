Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSAUVTJ>; Mon, 21 Jan 2002 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSAUVTA>; Mon, 21 Jan 2002 16:19:00 -0500
Received: from zero.tech9.net ([209.61.188.187]:2321 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288374AbSAUVSw>;
	Mon, 21 Jan 2002 16:18:52 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020121095051.B14139@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com>
	<E16ShcU-0001ip-00@starship.berlin>  <20020121095051.B14139@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 16:22:58 -0500
Message-Id: <1011648179.850.473.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 11:50, yodaiken@fsmlabs.com wrote:
> On Mon, Jan 21, 2002 at 05:48:30PM +0100, Daniel Phillips wrote:

> > Consider a thread reading from disk in such a way that readahead is no help, 
> > i.e., perhaps the disk is fragmented.  At each step the IO thread schedules a 
> > read and sleeps until the read completes, then schedules the next one.  At 
> > the same time there is a hog in the kernel, or perhaps there is 
> > competition from other tasks using the kernel.  In any event, it will 
> > frequently transpire that at the time the disk IO completes there is somebody 
> > in the kernel.  Without preemption the IO thread has to wait until the kernel 
> > hog blocks, hits a scheduling point or exits the kernel.
> 
> 
> So your claim is that:
> 	Preemption improves latency when there are both kernel cpu bound
> 	tasks and tasks that are I/O bound with very low cache hit
> 	rates?
> 
> Is that it?
> 
> Can you give me an example of a CPU bound task that runs
> mostly in kernel? Doesn't that seem like a kernel bug?

It doesn't have to run mostly in the kernel.  It just has to be in the
kernel when the I/O-bound tasks awakes.  Further, there are plenty of
what we consider CPU-bound tasks that are interactive and/or
graphics-oriented and this adds much to their time in the kernel.

In a given period of time, a CPU bound task can run at any allotment
within it is given.  On the other hand, an I/O-bound task spends much
time blocked and thus can only run when I/O is available and it is
awake.  It is thus advantageous to schedule it within the bounds of the
I/O being available, and as tightly in those bounds as possible.  This
more fairly distributes scheduling to all tasks.  Same goes for RT
tasks, interactive tasks, etc.

The result is faster wake-up-to-run and thus higher throughput.  I just
sent some dbench scores to correlate this.

> I still keep missing these reports. Can you help me here?
> (Obviously "my laptop seems more effervescent" is not what I'm looking
>  for.)

While we certainly need tangible empirical benefits, users finding their
desktop experience smoother and thus more enjoyable is just about the
best thing we can ask for.

	Robert Love

