Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTH3TQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTH3TQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 15:16:07 -0400
Received: from rr54.neoplus.adsl.tpnet.pl ([80.50.104.54]:16000 "EHLO zosia")
	by vger.kernel.org with ESMTP id S262028AbTH3TQC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 15:16:02 -0400
Date: Sat, 30 Aug 2003 21:17:26 +0200 (CEST)
From: =?iso-8859-2?Q?Staszek_Pa=B6ko?= <staszek@nutki.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 (also 2.4.23pre1) and NEC USB lockup problem
Message-ID: <Pine.LNX.4.44.0308302113280.1139-100000@zosia.nutki.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a Transmeta Crusoe based Fujitsu LOOX T93B laptop (pretty much
the same as Fujitsu P2120 AFAIR). It is equipped with ALI OHCI USB 1.1
controller + NEC EHCI USB 1.1+2.0 controller. I wanted to give a try
to 2.4.22 kernel (i am still using 2.4.21-pre3, which works fine with
ACPI patches), but the system would lock hard whenever inserting any
USB device (sole USB system seems to start up with no problems). The
problem is probably with usb-ohci module which handles the NEC
controllers USB 1.1 part, where the devices get connected to.

IRQ routing is done via ACPI and IRQ distribution has changed from
2.4.21-pre3 + acpi 20030109 - maybe this matters:
2.4.21-pre3: usb_ohci: irq 11 ALI, irq 9 (*2) NEC; usb_ehci: irq 9;
also on irq 9: wlan, audio, acpi
2.4.22: usb_ohci: irqs 10 ALI, 10+11 NEC; usb_ehci: irq 5 (shared with
audio)
Without ACPI USB doesn't get IRQs assigned and does not work at all
(although the system does not hang). APIC is compiled-in, but is not
detected (/proc
interrupts reports XT-PIC).

SYSRQ doesn't work after the hang, and also compiling the kernel with all
debug options didn't produce any more messages. This most probably is some
kind of deadlock, since the CPU is warming up fast. Idon't know what I
could do to diagnose it further, i don't know much about USB...

Any advice would be welcome.

PS. Please, Cc me directly, i read the list periodically via google.

-- 
Staszek Pa¶ko     | Come, now. God, root, what's the difference ?
staszek@nutki.com | (c) UserFriendly.org





