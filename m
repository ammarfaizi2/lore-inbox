Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSGFTof>; Sat, 6 Jul 2002 15:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSGFToe>; Sat, 6 Jul 2002 15:44:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8210 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313687AbSGFToc>; Sat, 6 Jul 2002 15:44:32 -0400
Date: Sat, 6 Jul 2002 21:47:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Phillips <phillips@arcor.de>
Cc: Stephen Tweedie <sct@redhat.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020706194711.GE21070@atrey.karlin.mff.cuni.cz>
References: <20020702123718.A4711@redhat.com> <20020703234750Z16173-11563+874@humbolt.nl.linux.org> <20020705104049.H27198@redhat.com> <E17QvQ4-0001TZ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17QvQ4-0001TZ-00@starship>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm assuming for the sake of argument that we're requiring the use count to 
> be incremented for any call outside the module, a rule we might want anyway, 
> since it is less fragile than the no-sleeping rule.
> 
> > the module has taken an interrupt into an unrelated driver;
> 
> With Ben's new separate interrupt stacks the current IP would be available at 
> a known place at the base of the interrupt stack.
> 
> > we have computed a call into the module but haven't actually executed
> > the call yet;
> 
> This one is problematic, and yes, I now agree the problem is hard. This is 
> where Keith's handwaving comes in: we are supposed to have deregistered the 
> module's services and ensured all processes are out of the module at this 
> point.  I don't know how that helps, really.  I just want to note that this 
> seems to be the only really hard problem.  It's not insoluable though: going 
> to extremes we could record each region of code from which module calls 
> originate and check for execution addresses in that region, along with 
> execution addresses in the module.  Picking up the call address would have to 
> be an atomic read.  You don't have to tell me this is ugly and slow, but it 
> would work.

freeze_processes(), and now you know that rmmod is only runnable job
on the system [approximately; you'd have to audit all threads marked
as non-stoppable]. So... if rmmod() does not do any computed calls to
module being removed, noone is doing that and all is safe.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
