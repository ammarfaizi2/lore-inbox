Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288926AbSATTBj>; Sun, 20 Jan 2002 14:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSATTBa>; Sun, 20 Jan 2002 14:01:30 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:61451 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S288926AbSATTBR>;
	Sun, 20 Jan 2002 14:01:17 -0500
Date: Fri, 18 Jan 2002 23:41:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Preempt & how long it takes to interrupt (was Re: [2.4.17/18pre] VM and swap - it's really unusable)
Message-ID: <20020118224140.GI6918@elf.ucw.cz>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <3C42CA59.F070C2B8@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C42CA59.F070C2B8@aitel.hist.no>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I preempt leads to disaster than Linux can't do SMP.  Are you saying that's
> > the case?
> 
> There is a difference.  Preempt have the same locking requirements as
> SMP, but there's also _timing_ requirements.
...
> > The preempt patch is really "SMP on UP".  If pre-empt shows up a problem,
> > then it's a problem SMP users will see too.  If we can't take advantage of
> > the existing SMP locking infrastructure to improve latency and interactive
> > feel on UP machines, than SMP for linux DOES NOT WORK.
> 
> One example where preempt may break and SMP does not:
> 
> Consider driver code.  Critical data structures is protected by
> spinlocks,
> but some of the access to the hardware device itself is outside those
> locks (I can prove that the other processors can't get there with
> the driver in that state anyway)
> 
> Now, hardware access has timing requirements.  That works on SMP because
> you don't loose the CPU to anything but interrupts, and they are fast. 
> You get it back almost immediately.  The device in question times out
> after a much longer interval.

So... how long do you have to stay in interrupt for it to be a bug?

There's *no* requirement that says "it may not take second to handle
an interrupt". Actually I guess that some nasty conditions (UHCI needs
reset?) may take that long in interrupt. Oh and actually few releases
ago, console switching was done from interrupt and it *did* take 2
seconds for me.

If someone assumes interrupts are "short", he has broken code already.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
