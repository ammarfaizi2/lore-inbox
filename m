Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRALSJJ>; Fri, 12 Jan 2001 13:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRALSJA>; Fri, 12 Jan 2001 13:09:00 -0500
Received: from colorfullife.com ([216.156.138.34]:30469 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129538AbRALSIw>;
	Fri, 12 Jan 2001 13:08:52 -0500
Message-ID: <3A5F4827.2E443786@colorfullife.com>
Date: Fri, 12 Jan 2001 19:08:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org, frank@unternet.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <E14H8Ks-0004hA-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Frank, could you try what happens with the NMI oopser disabled?
> >
> > The second major difference I'm immediately aware of is the number of
> > the reschedule/tlb flush/etc interrupt: 2.2 uses the lowest priority,
> > 2.4 the highest priority.
> 
> Im trying to remember what they were, but some APIC versions do have errata
> and someting about 3 irqs at the same priority level rings a bell.

The PPro local apic documentation says:
<<<<<<<
The processor's local APIC includes an in-service entry and a holding
entry for each priority level. To avoid losing interrupts, software
should allocate no more than 2 interrupt vectors per priority.
>>>>>>>>

Ok, we must reorder the vector numbers for our own interrupts
(0xfb-0xff), but that doesn't explain our problems: we don't loose
reschedule interrupts, we have problems with normal interrupts - and
there we only use 2 irq at the same priority level.

Btw, the kick patch I sent a few minutes ago revives my io apic.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
