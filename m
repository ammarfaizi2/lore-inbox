Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSFOTFY>; Sat, 15 Jun 2002 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSFOTFX>; Sat, 15 Jun 2002 15:05:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315468AbSFOTFX>; Sat, 15 Jun 2002 15:05:23 -0400
Date: Sat, 15 Jun 2002 12:05:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206151140400.3479-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206151148320.3479-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Jun 2002, Linus Torvalds wrote:
>
> Right now the solution to a screaming device can be something as nasty as
>
> 	cli();
> 	pci_enable_device();
> 	disable_irq(dev->irq);
> 	sti();
>
> 	/* IRQ handling needs this ioremapped */
> 	membase = ioremap(dev->resource[]);
> 	request_irq(dev->irq);
>
> 	/* Now we can enable the irq, because we have a valid handler */
> 	enable_irq(dev->irq);

Side note: the other approach to screaming devices is to pray that they
don't happen.

Which is actually the approach Linux takes, and which tends to work
reasonably well. All PCI devices reset without pending interrupts, and
probably windows doesn't react well to the bios doing something stupid.

But it's actually happened for pcmcia depending on init order (and right
now linux pcmcia is just fairly careful about the ordering).

		Linus

