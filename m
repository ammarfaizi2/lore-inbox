Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDJLof>; Tue, 10 Apr 2001 07:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDJLo0>; Tue, 10 Apr 2001 07:44:26 -0400
Received: from stm.lbl.gov ([131.243.16.51]:10757 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S131497AbRDJLoK>;
	Tue, 10 Apr 2001 07:44:10 -0400
Date: Tue, 10 Apr 2001 04:43:36 -0700
From: David Schleef <ds@schleef.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410044336.A1934@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <Pine.LNX.3.96.1010410002852.4212A-100000@artax.karlin.mff.cuni.cz> <E14mkGA-000341-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14mkGA-000341-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 09, 2001 at 11:35:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 11:35:44PM +0100, Alan Cox wrote:
> > > Its worth doing even on the ancient x86 boards with the PIT.
> > 
> > Note that programming the PIT is sloooooooow and doing it on every timer
> > add_timer/del_timer would be a pain.
> 
> You only have to do it occasionally.
> 
> When you add a timer newer than the current one 
> 	(arguably newer by at least 1/2*HZ sec)
> When you finish running the timers at an interval and the new interval is
> significantly larger than the current one.
> 
> Remember each tick we poke the PIT anyway

Reprogramming takes 3-4 times as long.  However, I still agree
it's a good idea.

RTAI will run the 8254 timer in one-shot mode if you ask it to.
However, on machines without a monotonically increasing counter,
i.e., the TSC, you have to use 8254 timer 0 as both the timebase
and the interval counter -- you end up slowly losing time because
of the race condition between reading the timer and writing a
new interval.  RTAI's solution is to disable kd_mksound and
use timer 2 as a poor man's TSC.  If either of those is too big
of a price, it may suffice to report that the timer granularity
on 486's is 10 ms.

It would be nice to see any redesign in this area make it more
modular.  I have hardware that would make it possible to slave
the Linux system clock directly off a high-accuracy timebase,
which would be super-useful for some applications.  I've been
doing some of this already, both as a kernel patch and as part
of RTAI; search for 'timekeeper' in the LKML archives if interested.




dave...

