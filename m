Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRIDWSE>; Tue, 4 Sep 2001 18:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269651AbRIDWRy>; Tue, 4 Sep 2001 18:17:54 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:56078 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S269489AbRIDWRo>;
	Tue, 4 Sep 2001 18:17:44 -0400
Date: Tue, 4 Sep 2001 18:17:51 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <200109011456.f81EutI16218@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109041803010.1614-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 1 Sep 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>,
> Olivier Crete  <Tester@videotron.ca> wrote:
> >
> >Ok, I've tried removing different parts of the kernel and I have been
able
> >to find that the instability (repetable freezes) start to appear when the
> >yenta_socket.o module is loaded. I dont see the link between this module
> >and the events that trigger the freezes... It crashes when I do the
> >following things: use any of the non-keyboard buttons (thinkpad buttons
> >and volume control), brightness control, etc.. These buttons fn-X
> >combination have in common that they do not generate a scancode as shown
> >by showkey.
>
> What they are doing, however, is to generate a SCI, ie "System Control
> Interrupt". Which, I bet you five bucks, is routed to the same interrupt
> that your CardBus controller is on.

Seems like you may have lost five bucks... When ACPI is enabled the sci is
on IRQ 9, while the CardBus controller is on a IRQ 11 along with
the Sound card, the ethernet card, the modem and the usb controller. The
SCI seems to go to irq 9... and be alone there...  The bug does not happen
when acpi is enabled tho... So I can't confirm...

> So the fact that the system hangs only with the CardBus module loaded
> really has nothing to do with the yenta code itself - it's just that
> before the yenta module is loaded, the SCI will be entirely ignored.
> Once yenta _is_ loaded, however, we have a interrupt handler for the
> interrupt and will start accepting it.
>
> However, the interrupt handler we have is _not_ aware of system
> control interrupts. So it won't be able to handle them, and the
> interrupts will go on forever - locking up the machine.

Where would that loop occur?



-- 
Tester
tester@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer


