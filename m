Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbUKLQvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbUKLQvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUKLQtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:49:17 -0500
Received: from alog0333.analogic.com ([208.224.222.109]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262579AbUKLQri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:47:38 -0500
Date: Fri, 12 Nov 2004 11:47:10 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RTC Chip and IRQ8 on 2.6.9
Message-ID: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I must use the RTC and IRQ8 in a driver being ported from
2.4.20 to 2.6.9. When I attempt request_irq(8,...), it
returns -EBUSY. I have disabled everything in .config
that has "RTC" in it.

The RTC interrupt is used to precisely time the sequencing
of a precision A/D converter. It is mandatory that I use
it because the precise interval is essential for its
IIR filter that produces 20 bits of resolution from a
16 bit A/D.

            CPU0
   0:   60563767    IO-APIC-edge  timer
   1:      57096    IO-APIC-edge  i8042
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  12:         66    IO-APIC-edge  i8042
  14:     112322    IO-APIC-edge  ide0
  16:          0   IO-APIC-level  uhci_hcd, uhci_hcd
  18:        640   IO-APIC-level  libata, uhci_hcd, Analogic Corp DLB
  19:          0   IO-APIC-level  uhci_hcd
  20:    4894484   IO-APIC-level  eth0
  21:     110543   IO-APIC-level  aic7xxx
  23:          0   IO-APIC-level  ehci_hcd
NMI:          0 
LOC:   60565403 
ERR:          0
MIS:          0

This stuff works fine in 2.4.22 and, in fact, I'm the guy
that added the global rtc_lock so that this very driver
could run without interfering with anybody. Now, some code,
somewhere (not in a module), has allocated the interrupt
and generated exactly 1 interrupt. The kernel won't let
me use that interrupt!

How do I undo this so I can use my hardware on my machine?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
