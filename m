Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129816AbRBBQEe>; Fri, 2 Feb 2001 11:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRBBQEZ>; Fri, 2 Feb 2001 11:04:25 -0500
Received: from colorfullife.com ([216.156.138.34]:19216 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129816AbRBBQEL>;
	Fri, 2 Feb 2001 11:04:11 -0500
Message-ID: <3A7ADA84.6892DE07@colorfullife.com>
Date: Fri, 02 Feb 2001 17:04:20 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mingo@redhat.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: mpparse.c question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started cleaning up mpparse.c/ioapic.c for the addition of acpi
support, but I got stuck in the mess of global variables.

What's the purpose of of the irq_2_pin in io_apic.c?

I assume that I overlook something, but afaics the code allows one
physical interrupt source (e.g. INTA from device 9 on pci bus 0) to
arrive at multiple ioapic pins.

Can that happen, is that important?

Silly question: Why can't we ignore all but the first pin? If we don't
enable the additional pins, we don't have to disable them during
disable_irq().

disable_irq() and enable_irq() seem to be the only users of irq_2_pin.

Btw, is is correct that the isa irq's are always connected to the first
io apic? find_isa_irq_pin() doesn't handle that, and the caller just
access io apic 0.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
