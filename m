Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTKDCs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 21:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTKDCs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 21:48:56 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:28800
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263607AbTKDCsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 21:48:55 -0500
Date: Mon, 3 Nov 2003 21:47:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Charles Martin <martinc@ucar.edu>, linux-kernel@vger.kernel.org
Subject: Re: interrupts across  PCI bridge(s) not handled
In-Reply-To: <Pine.LNX.4.44.0311030859190.20373-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.53.0311032145570.20595@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311030859190.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003, Linus Torvalds wrote:

> 
> On Mon, 3 Nov 2003, Charles Martin wrote:
> >
> > I have a pci backplane extender, with 4 cards 
> > (named piraq) in it. The cards are detected by 
> > the PCI system, and irqs 92-95 are assigned, 
> > as shown in /var/log/messages:
> > 
> > kernel: PCI->APIC IRQ transform: (B6,I4,P0) -> 93 
> > kernel: PCI->APIC IRQ transform: (B6,I6,P0) -> 95 
> > kernel: PCI->APIC IRQ transform: (B6,I7,P0) -> 92
> > kernel: PCI->APIC IRQ transform: (B6,I9,P0) -> 94
> 
> Can you enable APIC_DEBUG debugging in "include/asm-i386/apic.h", and make 
> sure that you build the kernel with a big printk buffer. Then, in case 
> your distribution comes with a broken "dmesg" binary that doesn't show 
> more than about 20kB of data, compile this trivial program and run it 
> after bootup, and send the whole log out..
> 
> It would be a pity to have to boot with "noapic", since this is exactly 
> the kind of situation where you _want_ the extra interrupts.

I wonder how the request_irq worked there, doesn't 'none' denote no 
irq_desc[i].handler == no_irq_type?
