Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRBBR1V>; Fri, 2 Feb 2001 12:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbRBBR1M>; Fri, 2 Feb 2001 12:27:12 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:46022 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129367AbRBBR1A>; Fri, 2 Feb 2001 12:27:00 -0500
Date: Fri, 2 Feb 2001 18:16:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Manfred <manfred@colorfullife.com>
cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: mpparse.c question
In-Reply-To: <3A7ADA84.6892DE07@colorfullife.com>
Message-ID: <Pine.GSO.3.96.1010202174717.28509O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Manfred wrote:

> What's the purpose of of the irq_2_pin in io_apic.c?

 Just for what the comment says: to map our IRQ number to an apic:pin
entity in O(1).  It has to be fast!  You would have to parse the MP table
otherwise -- see pin_2_irq(). 

> I assume that I overlook something, but afaics the code allows one
> physical interrupt source (e.g. INTA from device 9 on pci bus 0) to
> arrive at multiple ioapic pins.

 That's secondary, AFAIK.

> Can that happen, is that important?
> 
> Silly question: Why can't we ignore all but the first pin? If we don't
> enable the additional pins, we don't have to disable them during
> disable_irq().

 Possibly yes -- I haven't seen such a system. 

> disable_irq() and enable_irq() seem to be the only users of irq_2_pin.

 That's why it has to be fast.

> Btw, is is correct that the isa irq's are always connected to the first
> io apic? find_isa_irq_pin() doesn't handle that, and the caller just
> access io apic 0.

 It appears it happens so for all systems checked so far.  The MPS does
not seem to enforce this configuration, so we might relax this dependency
for flexibility.  Note that not only find_isa_irq_pin() hardcodes this
assumption -- setup_ExtINT_IRQ0_pin() does as well, for example.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
