Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSFNSSr>; Fri, 14 Jun 2002 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSFNSSq>; Fri, 14 Jun 2002 14:18:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62734 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311752AbSFNSSq>; Fri, 14 Jun 2002 14:18:46 -0400
Date: Fri, 14 Jun 2002 11:18:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141308100.31514-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0206141115340.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jun 2002, Kai Germaschewski wrote:
>
> What about adding some pci_request_irq() and pci_request_{,mem_}_region,
> which would allow for some cleanup of ever-recurring code sequences in
> drivers, and which at the same time would allow for the above?
> pci_request_mem_region() might even include the ioremap() as well ;)

That might be the right solution - leave "pci_enable_dev()" as-is, and
just consider that the legacy way of "enable stuff that got allocated
automatically".

And make new drivers start using "pci_request_irq()" and friends.

(The current "pci_enable_dev()" is broken in many respects: sometimes you
do NOT want to enable the IRQ until you have set up the device, but in
order to set up the device you may need to know _which_ irq it will have,
and you need to enable access to memory and IO regions and map the
device).

			Linus

