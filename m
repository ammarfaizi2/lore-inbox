Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUBQOjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUBQOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:39:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266220AbUBQOjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:39:18 -0500
Date: Tue, 17 Feb 2004 09:39:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Carl Thompson <cet@carlthompson.net>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
In-Reply-To: <20040217061400.z9r4gss0gsockws4@carlthompson.net>
Message-ID: <Pine.LNX.4.53.0402170927330.912@chaos>
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
 <200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040216231401.3ig4kksk4k8g8440@carlthompson.net>
 <200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040217061400.z9r4gss0gsockws4@carlthompson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux interrupt code does shared interrupts fine.
There may be a bad driver so you need to find which
one it is and contact its author. There are still
entirely too many drivers that loop in the ISR, ...
so-called "interrupt mitigation"... If you are
using one such creation, find the loop terminating
variable and squash it to where it will not loop.
Magically, everything will start to work and share
wonderfully.

There is a big difference between maximizing the through-put
of a device and getting all devices to play nicely together.
Often device-driver writers think only of their hardware and
don't bother to think about the consequences of keeping
the CPU practically forever. For instance, a network card
will probably always have new packets available on an active
network. If you loop to get them all, you loop forever.

On Tue, 17 Feb 2004, Carl Thompson wrote:

> Quoting vda <vda@port.imtp.ilyichevsk.odessa.ua>:
>
> > On Tuesday 17 February 2004 09:14, Carl Thompson wrote:
> >> Quoting vda <vda@port.imtp.ilyichevsk.odessa.ua>:
> >> > ...
> >> >
> >> > Your box share IRQs in a big way :)
> >>
> >> Your point?
> >
> > While shared interrupts can in theory work right,
> > lots of hardware and/or drivers do not handle
> > that.
>
> First, the two devices in question are not on the same interrupt.  Second, it
> is very difficult in this day in age to build a system without interrupt
> sharing.  While I agree that it's better to have as few devices sharing as
> possible, there are simply too many devices in modern systems and too few
> interrupts.  Interrupt sharing needs to work on modern hardware and needs to
> work in Linux.  This notebook is pretty typical in its interrupt distribution
> and I'm not certain that this is a problem.  In fact, while many devices on
> this system use IRQ 11 the only one active at the time was the audio
> controller.  And while IRQ 10 is shared between the CardBus adapters and the
> video card the problems still occur if I don't run X and video interrupts
> shouldn't be generated in console mode, right?
>
> > I think you should try to reconfigure your
> > system so that devices do not share same IRQ
> > and see whether that 'fix' the problem.
>
> There are no options in my notebook's BIOS to reconfigure interrupts or
> disable
> devices.
>
> > BTW, can you show your /proc/interrupts ?
>
> Attached.
>
> > --
> > vda
>
> Carl Thompson
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


