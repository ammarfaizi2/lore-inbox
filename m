Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSIISpy>; Mon, 9 Sep 2002 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSIISpx>; Mon, 9 Sep 2002 14:45:53 -0400
Received: from [63.209.4.196] ([63.209.4.196]:47631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318835AbSIISpt>; Mon, 9 Sep 2002 14:45:49 -0400
Date: Mon, 9 Sep 2002 11:53:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@mwaikambo.name>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209092041300.30411-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209091151200.14841-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Ingo Molnar wrote:
> 
> There's also the following effect that could generate additional
> interrupts: the *same* IRQ source that is currently executing might
> generate a (spurious but otherwise harmless) interrupt if we first ACK the
> card then ACK the APIC and then do processing. Our current way of masking
> interrupts in the IO-APIC at least leaves them pending there until the
> handler's main work loop is finished and mitigates irqs.

I agree with you, but that is only true for edge-triggered APIC
interrupts, though - for level-triggered ones we will just re-take the
interrupt when we unmask it again.

Which is kind of sad. Is there some fast way to read the status of a 
level-trigger irq off the IO-APIC in case it is still pending, and to do 
the mitigation even for level-triggered?

(Btw, if there is, that would also allow us to notice the "constantly
screaming PCI interrupt" without help from the low-level isrs)

		Linus

