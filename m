Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbULKC36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbULKC36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbULKC35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:29:57 -0500
Received: from av2.karneval.cz ([81.27.192.108]:55358 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S261914AbULKC3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:29:39 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel series
Date: Sat, 11 Dec 2004 03:30:48 +0100
User-Agent: KMail/1.7.1
References: <200412091459.51583.pisa@cmp.felk.cvut.cz> <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org> <1102726628.4948.1.camel@localhost.localdomain>
In-Reply-To: <1102726628.4948.1.camel@localhost.localdomain>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412110330.48993.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 December 2004 01:57, you wrote:
> On Sad, 2004-12-11 at 01:23, Linus Torvalds wrote:
> > > Until the 10,000th event it actually seems to work rather happily
> > > without that change.
> > 
> > I suspect you never tried the level-triggered case.
> 
> Level triggered has never been supported. Putting a single disable_irq
> in doesn't change the fact it doesn't work because the IRQ is never
> re-enabled.

The real very first reason for disable_irq introduction has been
infinite list of unbalanced enable_irq calls reported in the syslog,
caused by enable_irq(irqnumber) call from get_and_reset_irq().
It has been there for ages.
Not nice behavior. You see 100000 of such messages and then
processing stops on IRQ_NONE catch. I am voting for benefit of
our _very_ small VM86 IRQ emulation users community, that actual
state is many times better, than previous state. It is usable now.
I believe, that even level triggered interrupts should work
now without problems. We will give this feature real load testing.
We use it for educational DC motor control. 10kHz of IRQs.
We know, that even 2.6.x with preempt cannot handle that
without IRQ misses. But it is nice test to see on a osciloscope,
how userspace task reacts on IRQ events. And I think,
that 2.6.x kernel can evolve to one millisecond guaranteed response
time one day. It would be great. We have experience with real
drivers and writting code for RT-Linux as well.
I do not believe, that 2.6 kernels could get under 300 us
in reasonable future, so somethink like RT-Linux or dedicated
MCU would be still required for more demanding tasks.
But one millisecond could be enough for many complex control tasks.

Thanks for care

                Pavel

