Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUCVM2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUCVM23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:28:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:34178 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261907AbUCVM21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:28:27 -0500
Date: Mon, 22 Mar 2004 07:29:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Jamie Lokier <jamie@shareable.org>, Robert_Hentosh@Dell.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious 8259A interrupt
In-Reply-To: <200403211858.07445.hpj@urpla.net>
Message-ID: <Pine.LNX.4.53.0403220713160.13879@chaos>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
 <20040319130609.GE2650@mail.shareable.org> <Pine.LNX.4.53.0403190825070.929@chaos>
 <200403211858.07445.hpj@urpla.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004, Hans-Peter Jansen wrote:

> On Friday 19 March 2004 14:48, Richard B. Johnson wrote:
> >
> > The IRQ7 spurious is usually an artifact of a crappy motherboard
> > design where the CPU "thinks" it was interrupted, but the
> > controller didn't wiggle the CPUs INT line.
>
> Thanks for the nice explanation, Richard.
>
> I even see them on my x86_64 box in 64 bit mode. (K8VT800 based)
> Furtunately only occasionally.
>
> I thought, AMD took the chance to fix that kind of crap in the new
> architecture, but obviously they failed in this respect :-(
>
> Pete

It isn't CPU-specific. It's motherboard glitch specific. If there
is ground-bounce on the motherboard or excessive induced
coupling, the CPU may occasionally get hit with a logic-level
that it "thinks" is an interrupt, even though no controller
actually generated it. Sometimes you can find a power supply
that helps. Power supplies can cause such problems if
a dynamic load (from the CPU executing some variable-load
pattern), coincides with some not-to-well damped pole in
the power-supply regulator feedback. This can cause a
periodic bounce (like 100 HZ) that causes logic levels
to go into and out of spec during certain execution
sequences. This can cause actual triggers to be sent
to the CPUs maskable and non-maskable interrupt pins.
Since the CPUs now-days have multiple levels of regulators,
their voltages are relatively constant. This means their
response to input logic levels won't track with something
tied only to the primary regulator in the cheapie power
supply.

In any event, spurious interrupts are hardware events,
not software. If you don't get too many of them they
are not bothersome and might even be called "normal".


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


