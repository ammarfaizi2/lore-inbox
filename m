Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRALSpZ>; Fri, 12 Jan 2001 13:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALSpP>; Fri, 12 Jan 2001 13:45:15 -0500
Received: from colorfullife.com ([216.156.138.34]:34821 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129655AbRALSpN>;
	Fri, 12 Jan 2001 13:45:13 -0500
Message-ID: <3A5F50B0.ACD5ADB1@colorfullife.com>
Date: Fri, 12 Jan 2001 19:45:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, dwmw2@infradead.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>, frank@unternet.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <Pine.LNX.4.30.0101121912340.1071-100000@e2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> we *already* reorder vector numbers and spread them out as much as
> possible. We do this in 2.2 as well. We did this almost from day 1 of
> IO-APIC support. If any manually allocated IRQ vector creates a '3 vectors
> in the same 16-vector region' situation then thats a bug in hw_irq.h..
> 
I reread the 2.2 and 2.4 code:

2.2 spreads all vectors, even the internal interrupts (tlb flush,
reschedule, timer, call function) are spread.
Hmm. AFAICS there is one bug: 3 interrupts are in priority 5:

CALL_FUNCTION_VECTOR	0x50
IRQ0_TRAP_VECTOR	0x51
irq1: irq0+8		0x59

check arch/i386/kernel/irq.h and assign_irq_vector (io_apic.c)

2.4 spreads the vectors for the external (hardware, from io apic)
interrupts, but 5 ipi vectors have the same priority: reschedule, call
function, tlb invalidate, apic error, spurious interrupt.

But that doesn't explain what happens with ne2k cards: neither 2.2 nor
2.4 have more than 2 interrupts in class for the hardware interrupt
16/19.
With 2.2 I don't have any problems, 2.4 hangs.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
