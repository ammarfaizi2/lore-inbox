Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271825AbTHHUFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHHUFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:05:20 -0400
Received: from [217.186.31.86] ([217.186.31.86]:3851 "EHLO
	gate.geos.net.eu.org") by vger.kernel.org with ESMTP
	id S271825AbTHHUFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:05:09 -0400
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.4.21/2.4.22-rc1: apic problems on SNI D823 board
From: geos@epost.de (Georg Schwarz)
Date: Fri, 8 Aug 2003 22:05:07 +0200
Message-ID: <1fze73d.4iy0e11h1o7ayM@geos.net.eu.org>
Organization: private
User-Agent: MacSOUP/D-2.5b3 (Mac OS 8.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux kernel maintainers,

the following problem (aka bug?) appeared in 2.4.21 and still exists in
2.4.22-rc1 (kernels prior to 2.4.21 work fine):

SETUP:
I've got a Siemens Nixdorf PCD-5T. That PC uses a Siemens D823
motherboard with dual Pentium 133 CPUs. According to lspci it has an
Intel Corp. 82434LX [Mercury/Neptune] chipset. It's an ISA/EISA/PCI
system with two IDE ports (RZ1000 chip), fd, serial, parallel, PS/2
onboard. I'm also using a PCI graphics card, an Adaptec AHA 2940 PCI
SCSI controller, a 3c509 EISA NIC and an Adlib ISA sound card. The
system is running Debian 3.0.

PROBLEM:
With 2.4.21 or 2.4.22-rc1 (both with and without SMP support included)
the system on startup does not find an IRQ for the floppy controller,
and when it comes to probing the IDE disks I get "irq probe failed" and
later "lost interrupt".

If I boot with "noapic" kernel command line option things do work.

If there's any more info I can provide (kernel configs maybe?) or things
I could test please do not hesitste to let me know.
I'd appreciate your feedback.

Georg




PS: additional Info (output from 2.4.20 dmsg; might help you?)
Please note the "IO-APIC (apicid-pin) 2-0 not connected" line. Maybe
that's the issue?

ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   0   0    1    1    71
 0a 003 03  1    1    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 133.3419 MHz.
..... host bus clock speed is 66.6704 MHz.
cpu: 0, clocks: 666704, slice: 222234
CPU0<T0:666704,T1:444464,D:6,S:222234,C:666704>
cpu: 1, clocks: 666704, slice: 222234
CPU1<T0:666704,T1:222224,D:12,S:222234,C:666704>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle



-- 
Georg Schwarz    http://home.pages.de/~schwarz/
 geos@epost.de     +49 177 8811442
