Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbSLKAMF>; Tue, 10 Dec 2002 19:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbSLKAMF>; Tue, 10 Dec 2002 19:12:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16124 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266805AbSLKAMD>;
	Tue, 10 Dec 2002 19:12:03 -0500
Message-ID: <3DF68487.168BEA99@mvista.com>
Date: Tue, 10 Dec 2002 16:19:19 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dkegel@ixiacom.com>
CC: Daniel.Heater@gefanuc.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] countdown timer driver
References: <3DF54765.2020505@ixiacom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> 
> > Questions:
> > 1. Is there already a standard kernel interface to this type of timer?
> 
> The Posix high-res timer stuff, I think.  Have you tried expressing
> what you want user programs to do in terms of Posix high-res timers yet?
> 
> > 2. Is there any reason to interface/integrate this type of device with the
> >    high-res timer stuff currently under development for the 2.5 kernel?
> 
> Yes; perhaps you could create a service provider interface
> for the posix high-res timer stuff, then use that SPI
> to plug your hardware in?
> 
> I may be way off base here, but it does seem like it's due dilligence
> to verify that you're not reinventing an interface here.
> - Dan
> 
Let me help out here if I may.  First, not to rain on your
parade but, when I did high-res timers on another system,
far away and long ago, we dropped support for the hardware
timers.  I.e. I would submit that the POSIX timers interface
to a common system timer does all you need and more.  You
MAY want to consider using your hardware as the system clock
underlying jiffies and all the system timers, but that is
another issue.

You also may want to define a new CLOCK for the POSIX
timers.  Most of this capability is in place in the current
patch.  I did notice, however, that I took a short cut on
the clock_nanosleep code and assumed that it was a standard
clock.  This is easy to change...   The new CLOCK(s) would
then talk to your hardware.  The problem you will encounter,
and which the high-res-patch solves, is making the timers
available to all comers, i.e. there is no reservation system
or busy counter, etc.  Just a nice set timer and give me a
signal when it is done.

You can code a blocking interface using the sigwait and
friends calls which will also cut down of the timer delivery
overhead by eliminating the signal.

So what more could you ask for? 
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
