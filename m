Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135994AbRAMAta>; Fri, 12 Jan 2001 19:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135954AbRAMAtU>; Fri, 12 Jan 2001 19:49:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44816 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136029AbRAMAtG>; Fri, 12 Jan 2001 19:49:06 -0500
Date: Fri, 12 Jan 2001 16:48:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <E14HEn2-0005M6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101121645290.8097-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2001, Alan Cox wrote:

> > 	interrupt_handler()
> > 	{
> > 		status = readl(dev->status);
> > 		if (status & MY_IRQ_DISABLE)
> > 			return;
> 
> Unfortunately on the 8390 the IRQ statud register is on page 0. The code
> on the other CPU might not be on page 0. That means we can't even safely
> check if there is an irq pending or clear it down (bad news on ne2k-pci)
> without getting that lock.

Alan.

THINK.

The "synchronous channel" can be _memory_. I just used the above as an
example of using a synchronous channel to make sure that the asynchronous
buses aren't screwing us.

You only need one bit of synchronous information. The example used the
very same bit that the irq flag on the device is anyway - which works on a
lot of devices simply because they need to read the status flags anyway
in order to handle the interrupt.

But if you have problems with that, just use an atomic flag off
"dev->private" instead. Big deal.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
