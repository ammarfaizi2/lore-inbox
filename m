Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJCIko>; Wed, 3 Oct 2001 04:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276072AbRJCIke>; Wed, 3 Oct 2001 04:40:34 -0400
Received: from chiara.elte.hu ([157.181.150.200]:29959 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276094AbRJCIk3>;
	Wed, 3 Oct 2001 04:40:29 -0400
Date: Wed, 3 Oct 2001 10:38:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: Benjamin LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110020724530.29541-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110022256430.2543-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Oct 2001, jamal wrote:

> You are still missing the point (by humping on the literal meaning of
> the example i provide), the point is: fine grained vs shutting down
> the whole IRQ.

i'm convinced that this is a minor detail.

there are *tons* of disadvantages if IRQs are shared. In any
high-performance environment, not having enough interrupt sources is a
sizing or hw design mistake. You can have up to 200 interrupts even on a
PC, using multipe IO-APICs. Any decent server board distributes interrupt
sources properly. Shared interrupts are a legacy of the PC design, and we
are moving away from it slowly but surely. Especially under gigabit loads
there are several PCI busses anyway, so getting non-shared interrupts is
not only easy but a necessity as well. There is no law in physics that
somehow mandates or prefers the sharing of interrupt vectors: devices are
distinct, they use up distinct slots in the board. The PCI bus can get
multiple IRQ sources out of a single card, so even multi-controller cards
are covered.

i fully agree that both the irq code and drivers themselves have to handle
shared interrupts correctly, and we should not penalize shared interrupts
unnecesserily, but do they have to influence our design decisions too
much? Nope.

	Ingo

