Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318072AbSHCWg2>; Sat, 3 Aug 2002 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSHCWg1>; Sat, 3 Aug 2002 18:36:27 -0400
Received: from feline.chl.chalmers.se ([129.16.214.88]:6404 "EHLO
	feline.chl.chalmers.se") by vger.kernel.org with ESMTP
	id <S318072AbSHCWgS>; Sat, 3 Aug 2002 18:36:18 -0400
Date: Sun, 4 Aug 2002 00:39:48 +0200 (CEST)
From: Fredrik Ohrn <ohrn@chl.chalmers.se>
To: linux-kernel@vger.kernel.org
Subject: "Probably buggy MP table." on a ServerWorks mobo.
Message-ID: <Pine.LNX.4.44.0208040010001.1052-100000@feline.chl.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I have salvaged a "Sun GigabitEthernet/P 2.0" adapter from a retired Sun 
box which I thought I'd to put to some good use. But...

Insmoding the sungem driver fails with the following messages:

First try:

Aug  3 15:35:27 olivia kernel: sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
Aug  3 15:35:27 olivia kernel: PCI: Enabling device 01:02.0 (0014 -> 0016)
Aug  3 15:35:27 olivia kernel: PCI: No IRQ known for interrupt pin A of device 01:02.0. Probably buggy MP table.
Aug  3 15:35:27 olivia kernel: eth2: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:00:00:00:00:00

Second try:

Aug  3 17:55:58 olivia kernel: sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
Aug  3 17:55:58 olivia kernel: PCI: No IRQ known for interrupt pin A of device 01:02.0. Probably buggy MP table.
Aug  3 17:55:58 olivia kernel: gem: SW reset is ghetto.
Aug  3 17:55:58 olivia kernel: gem: GEM has bogus fifo sizes tx(-64) rx(-64)



So, any gurus out there who can speculate in what when wrong and what to 
do about it?

Any hints on how to get this beast working is greatly appreciated, please 
CC me as I'm not on the list.


Regards,
Fredrik





Grizzly system details:

Vanilla 2.4.19 kernel.

Asus TR-DLS mobo, ServerWorks chipset, fitted with 2 Pentium III

The ethernet card is 64-bit and it sits in a 64 bit PCI slot.
Snippet from /proc/pci:

  Bus  1, device   2, function  0:
    Ethernet controller: Sun Microsystems Computer Corp. GEM (rev 1).
      Master Capable.  Latency=32.  Min Gnt=64.Max Lat=64.
      Non-prefetchable 32 bit memory at 0xf5800000 [0xf59fffff].


Things in dmesg that looks kinda relevant:

 After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
Total of 2 processors activated (5059.37 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 6 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 6 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-10, 5-2, 5-3, 5-4, 5-6, 5-7, 5-8, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15, 6-0, 6-1, 6-2, 6-3, 6-4, 6-5, 6-6, 6-7, 6-8, 6-9, 6-10, 6-11, 6-12, 6-13, 6-14, 6-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 18.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
number of IO-APIC #6 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 003 03  1    1    0   1   0    1    1    69
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    91
 01 003 03  1    1    0   1   0    1    1    99
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 003 03  1    1    0   1   0    1    1    A1
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 003 03  1    1    0   1   0    1    1    A9
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #6......
.... register #00: 06000000
.......    : physical APIC id: 06
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ21 -> 1:5
IRQ25 -> 1:9
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1266.7305 MHz.
..... host bus clock speed is 133.3396 MHz.
cpu: 0, clocks: 1333396, slice: 444465
CPU0<T0:1333392,T1:888912,D:15,S:444465,C:1333396>
cpu: 1, clocks: 1333396, slice: 444465
CPU1<T0:1333392,T1:444448,D:14,S:444465,C:1333396>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf1d00, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI->APIC IRQ transform: (B0,I5,P0) -> 17
PCI->APIC IRQ transform: (B0,I6,P0) -> 16
PCI->APIC IRQ transform: (B0,I6,P1) -> 25
PCI->APIC IRQ transform: (B0,I7,P0) -> 25
PCI->APIC IRQ transform: (B0,I15,P0) -> 11
PCI->APIC IRQ transform: (B1,I3,P0) -> 21


So, any guru's out there who can lend me a helping hand?



-- 
   "It is easy to be blinded to the essential uselessness of computers by
   the sense of accomplishment you get from getting them to work at all."
                                                   - Douglas Adams

Fredrik Öhrn                               Chalmers University of Technology
ohrn@chl.chalmers.se                                                  Sweden

