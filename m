Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265313AbSJRTcq>; Fri, 18 Oct 2002 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265314AbSJRTcq>; Fri, 18 Oct 2002 15:32:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265313AbSJRTco>; Fri, 18 Oct 2002 15:32:44 -0400
Date: Fri, 18 Oct 2002 15:38:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: variable HZ
In-Reply-To: <1034966657.722.838.camel@phantasy>
Message-ID: <Pine.LNX.3.95.1021018152117.150B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Oct 2002, Robert Love wrote:

> On Fri, 2002-10-18 at 07:51, Neil Conway wrote:
> 
> > I was looking at your jiffies_to_clock_t() macro, and I notice that it
> > will screw up badly if the user chooses a HZ value that isn't a multiple
> > of the normal value (e.g. 1000 is OK, 512 isn't).
> 
> OK, sure, but why specify a power-of-two HZ?  There is absolutely no
> reason to, at least on x86.
> 
> Want 512?  500 will do just as well and has the benefit of (a) being a
> multiple of the previous HZ and (b) evenly dividing into our concept of
> time.
> 
> 	Robert Love
> 

At least on ix86, HZ needs to be something that CLOCK_TICK_RATE/LATCH
comes out fairly close. Remember, LATCH is the divisor for the PIT
and that PIT gets CLOCK_TICK_RATE for its input. If this number isn't
fairly 'exact' there will be much jumping of time in the sawtooth
corrector.

If you are not using ELAN, CLOCK_TICK_RATE is 1193180. If your HZ is
100, you have 1193180/100 = 1193.18, not too exact. if you use
500, you get 1193180/500 = 2386.36 which has twice as much round-off.
If you use 1193180/512 = 2330.43, even a higher fractional part.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

