Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRDJOL0>; Tue, 10 Apr 2001 10:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDJOLR>; Tue, 10 Apr 2001 10:11:17 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:11788 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131899AbRDJOK6>; Tue, 10 Apr 2001 10:10:58 -0400
Date: Tue, 10 Apr 2001 16:10:28 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: David Schleef <ds@schleef.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410053105.B4144@stm.lbl.gov>
Message-ID: <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Note that you call mod_timer also on each packet received - and in worst
> > case (which may happen), you end up reprogramming the PIT on each packet.
> 
> This just indicates that the interface needs to be richer -- i.e.,
> such as having a "lazy timer" that means: "wake me up when _at least_
> N ns have elapsed, but there's no hurry."  If waking you up at N ns
> is expensive, then the wakeup is delayed until something else
> interesting happens.
> 
> This is effectively what we have now anyway.  Perhaps the
> current add_timer() should be mapped to lazy timers.

BTW. Why we need to redesign timers at all? The cost of timer interrupt
each 1/100 second is nearly zero (1000 instances on S/390 VM is not common
case - it is not reasonable to degradate performance of timers because of
this).

Timers more precise than 100HZ aren't probably needed - as MIN_RTO is 0.2s
and MIN_DELACK is 0.04s, TCP would hardly benefit from them.

Mikulas



