Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136454AbRAMCuN>; Fri, 12 Jan 2001 21:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136376AbRAMCuE>; Fri, 12 Jan 2001 21:50:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:50692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136414AbRAMCtq>; Fri, 12 Jan 2001 21:49:46 -0500
Date: Fri, 12 Jan 2001 18:48:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Frank de Lange <frank@unternet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <3A5FB997.7F366C3@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10101121835130.815-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2001, Andrew Morton wrote:
> 
> 3c59x calls disable_irq() once per minute, and seems to be
> one of the most-affected drivers.

The ne2k thing seems to be the _most_ affected one, as far as I can tell.

However, it could easily be a matter of timing - for example, if the
driver does something to trigger an interrupt _just_ before (or after,
considering the asynchronous nature of writing to the IO-APIC) doing the
enable_irq(), then..

I'm also nervous about the complete lack of locking in vortex_timer():
disabling interrupts doesn't mean that transmits couldn't be
pending. But maybe the hardware is ok with changing status concurrently.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
