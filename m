Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRALSRV>; Fri, 12 Jan 2001 13:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRALSRL>; Fri, 12 Jan 2001 13:17:11 -0500
Received: from chiara.elte.hu ([157.181.150.200]:43790 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129664AbRALSRK>;
	Fri, 12 Jan 2001 13:17:10 -0500
Date: Fri, 12 Jan 2001 19:16:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dwmw2@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <frank@unternet.org>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <3A5F4827.2E443786@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0101121912340.1071-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Manfred Spraul wrote:

> The PPro local apic documentation says:
> <<<<<<<
> The processor's local APIC includes an in-service entry and a holding
> entry for each priority level. To avoid losing interrupts, software
> should allocate no more than 2 interrupt vectors per priority.
> >>>>>>>>
>
> Ok, we must reorder the vector numbers for our own interrupts
> (0xfb-0xff), but that doesn't explain our problems: we don't loose
> reschedule interrupts, we have problems with normal interrupts - and
> there we only use 2 irq at the same priority level.

we *already* reorder vector numbers and spread them out as much as
possible. We do this in 2.2 as well. We did this almost from day 1 of
IO-APIC support. If any manually allocated IRQ vector creates a '3 vectors
in the same 16-vector region' situation then thats a bug in hw_irq.h..

the 'loss of interrupts' above does not include external interrupts, only
local interrupts (such as the APIC timer interrupt) can get lost in such a
situation.

(nevertheless there is something going on.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
