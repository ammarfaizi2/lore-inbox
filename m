Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRIZRH6>; Wed, 26 Sep 2001 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275344AbRIZRHs>; Wed, 26 Sep 2001 13:07:48 -0400
Received: from chiara.elte.hu ([157.181.150.200]:4364 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S274426AbRIZRHh>;
	Wed, 26 Sep 2001 13:07:37 -0400
Date: Wed, 26 Sep 2001 19:05:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Norbert Roos <n.roos@berlin.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: System hangs during interruptible_sleep_on_timeout() under 2.4.9
In-Reply-To: <3BB20949.19469C6F@berlin.de>
Message-ID: <Pine.LNX.4.33.0109261902350.6377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Norbert Roos wrote:

> When I call interruptible_sleep_on_timeout(), the complete systems
> stops/hangs, even with small timeout values. This happens only on an
> Abit KT7A (VIA chip set) motherboard with an Athlon processor, other
> motherboards (different manufactors) behave normally. I call the
> function during the initialization of a PCI device, but during the
> sleep the device is not generating traffic on the PCI bus.

are you sure timer interrupts are processed while you are waiting for the
timeout to expire? I'd suggest to put a:

	printk("<%d>", irq);

into arch/i386/kernel/irq.c:do_IRQ(). So you can see what kind of
interrupt traffic there is while the device initializes and you are
waiting for it to generate an interrupt.

If you see lots of "<0>"  messages and the sleep_on() is not returning
nevertheless, then something serious is going on - almost nothing can
prevent timers from expiring.

	Ingo

