Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUDMRUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbUDMRUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:20:17 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:19426 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263585AbUDMRUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:20:00 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2
Date: Tue, 13 Apr 2004 19:22:00 +0200
User-Agent: KMail/1.6.1
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Len Brown <len.brown@intel.com>,
       ross@datscreative.com.au
References: <200404131117.31306.ross@datscreative.com.au> <20040413040145.GA3327@Sophia.soo.com> <200404131455.52195.ross@datscreative.com.au>
In-Reply-To: <200404131455.52195.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131922.00841.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some other (maybe useful) info I can give:

This is part of my system log from kernel 2.6.5-mm4 (no other patches than -mm).
The irq0 gets set to XT-PIC with this kernel version...

timer setup:

ENABLING IO-APIC IRQs
init IO_APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
 ..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.

interrupt routing:

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
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
   00 000 00  1    0    0   0   0    0    0    00
   01 001 01  0    0    0   0   0    1    1    39
   02 000 00  1    0    0   0   0    0    0    00
   03 001 01  0    0    0   0   0    1    1    41
   04 001 01  0    0    0   0   0    1    1    49
   05 001 01  0    0    0   0   0    1    1    51
   06 001 01  0    0    0   0   0    1    1    59
   07 001 01  1    0    0   0   0    1    1    61
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


Now, with 2.6.5-mm5-1, patched by hand with the io_apic.c-patch I got from Ross
(removing the declaration of extern int timer_ack in check_timer(), changing nothing else),
I get the following:

timer setup:

ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
..TIMER: Check if 8254 timer connected to IO-APIC INTIN0? ...
..TIMER: works OK on IO-APIC irq0
Using local APIC timer interrupts.

irq routing:

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
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
 02 000 00  1    0    0   0   0    0    0    00
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
IRQ0 -> 0:0
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.

cat /proc/interrupts gets me:

          CPU0
  0:     568313    IO-APIC-edge  timer
  1:       1359    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      14859    IO-APIC-edge  i8042
 14:      17983    IO-APIC-edge  ide0
 15:         92    IO-APIC-edge  ide1
 16:       2335   IO-APIC-level  ide2, saa7134[0]
 17:        142   IO-APIC-level  CMI8738
 19:      31779   IO-APIC-level  nvidia
 20:      72619   IO-APIC-level  ohci_hcd, eth0
 21:   86626041   IO-APIC-level  ehci_hcd
 22:         78   IO-APIC-level  ohci_hcd
NMI:          0
LOC:     566374
ERR:          0
MIS:          0

There is NO constant hi-load anymore, cool!

thanks, christian.

P.S: Ross, could you send a patch that could be applied using the patch-utility?
