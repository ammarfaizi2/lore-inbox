Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXRBl>; Fri, 24 Nov 2000 12:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129716AbQKXRBc>; Fri, 24 Nov 2000 12:01:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129145AbQKXRBQ>; Fri, 24 Nov 2000 12:01:16 -0500
Date: Fri, 24 Nov 2000 08:30:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Elkins <me@toesinperil.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Rui Sousa <rsousa@grad.physics.sunysb.edu>, usb@in.tum.de,
        jerdfelt@valinux.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci
 and emu10k1
In-Reply-To: <20001123230614.A32540@toesinperil.com>
Message-ID: <Pine.LNX.4.10.10011240827500.2983-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Michael Elkins wrote:
> 
> On Thu, Nov 23, 2000 at 03:53:27PM -0800, Linus Torvalds wrote:
> > Try changing the thing around a bit: make the above place say
> > 
> > 	/* disable legacy emulation */
> > 	pci_write_config_word (dev, USBLEGSUP, 0);
> > 
> > and then AFTER we have successfully done a request_irq() call, we 
> > can enable PCI interrupts with
> > 
> > 	/* Enable PIRQ */
> > 	pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
> > 
> > Does that make it happier?
> 
> Yep! That seems to have fixed it.  Added the pci_write_config_word() after
> the request_irq() in alloc_uhci().

Johannes, can you get in touch with the right people and make sure this
gets fixed in both uhci drivers? They both look like they have the same
bug, and I'd prefer not to do it by hand as I don't have that much in the
form of USB..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
