Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbRLXAZO>; Sun, 23 Dec 2001 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284272AbRLXAZE>; Sun, 23 Dec 2001 19:25:04 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:36113 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S284280AbRLXAYx>;
	Sun, 23 Dec 2001 19:24:53 -0500
Date: Sun, 23 Dec 2001 17:18:02 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011223171802.A19931@hq2>
In-Reply-To: <87y9jxzg5q.fsf@fadata.bg> <Pine.LNX.4.40.0112201453390.1622-100000@blue1.dev.mcafeelabs.com> <20011221090014.A1103@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221090014.A1103@w-mikek2.des.beaverton.ibm.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Run a "RT"  task that is scheduled   every millisecond (or time of your
choice)
	while(1`){
		read cycle timer
		clock_nanosleep(time period using aabsolute time
		read cycle timer - what was actual delay? track worst
			case
		}

Run this 
	a) on aaaaaaaaan unstressed system
	b) under stress
	c) while a timed non-rt benchmark runs to figure out "RT" 
	overhead.


On Fri, Dec 21, 2001 at 09:00:15AM -0800, Mike Kravetz wrote:
> On Thu, Dec 20, 2001 at 02:57:55PM -0800, Davide Libenzi wrote:
> > On 21 Dec 2001, Momchil Velikov wrote:
> > >
> > > I'd like to second that, IMHO the RT task scheduling should trade
> > > throughput for latency, and if someone wants priority inversion, let
> > > him explicitly request it.
> > 
> > No a great performance loss anyway. It's zero performance loss if the CPU
> > that has ran the woke up RT task for the last time is not running another
> > RT task ( very probable ). If the last CPU of the woke up task is running
> > another RT task a CPU discovery loop ( like the current scheduler ) must
> > be triggered. Not a great deal anyway.
> 
> Some time back, I asked if anyone had any RT benchmarks and got
> little response.  Performance (latency) degradation for RT tasks
> while implementing new schedulers was my concern.  Does anyone
> have ideas about how we should measure/benchmark this?  My
> 'solution' at the time was to take a scheduler heavy benchmark
> like reflex, and simply make all the tasks RT.  This wasn't very
> 'real world', but at least it did allow me to compare scheduler
> overhead in the RT paths of various scheduler implementations.
> 
> -- 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
