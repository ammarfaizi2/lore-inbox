Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131044AbRALRRF>; Fri, 12 Jan 2001 12:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRALRQz>; Fri, 12 Jan 2001 12:16:55 -0500
Received: from colorfullife.com ([216.156.138.34]:26373 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131044AbRALRQs>;
	Fri, 12 Jan 2001 12:16:48 -0500
Message-ID: <3A5F3BF4.7C5567F8@colorfullife.com>
Date: Fri, 12 Jan 2001 18:16:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org, frank@unternet.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> manfred@colorfullife.com said: 
> > IRR for interrupt 19 is set, that means the IO APIC has sent the 
> > interrupt to a cpu but not yet received the corresponding EOI. 
> 
> OK, but couldn't we reset it by sending an extra EOI when the drivers 
> decide that they've missed interrupts? 

How?
You send an EOI by writing 0 to the EOI register of the local apic, and
then the local apic automagically checks it's ISR bitfield.
It takes the highest set bit and clears it. Then it checks that bit in
the TMR, and it if's also set in the TMR then it sends an EOI to the IO
apic.

The magic seems to be tamper proof: all bits are read only.

The bit on the IO apic is also read only.
Perhaps with brute force? Switch the interrupt to edge triggered on the
io apic, wait 1 usec, switch it back to level triggered. The IRR bit is
undefined for edge triggered interrupts, perhaps that clears the IRR
bit.

I would first concentrate on the differences between 2.2 and 2.4:

Frank, could you try what happens with the NMI oopser disabled?

The second major difference I'm immediately aware of is the number of
the reschedule/tlb flush/etc interrupt: 2.2 uses the lowest priority,
2.4 the highest priority.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
