Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTARNpL>; Sat, 18 Jan 2003 08:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTARNpL>; Sat, 18 Jan 2003 08:45:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12550 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264745AbTARNpK>; Sat, 18 Jan 2003 08:45:10 -0500
Date: Sat, 18 Jan 2003 14:54:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
Message-ID: <20030118135408.GA22669@atrey.karlin.mff.cuni.cz>
References: <200301180325.h0I3PGa07081@eng2.beaverton.ibm.com> <1042860792.32477.36.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042860792.32477.36.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hey! Hmm. Odd, this email never got to me directly, instead I found it
> through lkml. Hopefully my mail isn't bouncing somewhere...

ibm had some  mail problems --- nasty storm of bounces. I don'tknow if
it is related.


>  
> 
> >  > +static void delay_pit(unsigned long loops)
> >  > +{
> >  > +    int d0;
> >  > +    __asm__ __volatile__(
> >  > +            "\tjmp 1f\n"
> >  > +            ".align 16\n"
> >  > +            "1:\tjmp 2f\n"
> >  > +            ".align 16\n"
> >  > +            "2:\tdecl %0\n\tjns 2b"
> >  > +            :"=&a" (d0)
> >  > +            :"0" (loops));
> >  > +}
> >  > +
> >  
> >  But... this is not using pit to do the delay, right? It is sensitive
> >  to CPU clock changes, pit-delay should not be.
> 
> You're right, basically I took the previous __loop_delay() and
> __rtsc_delay() and moved them to delay_pit() and delay_tsc(),
> respectively. I guess the naming is somewhat confusing, but since this
> was meant as just a cleanup, I'm trying to use the same code in the same
> conditions.(ie: when using the PIT time-source, use the loop delay. when
> using the TSC time-source, use the TSC delay). A changing the name or a
> comment explaining it would def clear that up. 
> 
> You do bring up an interesting idea: actually using the PIT to do
> __delay. I think its possible, but not really worth it, as the PIT is
> such a nasty bit of hardware to deal with. I'd guess that just reading
> the PIT would likely delay for more time then what was actually
> requested.

Well, loop_delay() was big (fatal!) problem -- it can actaully wait
for *less* time than told to. That happens if notebook boots during
"battery low" and than goes to AC power. Thinkpad 560X is example of
such behaviour. Slow (but working!) PIT seems to be only option on
such machine.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
