Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277104AbRJDDt4>; Wed, 3 Oct 2001 23:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277103AbRJDDtq>; Wed, 3 Oct 2001 23:49:46 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:30470 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277102AbRJDDte>; Wed, 3 Oct 2001 23:49:34 -0400
Date: Wed, 3 Oct 2001 23:50:02 -0400
Message-Id: <200110040350.f943o2d08615@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.33.0110022256430.2543-100000@localhost.localdomain>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110022256430.2543-100000@localhost.localdomain> 
    mingo@elte.hu wrote:

>there are *tons* of disadvantages if IRQs are shared. In any
>high-performance environment, not having enough interrupt sources is a
>sizing or hw design mistake. You can have up to 200 interrupts even on a
>PC, using multipe IO-APICs. Any decent server board distributes interrupt
>sources properly. Shared interrupts are a legacy of the PC design, and we
>are moving away from it slowly but surely. Especially under gigabit loads
>there are several PCI busses anyway, so getting non-shared interrupts is
>not only easy but a necessity as well. There is no law in physics that
>somehow mandates or prefers the sharing of interrupt vectors: devices are
>distinct, they use up distinct slots in the board. The PCI bus can get
>multiple IRQ sources out of a single card, so even multi-controller cards
>are covered.

  Sharing irq between unrelated devices is probably evil in all cases,
but for identical devices like multiple NICs, the shared irq results in
*one* irq call, followed by polling the devices connected, which can be
lower overhead than servicing N interrupts on a multi-NIC system.

  Shared interrupts predate the PC by a decade (or more), so the comment
about the "PC design" is not relevant. In general polling multiple
devices is less CPU than servicing the same i/o by a larger number of
entries to the interrupt handler. The polling offers the possibility of
lower the number of context switches, far more expensive than checking a
device.

  In serial and network devices the poll is often unavoidable, unless
you use one irq for send and one for receive you will be doing a bit of
polling in any case.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
