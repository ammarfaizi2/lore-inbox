Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317961AbSGLBHN>; Thu, 11 Jul 2002 21:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317962AbSGLBHM>; Thu, 11 Jul 2002 21:07:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60924 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317961AbSGLBHL>;
	Thu, 11 Jul 2002 21:07:11 -0400
Message-ID: <3D2E2C48.DCB509D7@mvista.com>
Date: Thu, 11 Jul 2002 18:09:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stevie O <oliver@klozoff.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi> <5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stevie O wrote:
> 
> At <time> <date>, <user> [<email>] wrote:
> > <stuff>
> 
> A lot of people are talking about how HZ needs to be a constant, etc.
> 
> I don't do much kernel hacking, so allow me to post a query that would (probably) better belong on #kernelnewbies if I wasn't so damn lazy ;) --
> 
> Why must HZ be the same as 'interrupts per second'?

Well, in truth it has nothing to do with interrupts.  It is
just that that is the way most systems keep time.  The REAL
definition of HZ is in its relationship to jiffies and
seconds.  

I.e. jiffies * HZ = seconds, by definition.  

Then we define interfaces that promise to return so many
jiffies from now and we keep execution time and time slice
times in jiffies.  In order to keep these things true, it is
usual to set up some sort of timer to interrupt once each
jiffie.  Now we can actually do this two ways.  We can say
that the interrupt is a reminder to look at a "reliable
clock" and update the system time with what we find OR we
can use the interrupt to actually drive the system time. 
The former is the more accurate way of doing things as it
eliminates interrupt latency.  It also allows us to use a
more sloppy source of interrupts since they are just
reminders to check a clock and not actually driving the
clock.  This, by the way, is what the high-res-timers patch
does.  Doing things this way also allows one to reprogram
the timer interrupt hardware with out worrying too much
about loosing track of time.  The HRT patch does this to
generate interrupts at sub jiffie intervals, but only when
required.

-g
> 
> --
> Stevie-O
> 
> Real programmers link their executables by hand.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
