Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131226AbQKXAYO>; Thu, 23 Nov 2000 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131353AbQKXAYE>; Thu, 23 Nov 2000 19:24:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27663 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S131226AbQKXAXs>; Thu, 23 Nov 2000 19:23:48 -0500
Date: Thu, 23 Nov 2000 15:53:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Michael Elkins <me@sigpipe.org>,
        Rui Sousa <rsousa@grad.physics.sunysb.edu>, usb@in.tum.de,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci
 and  emu10k1
In-Reply-To: <3A1DA2F7.94114CD2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011231551210.1702-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Jeff Garzik wrote:
> > 
> > It hangs in start_uhci():
> > 
> >                 /* disable legacy emulation */
> >                 pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);

Try changing the thing around a bit: make the above place say

	/* disable legacy emulation */
	pci_write_config_word (dev, USBLEGSUP, 0);

and then AFTER we have successfully done a request_irq() call, we 
can enable PCI interrupts with

	/* Enable PIRQ */
	pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);

Does that make it happier?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
