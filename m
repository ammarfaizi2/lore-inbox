Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTLKKq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTLKKq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:46:28 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:25867 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264592AbTLKKqR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:46:17 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Thu, 11 Dec 2003 16:55:25 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com, kernel@kolivas.org,
       Ian Kumlien <pomac@vapor.com>
References: <200312072312.01013.ross@datscreative.com.au> <200312101543.39597.ross@datscreative.com.au> <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312111655.25456.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 02:06, Maciej W. Rozycki wrote:
> On Wed, 10 Dec 2003, Ross Dickson wrote:
> 
> > Relevant dmesg output from Albatron KM18G Pro ( this is different MOBO (same type) but 
> > this time has a barton core 2500 XP cpu).
> > 
> > enabled ExtINT on CPU#0
> > ESR value before enabling vector: 00000000
> > ESR value after enabling vector: 00000000
> > ENABLING IO-APIC IRQs
> > init IO_APIC IRQs
> >  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
> > ..TIMER: vector=0x31 pin1=2 pin2=-1
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC pin2
> > ..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...
> > IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
> > ..TIMER check 8259 ints disabled, imr1:ff, imr2:ff
> > ..TIMER: works OK on apic pin0 irq0
> > Using local APIC timer interrupts.
> > calibrating APIC timer ...
> > ..... CPU clock speed is 1829.0708 MHz.
> > ..... host bus clock speed is 332.0674 MHz.
> > cpu: 0, clocks: 332674, slice: 166337
> > CPU0<T0:332672,T1:166320,D:15,S:166337,C:332674>
> 
>  Hmm, while this is different from what is documented in the MP Spec, it
> looks like the 8254 IRQ is connected to INTIN0 indeed.  We can handle such
> a setup if the BIOS reports routing correctly.  Since you invoke
> io_apic_set_pci_routing() I assume you use ACPI for IRQ routing
> information.  Can you please rebuild the kernel with APIC_DEBUG set to 1
> in include/asm-i386/apic.h and send me the bootstrap log?  Can you please
> send me the output of a tool called `mptable' as well, so that I can
> compare the results?
> 
>   Maciej
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 
> 
Thanks Maciej,
bootstrap log follows

CPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff7980
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
Boot CPU = 0
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
Bus #0 is ISA
Int: type 3, pol 0, trig 0, bus 0, irq 0, 2-0
Int: type 0, pol 0, trig 0, bus 0, irq 1, 2-1
Int: type 0, pol 0, trig 0, bus 0, irq 3, 2-3
Int: type 0, pol 0, trig 0, bus 0, irq 4, 2-4
Int: type 0, pol 0, trig 0, bus 0, irq 5, 2-5
Int: type 0, pol 0, trig 0, bus 0, irq 6, 2-6
Int: type 0, pol 0, trig 0, bus 0, irq 7, 2-7
Int: type 0, pol 0, trig 0, bus 0, irq 8, 2-8
Int: type 0, pol 0, trig 0, bus 0, irq 9, 2-9
Int: type 0, pol 0, trig 0, bus 0, irq 10, 2-10
Int: type 0, pol 0, trig 0, bus 0, irq 11, 2-11
Int: type 0, pol 0, trig 0, bus 0, irq 12, 2-12
Int: type 0, pol 0, trig 0, bus 0, irq 13, 2-13
Int: type 0, pol 0, trig 0, bus 0, irq 14, 2-14
Int: type 0, pol 0, trig 0, bus 0, irq 15, 2-15
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Int: type 0, pol 1, trig 3, bus 0, irq 9, 2-9
ACPI BALANCE SET
Using ACPI (MADT) for SMP configuration information
Kernel command line: splash=silent root=/dev/hda2 hdc=ide-scsi hdclun=0
ide_setup: hdc=ide-scsi
ide_setup: hdclun=0
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Initializing CPU#0
Detected 1830.076 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3620.86 BogoMIPS
Memory: 482980k/491456k available (1800k kernel code, 8088k reserved, 622k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC pin2
..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
..TIMER check 8259 ints disabled, imr1:ff, imr2:ff
..TIMER: works OK on apic pin0 irq0
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1829.0813 MHz.
..... host bus clock speed is 332.0693 MHz.
cpu: 0, clocks: 332693, slice: 166346
CPU0<T0:332688,T1:166336,D:6,S:166346,C:332693>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=2
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs 18)
ACPI: PCI Interrupt Link [APC4] (IRQs 19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
Pin 2-23 already programmed
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:0)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:0)
00:01:06[B] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:0)
00:01:06[C] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:0)
00:01:06[D] -> 2-17 -> IRQ 17
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
Pin 2-16 already programmed
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
 10 001 01  1    1    0   0   0    1    1    D9
 11 001 01  1    1    0   0   0    1    1    E1
 12 001 01  1    1    0   0   0    1    1    C9
 13 001 01  1    1    0   0   0    1    1    D1
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
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

mptable doesn't like my bios
I tried setting bios mp versions to both 1.1 and 1.4

albatron:/usr/src/mptable-2.0.15a # ./mptable -verbose

===============================================================================

MPTable, version 2.0.15 Linux

 looking for EBDA pointer @ 0x040e, found, searching EBDA @ 0x0009fc00
 searching CMOS 'top of mem' @ 0x0009f800 (638K)
 searching default 'top of mem' @ 0x0009fc00 (639K)
 searching BIOS @ 0x000f0000

 MP FPS found in BIOS @ physical addr: 0x000f50b0

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:                     BIOS
  physical address:             0x000f50b0
  signature:                    '_MP_'
  length:                       16 bytes
  version:                      1.1
  checksum:                     0x00
  mode:                         Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:             0x0xf0c00
  signature:                    '$ml$'
  base table length:            0
  version:                      1.6
  checksum:                     0x00
  OEM ID:                       'Ä
                                  ¸§'
°öProduct ID:                   '(
m'P
  OEM table pointer:            0x12d90e22
  OEM table size:               7964
  entry count:                  7964
  local APIC address:           0x1f1c1f1c
  extended table length:        65284
  extended table checksum:      255

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
MPTABLE HOSED! record type = 55
albatron:/usr/src/mptable-2.0.15a #

Finally others working with kern 2.6  earlier trialled the following patch which may provide some
more clues: 
retrieved from:

http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch 
 
[x86] do not wrongly override mp_ExtINT IRQ

From: Mathieu <cheuche+lkml@free.fr>.

With this patch timer IRQ0 is correctly set to IO-APIC-edge
(not XT-PIC) on nForce2 boards when using APIC and ACPI.

 arch/i386/kernel/mpparse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/mpparse.c~nforce2-apic arch/i386/kernel/mpparse.c
--- linux-2.6.0-test11/arch/i386/kernel/mpparse.c~nforce2-apic	2003-12-08 00:12:25.782597272 +0100
+++ linux-2.6.0-test11-root/arch/i386/kernel/mpparse.c	2003-12-08 00:12:25.786596664 +0100
@@ -962,7 +962,8 @@ void __init mp_override_legacy_irq (
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic)
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
+			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)
+			&& (mp_irqs[i].mpc_irqtype == intsrc.mpc_irqtype)) {
 			mp_irqs[i] = intsrc;
 			found = 1;
 			break;

_

however the results were not completely successful as this posting shows it
routing through the 8259?

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/1303.html

dmesg differences: 

1. 
 after: 
 ..TIMER: vector=0x31 pin1=2 pin2=0 

before: 
 ..TIMER: vector=0x31 pin1=2 pin2=-1 

2. 
 after: 
 ...trying to set up timer (IRQ0) through the 8259A ... 
 ..... (found pin 0) ...works. 
 number of MP IRQ sources: 16. 

before: 
 ...trying to set up timer (IRQ0) through the 8259A ... failed. 
 ...trying to set up timer as Virtual Wire IRQ... failed. 
 ...trying to set up timer as ExtINT IRQ... works. 
 number of MP IRQ sources: 15. 

Perhaps someone else could get mptable to run on their machine and send you
the result.

Regards
Ross 

