Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbTFCQot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbTFCQot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:44:49 -0400
Received: from node-c-7b22.a2000.nl ([62.194.123.34]:5504 "EHLO
	wsprwl.xs4all.nl") by vger.kernel.org with ESMTP id S265093AbTFCQor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:44:47 -0400
Date: Tue, 3 Jun 2003 18:58:15 +0200
From: Ruud Linders <rkmp@xs4all.nl>
To: Paul Rolland <rol@as2917.net>
Cc: "'Russell King'" <rmk@arm.linux.org.uk>, "'Ruud Linders'" <rkmp@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Serial port numbering (ttyS..) wrong for 2.5.61+
Message-ID: <20030603165815.GA2016@wsprwl.xs4all.nl>
References: <20030602185118.B776@flint.arm.linux.org.uk> <011501c32936$d8fc44d0$3f00a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011501c32936$d8fc44d0$3f00a8c0@witbe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

Setting SERIAL_DEBUG_PCI gives me this:

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Setup PCI port: port bc00, irq 21, type 0
ttyS14 at I/O 0xbc00 (irq = 21) is a 16550A
Setup PCI port: port bc08, irq 21, type 0
ttyS15 at I/O 0xbc08 (irq = 21) is a 16550A
Setup PCI port: port bc10, irq 21, type 0
ttyS2 at I/O 0xbc10 (irq = 21) is a 16550A
Setup PCI port: port bc18, irq 21, type 0
ttyS3 at I/O 0xbc18 (irq = 21) is a 16550A

Doesn't give us much more detail.

BTW, this is the entry in 8250_pci.c for the board in question:
        {       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_1077,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
                pbn_b2_4_921600 },

Note that the ttyS's _are_ numbered in sequence in 2.4.20


On Mon, Jun 02, 2003 at 08:43:24PM +0200, Paul Rolland wrote:
> Hello,
> 
> 
> > When we add a port to the system, we try to find in order:
> > 
> > - a port which matches the base address
> > - a port which is unallocated
> > 
> > Probably the easiest way to stop the "ttyS14" occuring would 
> > be to clear the port information at boot when we don't find a port.
> > 
> >From 8250_pci.c, you have :
> 
> /*              
>  * Probe one serial board.  Unfortunately, there is no rhyme nor reason
>  * to the arrangement of serial ports on a PCI card.
>  */             
> 
> It seems that your board is reporting the parameters in such an order
> that when looking for a port based on the IRQ, I/O port, ... the matching
> one has id 14...
> 
> You could see this more clearly by setting SERIAL_DEBUG_PCI
> at line 1549 to activate the code :
> #ifdef SERIAL_DEBUG_PCI
>                 printk("Setup PCI port: port %x, irq %d, type %d\n",
>                        serial_req.port, serial_req.irq, serial_req.io_type);
> #endif
> 
> that would report to you the order in which ports are found on
> your system.
> 
> Regards,
> Paul
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
