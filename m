Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRDJMFI>; Tue, 10 Apr 2001 08:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRDJME7>; Tue, 10 Apr 2001 08:04:59 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:51206 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131562AbRDJMEo>; Tue, 10 Apr 2001 08:04:44 -0400
Date: Tue, 10 Apr 2001 14:04:17 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: David Schleef <ds@schleef.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410044336.A1934@stm.lbl.gov>
Message-ID: <Pine.LNX.3.96.1010410135540.17123B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Its worth doing even on the ancient x86 boards with the PIT.
> > > 
> > > Note that programming the PIT is sloooooooow and doing it on every timer
> > > add_timer/del_timer would be a pain.
> > 
> > You only have to do it occasionally.
> > 
> > When you add a timer newer than the current one 
> > 	(arguably newer by at least 1/2*HZ sec)
> > When you finish running the timers at an interval and the new interval is
> > significantly larger than the current one.
> > 
> > Remember each tick we poke the PIT anyway
> 
> Reprogramming takes 3-4 times as long.  However, I still agree
> it's a good idea.

Adding and removing timers happens much more frequently than PIT tick, so
comparing these times is pointless.

If you have some device and timer protecting it from lockup on buggy
hardware, you actually

send request to device
add timer

receive interrupt and read reply
remove timer

With the curent timer semantics, the cost of add timer and del timer is
nearly zero. If you had to reprogram the PIT on each request and reply, it
would slow things down. 

Note that you call mod_timer also on each packet received - and in worst
case (which may happen), you end up reprogramming the PIT on each packet.

Mikulas

