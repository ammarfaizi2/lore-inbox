Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280479AbRKXXYG>; Sat, 24 Nov 2001 18:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280494AbRKXXX7>; Sat, 24 Nov 2001 18:23:59 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:32057 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S280479AbRKXXXs>; Sat, 24 Nov 2001 18:23:48 -0500
Message-Id: <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 24 Nov 2001 15:23:30 -0800
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@concentric.net>
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <9tp6tg$mge$1@cesium.transmeta.com>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
 <20011124103642.A32278@vega.ipal.net>
 <20011124184119.C12133@emma1.emma.line.org>
 <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:28 PM 11/24/01 -0800, H. Peter Anvin wrote:
> > > However, if it's really true that DTLA drives and their successor
> > > corrupt blocks (generate bad blocks) on power loss during block writes,
> > > these drives are crap.
> >
> > They do, even IBM admits that (on
> >
> >         http://www.cooling-solutions.de/dtla-faq
> >
> > you find a quote from IBM confirming this).  IBM says it's okay, you
> > have to expect this to happen.  So much for their expertise in making
> > hard disks.  This makes me feel rather dizzy (lots of IBM drives in
> > use).
> >
>
>No sh*t.  I have always been favouring IBM drives, and I had a RAID
>system with these drives bought.  It will be a LONG time before I buy
>another IBM drive, that's for sure.  I can't believe they don't even
>have the decency of saying "we fucked".

It is the responsibility of the power monitor to detect a power-fail event 
and tell the drive(s) that a power-fail event is occurring.  If power goes 
out of specification before the drive completes a commanded write, what do 
you expect the poor drive to do?  ANY glitch in the write current will 
corrupt the current block no matter what -- the final CRC isn't 
recorded.  Most drives do have a panic-stop mode when they detect voltage 
going out of range so as to minimize the damage caused by an 
out-of-specification power-down event, and more importantly use the energy 
in the spinning platter to get the heads moved to a safe place before the 
drive completely spins down.  The panic-stop mode is EXACTLY like a Linux 
OOPS -- it's a catastrophic event that SHOULD NOT OCCUR.

Most power supplies are not designed to hold up for more than 30-60 ms at 
full load upon removal of mains power.  Power-fail detect typically 
requires 12 ms (three-quarters cycle average at 60 Hz) or 15 ms 
(three-quarters cycle average at 50 Hz) to detect that mains power has 
failed, leaving your system a very short time to abort that long queue of 
disk write commands.  It's very possible that by the time the system wakes 
up to the fact that its electron feeding tube is empty it has already 
started a write operation that cannot be completed before power goes out of 
specification.  It's a race condition.

Fix your system.

If you don't have a UPS on that RAID, and some means of shutting down the 
RAID gracefully when mains power goes, you are sealing your own doom, 
regardless of the maker of the hard drive you use in that RAID.  Even the 
original CDC disk drives, some of the best damn drives ever manufactured in 
the world, would corrupt data when power failed during a write.

Satch



