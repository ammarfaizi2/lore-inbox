Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283586AbRLXFk7>; Mon, 24 Dec 2001 00:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283592AbRLXFkt>; Mon, 24 Dec 2001 00:40:49 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:58641 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S283586AbRLXFkj>;
	Mon, 24 Dec 2001 00:40:39 -0500
Date: Sun, 23 Dec 2001 22:33:48 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, Mike Kravetz <kravetz@us.ibm.com>,
        Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011223223348.A20895@hq2>
In-Reply-To: <20011223171802.A19931@hq2> <Pine.LNX.4.40.0112231722260.971-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112231722260.971-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 05:31:11PM -0800, Davide Libenzi wrote:
> On Sun, 23 Dec 2001, Victor Yodaiken wrote:
> 
> >
> >
> > Run a "RT"  task that is scheduled   every millisecond (or time of your
> > choice)
> > 	while(1`){
> > 		read cycle timer
> > 		clock_nanosleep(time period using aabsolute time
> > 		read cycle timer - what was actual delay? track worst
> > 			case
> > 		}
> >
> > Run this
> > 	a) on aaaaaaaaan unstressed system
> > 	b) under stress
> > 	c) while a timed non-rt benchmark runs to figure out "RT"
> > 	overhead.
> 
> I've coded a test app that uses the LatSched latency patch ( that uses
> rdtsc ).
> It basically does 1) set the current process priority to RT 2) an ioctl()
> to activate the scheduler latency sampler 3) sleep for 1-2 secs 4) ioctl()
> to stop the sampler 5) peek the sample with pid == getpid().
> In this way i get the net RT task scheduler latency. Yes it does not get
> the real one that includes accessories kernel paths but my code does not
> affect these ones. And they add noise to the measure.


Seems to me that you are not testing what apps see. Internal benchmarks
are useful only for figuring out how to remove bottlenecks that 
effect actual user apps - in my humble opinion of course.
The nice thing about my benchmark is that it actually tests something
useful - how well you can do periodic tasks. BTW, on RTLinux we get 
under 100 microseconds on even 50Mhzx PPC860 - 17us on a 800Mhz K7.
I'd be happy to see some decent numbers in Linux, but you gotta 
measure something more applied. 

> 
> 
> 
> 
> - Davide
> 
