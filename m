Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbRGOJGC>; Sun, 15 Jul 2001 05:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRGOJFv>; Sun, 15 Jul 2001 05:05:51 -0400
Received: from ns.suse.de ([213.95.15.193]:7686 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265972AbRGOJFm>;
	Sun, 15 Jul 2001 05:05:42 -0400
Date: Sun, 15 Jul 2001 11:05:43 +0200
From: Andi Kleen <ak@suse.de>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Mike Kravetz <mkravetz@sequent.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Message-ID: <20010715110543.A9981@gruyere.muc.suse.de>
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com> <20010715024255.F3965@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010715024255.F3965@altus.drgw.net>; from hozer@drgw.net on Sun, Jul 15, 2001 at 02:42:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 02:42:55AM -0500, Troy Benjegerdes wrote:
> On Thu, Jul 12, 2001 at 04:40:17PM -0700, Mike Kravetz wrote:
> > This discussion was started on 'lse-tech@lists.sourceforge.net'.
> > I'm widening the distribution in the hope of getting more input.
> > 
> > It started when Andi Kleen noticed that a single 'CPU Hog' task
> > was being bounced back and forth between the 2 CPUs on his 2-way
> > system.  I had seen similar behavior when running the context
> > switching test of LMbench.  When running lat_ctx with only two
> > threads on an 8 CPU system, one would ?expect? the two threads
> > to be confined to two of the 8 CPUs in the system.  However, what
> > I have observed is that the threads are effectively 'round
> > robined' among all the CPUs and they all end up bearing
> > an equivalent amount of the CPU load.  To more easily observe
> > this, increase the number of 'TRIPS' in the benchmark to a really
> > large number.
> 
> Did this 'CPU Hog' task do any I/O that might have caused an interrupt?

Yes; it did some IO, but most of its time was doing CPU work
(it was CPU bound)

> 
> I'm wondering if the interrupt distribution has anything to do with this.. 
> are you using any CPU affinity for interrupts? If not, this might explain 
> why the processes wind up doing a 'round robin'.

It was a normal Intel SMP box with no special settings and the interrupts
should have been evenly distributed (I did not check it at this time, but
normally they are about evenly distributed over the two cpus)


> 
> I'm trying to reproduce this with gzip on a dual Mac G4, and I'm wondering
> if this will be scewed any because all interrupts are directed at cpu0, so
> anything that generates input or output on the network or serial is going
> to tend to wind up on cpu0.
> 
> I'd also like to figure out what th e IPI latency actually is.. Does anyone
> have any suggestions how to measure this? I would hope it's lower on the
> dual 7410 machine I have since I have 4-stage pipelines as opposed to 20
> odd stages that Pentium III class machines do..

I'm not sure about the Mac, but on x86 linux boxes the SMP bootup synchronizes
the time stamp counters of the CPUs. If they are synchronized on your box
also you could store TSC value in the IPI sender and compute the average
latency in the receiver. 


-Andi
