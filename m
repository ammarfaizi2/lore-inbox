Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286124AbSALMbK>; Sat, 12 Jan 2002 07:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286127AbSALMau>; Sat, 12 Jan 2002 07:30:50 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:49681 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S286124AbSALMal>;
	Sat, 12 Jan 2002 07:30:41 -0500
Date: Sat, 12 Jan 2002 05:28:02 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Rob Landley <landley@trommello.org>,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112052802.A3734@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C4023A2.8B89C278@linux-m68k.org>; from zippel@linux-m68k.org on Sat, Jan 12, 2002 at 12:53:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 12:53:06PM +0100, Roman Zippel wrote:
> Hi,
> 
> yodaiken@fsmlabs.com wrote:
> 
> > I believe that the preempt path leads inexorably to
> > mutex-with-stupid-priority-trick and that would be very unfortunate indeed.
> > It's unavoidable because sooner or later someone will find that preempt +
> > SCHED_FIFO leads to
> >                 niced app 1 in K mode gets Sem A
> >                 SCHED_FIFO app prempts and blocks on  Sem A
> >                 whoops! app 2 in K more preempts niced app 1
> 
> Please explain what's different without the preempt patch.

See that "preempt" in line 2 . Linux does not
preempt kernel mode processes otherwise. The beauty of the
non-preemptive kernel is that "in K mode every process makes progress"
and even the "niced app" will complete its use of SemA and 
release it in one run. If you have a reasonably fair scheduler you
can make very useful analysis with Linux now of the form

	Under 50 active proceses in the system means that in every
	2 second interval every process
	will get at least 10ms of time to run.

That's a very valuable property and it goes away in a preemptive kernel 
to get you something vague.


> 
> >         Hey my DVD player has stalled, lets add sem_with_revolting_priority_trick!
> >         Why the hell is UP Windows XP3 blowing away my Linux box on DVD playing while
> >         Linux now runs with the grace and speed of IRIX?
> 
> Because the IRIX implementation sucks, every implementation has to suck?
> Somehow I have the suspicion you're trying to discourage everyone from
> even trying, because if he'd succeeded you'd loose a big chunk of
> potential RTLinux customers.

So your argument is that I'm advocating Andrew Morton's patch which 
reduces latencies more than the preempt patch because I have a
financial interest in not reducing latencies? Subtle.

In any case, motive has no bearing on a technical argument. 
Your motive could be to make the 68K look better by reducing 
performance on other processors for all I know. 

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

