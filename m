Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315877AbSEGPm2>; Tue, 7 May 2002 11:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315876AbSEGPm1>; Tue, 7 May 2002 11:42:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47232 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315871AbSEGPmZ>; Tue, 7 May 2002 11:42:25 -0400
Date: Tue, 7 May 2002 11:44:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Samuel Maftoul <maftoul@esrf.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
In-Reply-To: <20020507170621.A3155@pcmaftoul.esrf.fr>
Message-ID: <Pine.LNX.3.95.1020507111647.7166A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Samuel Maftoul wrote:

> On Tue, May 07, 2002 at 10:53:16AM -0400, Richard B. Johnson wrote:
> > On Tue, 7 May 2002, Paul Jakma wrote:
> > 
> >                  Windows-2000/Professional isn't.
[SNIPPED..]

> I have the same message but only when I'm using my ieee-1394 devices (
> firewire ) .
> I copy from NFS to ieee-1394 HD and approximatively at 256 meg of copied
> data from network I have the message (wait_for_cmd_timeout), and I'm not
> able use the network, nor the mounted HD.
> 
> I need to say the system is running 2.4.18 SMP ( 2 proc ) with 2go of
> RAM (higmeme 4-GB from suse ) ( It's a scientific data analysis and extraction system ).
> 
> What should I do ? 
> Should I remove the code you told me to remove

No. I told someone to comment out a call to wait_for_cmd_timeout() in
a procedure where this generates spurious (incorrect) warning messages.

You are probably getting real errors (the chip stops) when its interrupts
can't be handled quickly enough.

This may be because the firewire driver may be looping in its ISR.
Typically, when drivers don't play together very well, it's because one
or both of the drivers were written by people who didn't learn how to play
together as children. ^;) "It's my CPU (baseball). I'm going to keep it as
long as I want...."   

In 100% of the cases where I have been asked to help fix these kinds of
problems, getting rid of the loops in ISRs fixes the problems forever.
Yes, I know about "interrupt mitigation...", but what's the use of
maximizing driver throughput if the computer won't work?

The fixes to lots of chip drivers that hang and lock-up won't
happen until schools start teaching future software engineers to
play together as children. Until that time, you can probably fix
your particular drivers by getting rid of those loops in the ISRs.

A quick-fix, just to prove it to yourself, is to set the loop-counter
(max_interrupt_work in eepro100.c) to 1. You need to do this in
the fire-wire driver also, but that's not as simple, several drivers
do "while something()" in the interrupt routines. That something()
may be true for a very long time, using CPU cycles that your net-card
really needs.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

