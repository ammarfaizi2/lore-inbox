Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWBPVd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWBPVd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBPVd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:33:27 -0500
Received: from smtpout.mac.com ([17.250.248.72]:36586 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932134AbWBPVd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:33:26 -0500
X-PGP-Universal: processed;
	by AlPB on Thu, 16 Feb 2006 15:33:24 -0600
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <3CD81B5D-3FA4-4CA2-A171-A806FEB74A7D@mac.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mark Rustad <mrustad@mac.com>
Subject: ioapic/IRQ assignment question
Date: Thu, 16 Feb 2006 15:33:06 -0600
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into an issue switching from a 2.6.5-derived SuSE kernel  
to current 2.6.15
and later kernels. With the older kernel, PCI-X devices were being  
assigned IRQ numbers
like 79 and such. I did not observe any IRQ sharing in that  
environment. When running
current kernels, the same hardware is only using a smaller range of  
IRQ numbers and some
are shared. Is there a way to get the old behavior back? I tried  
adding apic and lapic
on the kernel command line, but that did not help.

I hope someone on the list can give me some kind of pointer to what  
affects this IRQ
assignment. I really want to avoid sharing IRQs, just like it was on  
the older SuSE
kernel. I tried things like apic=bigsmp and such, but that didn't help.

Below is dmesg output from 2.6.15 with apic=debug:

  LOWMEM available.
found SMP MP-table at 000f6800
On node 0 totalpages: 262000
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
   HighMem zone: 32624 pages, LIFO batch:7
DMI present.
Unknown genapic `apic=debug' specified.
Using APIC driver default
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6860
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @  
0x3ff72d76
ACPI: FADT (v001 INTEL  LINDHRST 0x06040000 PTL  0x00000003) @  
0x3ff77e20
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @  
0x3ff77e94
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @  
0x3ff77f48
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @  
0x3ff77f70
ACPI: MCFG (v001 PTLTD  	 MCFG   0x06040000  LTP 0x00000000) @  
0x3ff77fc0
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @  
0x3ff72db2
ACPI: DSDT (v001  Intel LINDHRST 0x06040000 MSFT 0x0100000e) @  
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
WARNING: NR_CPUS limit of 2 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 20
WARNING: NR_CPUS limit of 2 reached.  Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
ACPI: IOAPIC (id[0x05] address[0xfec84000] gsi_base[72])
IOAPIC[3]: apic_id 5, version 32, address 0xfec84000, GSI 72-95
ACPI: IOAPIC (id[0x08] address[0xfec84400] gsi_base[96])
IOAPIC[4]: apic_id 8, version 32, address 0xfec84400, GSI 96-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 5 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=/dev/md1 console=ttyS1,115200n8  
console=tty0 apic lapic apic=debug lapic=debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80400)
mapped IOAPIC to ffff9000 (fec84000)
mapped IOAPIC to ffff8000 (fec84400)
Initializing CPU#0
CPU 0 irqstacks, hard=c0441000 soft=c043f000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 3200.747 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034760k/1048000k available (2371k kernel code, 12668k  
reserved, 629k data, 296k init, 130496k highmem)
Checking if this processor honours the WP bit even in supervisor  
mode... Ok.
Calibrating delay using timer specific routine.. 6409.33 BogoMIPS  
(lpj=12818674)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000  
00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000  
0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080  
0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.20GHz stepping 04
Getting VERSION: 50014
Getting VERSION: 50014
Getting ID: 0
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0442000 soft=c0440000
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 6400.71 BogoMIPS  
(lpj=12801424)
CPU: After generic identify, caps: bfebfbff 20000000 00000000  
00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000  
0000441d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080  
0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.20GHz stepping 04
Total of 2 processors activated (12810.04 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,  
2-23, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11,  
3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22,  
3-23, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11,  
4-12, 4-13, 4-14, 4-15, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22,  
4-23, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11,  
5-12, 5-13, 5-14, 5-15, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21, 5-22,  
5-23, 8-0, 8-1, 8-2, 8-3, 8-4, 8-5, 8-6, 8-7, 8-8, 8-9, 8-10, 8-11,  
8-12, 8-13, 8-14, 8-15, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22,  
8-23 not connected.
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3200.1294 MHz.
..... host bus clock speed is 200.0081 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd830, last bus=8
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:08:01.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0.PXH0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0.PXH1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEY0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEZ0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEZ0.PXH0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEZ0.PXH1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0,  
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0,  
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
ACPI: Device [PRT] status [0000000c]: functional but not present;  
setting present
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post  
a report
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
number of IO-APIC #4 registers: 24.
number of IO-APIC #5 registers: 24.
number of IO-APIC #8 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
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
09 003 03  0    1    0   0   0    1    1    71
0a 003 03  0    0    0   0   0    1    1    79
0b 003 03  0    0    0   0   0    1    1    81
0c 003 03  0    0    0   0   0    1    1    89
0d 003 03  0    0    0   0   0    1    1    91
0e 003 03  0    0    0   0   0    1    1    99
0f 003 03  0    0    0   0   0    1    1    A1
10 000 00  1    0    0   0   0    0    0    00
11 000 00  1    0    0   0   0    0    0    00
12 000 00  1    0    0   0   0    0    0    00
13 000 00  1    0    0   0   0    0    0    00
14 000 00  1    0    0   0   0    0    0    00
15 000 00  1    0    0   0   0    0    0    00
16 000 00  1    0    0   0   0    0    0    00
17 000 00  1    0    0   0   0    0    0    00
IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 03000000
.......     : arbitration: 03
.... register #03: 00000001
.......     : Boot DT    : 1
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
10 000 00  1    0    0   0   0    0    0    00
11 000 00  1    0    0   0   0    0    0    00
12 000 00  1    0    0   0   0    0    0    00
13 000 00  1    0    0   0   0    0    0    00
14 000 00  1    0    0   0   0    0    0    00
15 000 00  1    0    0   0   0    0    0    00
16 000 00  1    0    0   0   0    0    0    00
17 000 00  1    0    0   0   0    0    0    00
IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 04000000
.......     : arbitration: 04
.... register #03: 00000001
.......     : Boot DT    : 1
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
10 000 00  1    0    0   0   0    0    0    00
11 000 00  1    0    0   0   0    0    0    00
12 000 00  1    0    0   0   0    0    0    00
13 000 00  1    0    0   0   0    0    0    00
14 000 00  1    0    0   0   0    0    0    00
15 000 00  1    0    0   0   0    0    0    00
16 000 00  1    0    0   0   0    0    0    00
17 000 00  1    0    0   0   0    0    0    00
IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 05000000
.......     : arbitration: 05
.... register #03: 00000001
.......     : Boot DT    : 1
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
10 000 00  1    0    0   0   0    0    0    00
11 000 00  1    0    0   0   0    0    0    00
12 000 00  1    0    0   0   0    0    0    00
13 000 00  1    0    0   0   0    0    0    00
14 000 00  1    0    0   0   0    0    0    00
15 000 00  1    0    0   0   0    0    0    00
16 000 00  1    0    0   0   0    0    0    00
17 000 00  1    0    0   0   0    0    0    00
IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 08000000
.......     : arbitration: 08
.... register #03: 00000001
.......     : Boot DT    : 1
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
10 000 00  1    0    0   0   0    0    0    00
11 000 00  1    0    0   0   0    0    0    00
12 000 00  1    0    0   0   0    0    0    00
13 000 00  1    0    0   0   0    0    0    00
14 000 00  1    0    0   0   0    0    0    00
15 000 00  1    0    0   0   0    0    0    00
16 000 00  1    0    0   0   0    0    0    00
17 000 00  1    0    0   0   0    0    0    00
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
PCI: Failed to allocate mem resource #9:100000@e0000000 for 0000:01:00.2
PCI: Failed to allocate mem resource #6:80000@e0000000 for 0000:02:02.1
PCI: Bridge: 0000:01:00.0
   IO window: 2000-3fff
   MEM window: dc200000-dc2fffff
   PREFETCH window: df000000-dfffffff
PCI: Bridge: 0000:01:00.2
   IO window: 4000-4fff
   MEM window: dc300000-dc3fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
   IO window: 2000-4fff
   MEM window: dc100000-dc3fffff
   PREFETCH window: df000000-dfffffff
PCI: Bridge: 0000:00:04.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:05:00.0
   IO window: 5000-5fff
   MEM window: dc500000-dc5fffff
   PREFETCH window: 50000000-500fffff
PCI: Bridge: 0000:05:00.2
   IO window: 6000-6fff
   MEM window: dc600000-dc6fffff
   PREFETCH window: 50100000-501fffff
PCI: Bridge: 0000:00:06.0
   IO window: 5000-6fff
   MEM window: dc400000-dc6fffff
   PREFETCH window: 50000000-501fffff
PCI: Bridge: 0000:00:1e.0
   IO window: 7000-7fff
   MEM window: dc700000-ddffffff
   PREFETCH window: 50200000-502fffff
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1  
Active:1)
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:05:00.0 to 64
PCI: Setting latency timer of device 0000:05:00.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x39 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
ipmi message handler version 38.0
ipmi device interface
IPMI System Interface driver.
ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca8,  
slave address 0x20
IPMI kcs interface initialized
IPMI Watchdog: driver initialized
Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
IPMI poweroff: Unable to find a poweroff function that will work,  
giving up
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 8 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
IOAPIC[1]: Set PCI routing entry (3-4 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 28 (level, low) -> IRQ 17
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
IOAPIC[1]: Set PCI routing entry (3-5 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:02:03.1[B] -> GSI 29 (level, low) -> IRQ 18
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
IOAPIC[2]: Set PCI routing entry (4-6 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 54 (level, low) -> IRQ 19
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
IOAPIC[2]: Set PCI routing entry (4-7 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 55 (level, low) -> IRQ 20
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with  
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xd1 -> IRQ 21 Mode:1  
Active:1)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 21
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:pio, hdb:pio
Probing IDE interface ide0...
hda: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
IOAPIC[1]: Set PCI routing entry (3-8 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 32 (level, low) -> IRQ 22
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
         <Adaptec AIC7902 Ultra320 SCSI adapter>
         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or  
66Mhz, 512 SCBs

   Vendor: SEAGATE   Model: ST336704LC        Rev: 0004
   Type:   Direct-Access                      ANSI SCSI revision: 03
target0:0:2: asynchronous.
scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
target0:0:2: Beginning Domain Validation
target0:0:2: wide asynchronous.
target0:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
target0:0:2: Ending Domain Validation
   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S27F
   Type:   Direct-Access                      ANSI SCSI revision: 03
target0:0:5: asynchronous.
scsi0:A:5:0: Tagged Queuing enabled.  Depth 32
target0:0:5: Beginning Domain Validation
target0:0:5: wide asynchronous.
target0:0:5: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI  
WRFLOW PCOMP (6.25 ns, offset 127)
target0:0:5: Ending Domain Validation
   Vendor: SUPER     Model: GEM318            Rev: 0
   Type:   Processor                          ANSI SCSI revision: 02
target0:0:6: asynchronous.
target0:0:6: Beginning Domain Validation
target0:0:6: Ending Domain Validation
SCSI device sda: 71687369 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71687369 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write through
sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:2:0: Attached scsi disk sda
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
sd 0:0:5:0: Attached scsi disk sdb
sd 0:0:2:0: Attached scsi generic sg0 type 0
sd 0:0:5:0: Attached scsi generic sg1 type 0
0:0:6:0: Attached scsi generic sg2 type 3
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1  
Active:1)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdc001000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xe9 -> IRQ 24 Mode:1  
Active:1)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 24
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 24, io base 0x00001420
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 21, io base 0x00001440
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001460
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
/usr/src/linux-2.6.15/drivers/usb/input/hid-core.c: v2.6:USB HID core  
driver
i2c /dev entries driver
lm93: disabled SMBus block data transactions
lm93: attaching to lm93.0 at 0,0x2e
input: AT Translated Set 2 keyboard as /class/input/input0
md: raid1 personality registered as nr 3
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda3 has different UUID to sdb6
md: sda2 has different UUID to sdb6
md: created md3
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
raid1: raid set md3 active with 2 out of 6 mirrors
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb3 has different UUID to sdb5
md: sdb2 has different UUID to sdb5
md:  adding sda5 ...
md: sda3 has different UUID to sdb5
md: sda2 has different UUID to sdb5
md: created md2
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
raid1: raid set md2 active with 2 out of 6 mirrors
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md1 active with 2 out of 6 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md0 active with 2 out of 6 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 296k freed
EXT3 FS on md1, internal journal
md: raidstart(pid 88) used deprecated START_ARRAY ioctl. This will  
not be supported beyond July 2006
md: could not bd_claim sda2.
md: autostart failed!
md: raidstart(pid 88) used deprecated START_ARRAY ioctl. This will  
not be supported beyond July 2006
md: could not bd_claim sda3.
md: autostart failed!
md: raidstart(pid 88) used deprecated START_ARRAY ioctl. This will  
not be supported beyond July 2006
md: could not bd_claim sda5.
md: autostart failed!
md: could not bd_claim sda6.
md: autostart failed!
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2097136k swap on /dev/md2.  Priority:42 extents:1 across:2097136k
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present

-- 
Mark Rustad, MRustad@mac.com

