Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135575AbRAMA5u>; Fri, 12 Jan 2001 19:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136000AbRAMA5k>; Fri, 12 Jan 2001 19:57:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3345 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135575AbRAMA5W>; Fri, 12 Jan 2001 19:57:22 -0500
Date: Fri, 12 Jan 2001 16:56:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Frank de Lange <frank@unternet.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <20010113014807.B29757@unternet.org>
Message-ID: <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2001, Frank de Lange wrote:

> On Fri, Jan 12, 2001 at 04:36:33PM -0800, Linus Torvalds wrote:
> > It may well not be disable_irq() that is buggy. In fact, there's good
> > reason to believe that it's a hardware problem.
> 
> I am inclined to believe it IS a hardware problem... If disable_irq were buggy,
> wouldn't the problem occur more frequently in other irq-heavy areas? A quick
> count shows that disable_irq* is used in 84 sourcefiles in the driver/*
> directory. This includes drivers which generate many interrupts in a short
> timeframe (like ide).

IDE is not my favourite example of a "known stable driver". Also, in many
cases IDE is for historical reasons connected to an EDGE io-apic pin (ie
it's still considered an ISA interrupt). Which probably wouldn't show this
problem anyway.

Also, IDE doesn't generate all that many interrupts. You can make a
network driver do a _lot_ more interrupts than just about any disk driver
by simply sending/receiving a lot of packets. With disks it is very hard
to get the same kind of irq load - Linux will merge the requests and do at
least 1kB worth of transfer per interrupt etc. On a ne2k 100Mbps PCI card,
you can probably _easily_ generate a much higher stream of interrupts.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
