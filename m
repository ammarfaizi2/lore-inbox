Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRCCKg3>; Sat, 3 Mar 2001 05:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRCCKgR>; Sat, 3 Mar 2001 05:36:17 -0500
Received: from smtp-rt-8.wanadoo.fr ([193.252.19.51]:43665 "EHLO
	lantana.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130442AbRCCKgD>; Sat, 3 Mar 2001 05:36:03 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Question about IRQ_PENDING/IRQ_REPLAY
Date: Sat, 3 Mar 2001 08:20:48 +0100
Message-Id: <19350126005232.15154@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

I've some questions regarding the behaviour of arch/i386/kernel/irq.c
regarding IRQ_PENDING and IRQ_REPLAY.

Especially, my question is about the code in enable_irq() which checks
for IRQ_PENDING, and then 
"replays" the interrupt by asking the APIC to issue it again.

I don't have a simple way on PPC to cause the interrupt to happen again,
as you can imagine this is rather controller-specific. However, looking
at the code closely, I couldn't figure out a case where having
IRQ_PENDING in enable_irq() makes sense.

How can IRQ_PENDING happen to be set on an IRQ_DISABLED interrupt, and
why would that matter (why should we take this interrupt) ?

AFAIK, IRQ_PENDING can only be set as a result of a call to do_IRQ().
Since we loop when calling the actual handler, I fail to see how we could
"miss" an interrupt. If the interrupt is actually disabled, we should not
get it at all, and if we did, I don't see why it would matter to resend
it when it gets enabled since disabled interrupts are supposed to be
ignored (well, they are by most PICs). Obviously, this matters only for
an edge interrupt as level ones will stay asserted until the device is happy.

I'd be glad if you could take the time to enlighten me about this as I'm
trying to make the PPC code as close as the i386, according to your
comment stating that it would be generic in 2.5, and I don't like having
code I don't fully understand ;)

Regards,
Ben.
