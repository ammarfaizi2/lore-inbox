Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFTKA>; Wed, 6 Dec 2000 14:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLFTJu>; Wed, 6 Dec 2000 14:09:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129231AbQLFTJh>; Wed, 6 Dec 2000 14:09:37 -0500
Date: Wed, 6 Dec 2000 10:38:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
In-Reply-To: <20001206190850.A847@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10012061033160.1715-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Erik Mouw wrote:
> 
> So at first the PCI code can't allocate an IRQ for devices 00:00.1
> (audio), 00:07.2 (USB), and 00:09.0 (winmodem), but after the audio and
> USB modules get inserted, IRQ 5 and 11 get allocated.

No, the irq stuff is a two-stage process: at first it only _reads_ the irq
config stuff for every device - whether they have a driver or not - and at
this stage it will not ever actually allocate and set up a new route. It
will just see if a route has already been set up by the BIOS.

Then, when a driver actually does a pci_enable_device(), it will do the
second stage of PCI irq routing, which is to actually set up a route if
none originally existed. So this is why you first se "failed" messages
(the generic "test if there is a route" code) and then later when loading
the module you see "allocated irq XX" messages.

So your dmesg output looks fine, and everything is ok at that level. The
fact that something still doesn't work for you indicates that we still
have problems, of course.

Can you tell me what device it is that doesn't work for you? 

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
