Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUDML6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDML6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 07:58:52 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:18093 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263370AbUDML6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 07:58:48 -0400
Message-ID: <407BD5EA.9050004@tu-harburg.de>
Date: Tue, 13 Apr 2004 13:58:34 +0200
From: Christian Kroener <christian.kroener@tu-harburg.de>
Organization: TUHH
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.4) Gecko/20030730
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ross@datscreative.com.au, macro@ds2.pg.gda.pl, len.brown@intel.com
Subject: Re: IO-APIC on nforce2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks very much for the replies... Ross, I will test your patch as soon 
as I get home.
Some more infos: my machine worked pretty well and stable even with the 
irq0 as XT-PIC. Though I worried about the constant hi-load I got.
At the moment, using 2.6.4-ck2 patched only with the io_apic.c-diff from 
Ross I get this output on system-log:

ENABLING IO-APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 
not connected.
A..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
..TIMER: Is timer irq0 connected to IO-APIC INTIN0?...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
..TIMER: works OK on IO-APIC INTIN0 irq0
Using local APIC timer interrupts.
calibrating APIC timer ...

cat /proc/interrupts gives me:

           CPU0      
  0:   13681442    IO-APIC-edge  timer
  1:         35    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       2054    IO-APIC-edge  i8042
 14:      81623    IO-APIC-edge  ide0
 15:         87    IO-APIC-edge  ide1
 16:       2397   IO-APIC-level  ide2, saa7134[0]
 17:        156   IO-APIC-level  CMI8738
 19:    1161008   IO-APIC-level  nvidia
 20:    3050303   IO-APIC-level  ohci_hcd, eth0
 21: 2316037857   IO-APIC-level  ehci_hcd
 22:         76   IO-APIC-level  ohci_hcd
NMI:          0
LOC:   13633382
ERR:          0
MIS:          0

irq-routing:

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
00 001 01  0    0    0   0   0    1    1    31
01 001 01  0    0    0   0   0    1    1    39
02 000 00  0    0    0   0   0    0    0    00
03 001 01  0    0    0   0   0    1    1    41
04 001 01  0    0    0   0   0    1    1    49
05 001 01  0    0    0   0   0    1    1    51
06 001 01  0    0    0   0   0    1    1    59
07 001 01  0    0    0   0   0    1    1    61
08 001 01  0    0    0   0   0    1    1    69
09 001 01  0    1    0   0   0    1    1    71
0a 001 01  0    0    0   0   0    1    1    79
0b 001 01  0    0    0   0   0    1    1    81
0c 001 01  0    0    0   0   0    1    1    89
0d 001 01  0    0    0   0   0    1    1    91
0e 001 01  0    0    0   0   0    1    1    99
0f 001 01  0    0    0   0   0    1    1    A1
10 001 01  1    1    0   0   0    1    1    D1
11 001 01  1    1    0   0   0    1    1    D9
12 001 01  1    1    0   0   0    1    1    E1
13 001 01  1    1    0   0   0    1    1    C9
14 001 01  1    1    0   0   0    1    1    B1
15 001 01  1    1    0   0   0    1    1    C1
16 001 01  1    1    0   0   0    1    1    B9
17 001 01  1    1    0   0   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2-> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23

Maybe some of the copy+paste wrent wrong (sucky Mozilla mail here).

Earlier versions of -mm reported setting irq0 as virtual wire irq worked 
and I didnt experience any uncommon hi-load with them. -mm latest sets 
the timer irq as ExtINT, resulting in these strange constant hi-loads.

I will report results of testing your patch later, Ross.
thanks, christian.



