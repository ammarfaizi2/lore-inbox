Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136343AbRAMCGq>; Fri, 12 Jan 2001 21:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136342AbRAMCGg>; Fri, 12 Jan 2001 21:06:36 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:65206 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S136323AbRAMCG2>; Fri, 12 Jan 2001 21:06:28 -0500
Message-ID: <3A5FB997.7F366C3@uow.edu.au>
Date: Sat, 13 Jan 2001 13:12:39 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Frank de Lange <frank@unternet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <20010113014807.B29757@unternet.org> <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 13 Jan 2001, Frank de Lange wrote:
> 
> > On Fri, Jan 12, 2001 at 04:36:33PM -0800, Linus Torvalds wrote:
> > > It may well not be disable_irq() that is buggy. In fact, there's good
> > > reason to believe that it's a hardware problem.
> >
> > I am inclined to believe it IS a hardware problem... If disable_irq were buggy,
> > wouldn't the problem occur more frequently in other irq-heavy areas? A quick
> > count shows that disable_irq* is used in 84 sourcefiles in the driver/*
> > directory. This includes drivers which generate many interrupts in a short
> > timeframe (like ide).
> 
> IDE is not my favourite example of a "known stable driver". Also, in many
> cases IDE is for historical reasons connected to an EDGE io-apic pin (ie
> it's still considered an ISA interrupt). Which probably wouldn't show this
> problem anyway.
> 

3c59x calls disable_irq() once per minute, and seems to be
one of the most-affected drivers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
