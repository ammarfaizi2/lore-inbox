Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbSLJAWV>; Mon, 9 Dec 2002 19:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLJAWV>; Mon, 9 Dec 2002 19:22:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27660 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266434AbSLJAWT>; Mon, 9 Dec 2002 19:22:19 -0500
Date: Mon, 9 Dec 2002 16:30:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <1039481030.12046.19.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212091628130.2003-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 Dec 2002, Alan Cox wrote:

> On Mon, 2002-12-09 at 18:11, Linus Torvalds wrote:
> > That's definitely where it should be - the behaviour of the
> > PCI_INTERRUPT_LINE register is clearly chip-specific, so it should be in
> > the chip-specific drivers..
> >
> > It's a kind of strange behaviour, though. What chip is this? It sounds
> > kind of convenient, but as far as I can tell it can only work for those
> > kinds of PCI devices that are on the same chip as the irq controller..
>
> VIA bridges. In my case its a CLE266 (onchip video, 5.1 audio, ide, usb,
> firewire, ethernet, floppy, serial, irda. parallel...) [See why I don't
> want to hack each driver 8)]

Oh, I didn't mean each sub-chip driver, I meant the "southbridge driver".
Right now that's really only the PIRQ table mini-driver (all ten lines of
it ;)

Sadly, we do _not_ have a really good generic model for setting interrupt
lines. The PIRQ stuff comes closest to a driver model, but it gets
disabled by the MP table parsing, and then we don't have anything good to
fall back on, I'm afraid.

			Linus

