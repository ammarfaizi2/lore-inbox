Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130926AbRBHLkv>; Thu, 8 Feb 2001 06:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131050AbRBHLkl>; Thu, 8 Feb 2001 06:40:41 -0500
Received: from [64.160.188.242] ([64.160.188.242]:2575 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S130926AbRBHLkg>; Thu, 8 Feb 2001 06:40:36 -0500
Date: Thu, 8 Feb 2001 03:40:24 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: APIC Errors with 2.4.2-pre1
Message-ID: <Pine.LNX.4.30.0102080249380.29697-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First off, here's something from my dmesg.

mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
CALLIN, before setup_local_APIC().
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.......    : physical APIC id: 02
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
calibrating APIC timer ...
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 18
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16






Then whenever I do heavy CPU or RAM testing using something like cputest
and ubench, I get the following errors in my log..

APIC error on CPU0: 00(08)
APIC error on CPU1: 00(08)
APIC error on CPU1: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU1: 08(02)
APIC error on CPU1: 02(02)
APIC error on CPU1: 02(08)
APIC error on CPU0: 08(02)
APIC error on CPU1: 08(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(02)
APIC error on CPU1: 02(08)
APIC error on CPU1: 08(02)
APIC error on CPU1: 02(02)


and on and on and on and on...


I found the error codes in /usr/src/linux/arch/i386/kernel/apic.c. I could
use a little help though on interpreting the error code(s) returned.

Also, from the source code I see that apic_read(APIC_ESR) is called.
In /usr/src/linux/include/asm/apicdef.h, I see that APIC_ESR is 0x280
which I take is the offset into the APIC_DEFAULT_PHYS_BASE.

Since this is a controller, I'd like to know what the ##(##) represent. I
take it that these numbers are the error code the controller reported just
before and just after the apic_write(). To me it looks like this was
done this way just to save state because the next thing called was the
ack_APIC_irq().

Can someone also please explain what the ESR is?


(Please forgive my ignorance of this stuff.)


-- 
David D.W. Downey - RHCE
Consulting Engineer
Ensim Corporation - Sunnyvale, CA

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
