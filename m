Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130293AbQKFXkP>; Mon, 6 Nov 2000 18:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbQKFXkF>; Mon, 6 Nov 2000 18:40:05 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:14852 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S130293AbQKFXj4>;
	Mon, 6 Nov 2000 18:39:56 -0500
Date: Mon, 6 Nov 2000 15:40:39 -0800
From: David Hinds <dhinds@valinux.com>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
Message-ID: <20001106154039.A19860@valinux.com>
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A073C8D.B6511746@linux.com>; from David Ford on Mon, Nov 06, 2000 at 03:19:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 03:19:41PM -0800, David Ford wrote:
> 
> Undoubtedly :(  But it used to work when I used your i82365 module instead of
> the kernel's yenta module.  The i82365 module now gives the same failure
> output as the yenta module.

How long ago was this?  I would need to know what kernel versions and
what PCMCIA driver versions were involved.  It has been months since I
changed any of the PCI bridge setup code in the PCMCIA modules.

> I modprobed the following to get things up and running, (all your pkg)
> pcmcia_core, i82365, and ds.  Then ran cardmgr.  All was well.  Now when I
> load i82365, it yields the pci irq failure and the irq type is changed.
> 
> 2nd sentc: What changed in the last two-three weeks?  I notice that the
> current pcmcia (yours) code loads a new module called pci_fixup.

There is no module called pci_fixup.  There is an object file called
pci_fixup that is linked into pcmcia_core.  This has been there since
PCMCIA release 3.1.11.

> Intel PCIC probe: <4>PCI: No IRQ known for interrupt pin A of device 00:03.0.
> PCI: No IRQ known for interrupt pin B of device 00:03.1.

This is a PCI subsystem issue; the PCMCIA code asks the PCI subsystem
to activate the bridge device and isn't working.

>   Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
>     host opts [0]: [isa irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> 168/176] [bus 2/5]
>     host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> 168/176] [bus 6/9]
>     ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms
> 
> Previous output was:
>   Ricoh RL5C478 rev 03 PCI-to-CardBus at slot 00:03, mem 0x10000000
>     host opts [0]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> 168/176] [bus 2/5]
>     host opts [1]: [serial irq] [io 3/6/1] [mem 3/6/1] [no pci irq] [lat
> 168/176] [bus 6/9]
>     ISA irqs (default) = 3,4,7,11 polling interval = 1000 ms
> 
> Notice the change from serial irq to isa irq.

This is odd.  I don't have an explanation for this, especially without
knowing what PCMCIA driver releases were involved.  Unless you specify
otherwise, the i82365 driver just reports the bridge settings that it
finds; it won't change the interrupt delivery mode unless told to do
so.  So something else has caused your two sockets to be set up in
different ways; there isn't any way to tell the i82365 module to do
that.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
