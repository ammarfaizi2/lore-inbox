Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbSLKQRl>; Wed, 11 Dec 2002 11:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSLKQRl>; Wed, 11 Dec 2002 11:17:41 -0500
Received: from ext-nj2gw-3.online-age.net ([216.35.73.165]:5014 "EHLO
	ext-nj2gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S267206AbSLKQRh>; Wed, 11 Dec 2002 11:17:37 -0500
Message-ID: <A9713061F01AD411B0F700D0B746CA68048955FA@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'george anzinger'" <george@mvista.com>, Dan Kegel <dkegel@ixiacom.com>
Cc: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       linux-kernel@vger.kernel.org
Subject: RE: [RFC] countdown timer driver
Date: Wed, 11 Dec 2002 11:25:04 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > > Questions:
> > > 1. Is there already a standard kernel interface to this 
> type of timer?
> > 
> > The Posix high-res timer stuff, I think.  Have you tried expressing
> > what you want user programs to do in terms of Posix 
> high-res timers yet?
> > 
> > > 2. Is there any reason to interface/integrate this type 
> of device with the
> > >    high-res timer stuff currently under development for 
> the 2.5 kernel?
> > 
> > Yes; perhaps you could create a service provider interface
> > for the posix high-res timer stuff, then use that SPI
> > to plug your hardware in?
> > 
> > I may be way off base here, but it does seem like it's due 
> dilligence
> > to verify that you're not reinventing an interface here.
> > - Dan
> > 
> Let me help out here if I may.  First, not to rain on your
> parade but, when I did high-res timers on another system,
> far away and long ago, we dropped support for the hardware
> timers.  I.e. I would submit that the POSIX timers interface
> to a common system timer does all you need and more.

I suspect that is most often the case. My task, working for an OEM,
is to provide access to the available hardware. The customer's decide
if the hardware is appropriate to their needs, and still many customers
are demanding access to these devices. I am going to try to do a study
on whether additional hardware timers are of any benefit given the
resources available on current standard hardware and the availability of
the high-res patch, but the additional hardware is probably still going
to be available because it is needed on others OS's.

> You MAY want to consider using your hardware as the system clock
> underlying jiffies and all the system timers, but that is
> another issue.
> 
> You also may want to define a new CLOCK for the POSIX
> timers.  Most of this capability is in place in the current
> patch.  I did notice, however, that I took a short cut on
> the clock_nanosleep code and assumed that it was a standard
> clock.  This is easy to change...   The new CLOCK(s) would
> then talk to your hardware.  The problem you will encounter,
> and which the high-res-patch solves, is making the timers
> available to all comers, i.e. there is no reservation system
> or busy counter, etc.  Just a nice set timer and give me a
> signal when it is done.
> 

Hmmm, that sounds promising.

> You can code a blocking interface using the sigwait and
> friends calls which will also cut down of the timer delivery
> overhead by eliminating the signal.

Very good.

> So what more could you ask for? 

I've already sent Santa my list.

Thanks for the advice.
