Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266086AbUFQCaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbUFQCaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 22:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUFQCaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 22:30:05 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:16513 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266086AbUFQC27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 22:28:59 -0400
Date: Wed, 16 Jun 2004 22:28:39 -0400
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040617022839.GC14663@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org> <20040616021633.GB13672@porto.bmb.uga.edu> <20040616125754.GF6627@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616125754.GF6627@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had another go at this with 2.6.7.  I tried some different things
this time.

First I tried taring the filesystem, and that went OK.  Then I tried find
-exec cat and that was OK, too.  Next I did cat /dev/md0, and when that
was OK I did cat /dev/vg0/home and that also worked.  Interestingly, cat
/dev/md0 gets about 120-130MB/s throughput whereas cat /dev/vg0/home
only gets 60-70MB/s.

Fianlly I tried dump again and that hung right away, trace below.  I
also got an ls hung before I made the trace, but that doesn't seem to
show anything new.

A possibly interesting note about the serial console: when I triggered
the trace, apcupsd lost communication with the UPS, which is using the
other serial port (this is while the trace was printing to the console).
Communication resumed when it was done printing.  The serial ports don't
share an interrupt, with each other or anything else.

There was no ethernet grief when I rebooted.


Bootdata ok (command line is BOOT_IMAGE=linux ro root=851 console=ttyS0,19200n8 single)
Linux version 2.6.7 (root@carignan) (gcc version 3.3.4 (Debian)) #1 SMP Wed Jun 16 02:55:47 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007fff0000
No mptable found.
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262128
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262128 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x00000000000f4680
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000318 MSFT 0x00000097) @ 0x000000007fff0100
ACPI: FADT (v001 A M I  OEMFACP  0x06000318 MSFT 0x00000097) @ 0x000000007fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x06000318 MSFT 0x00000097) @ 0x000000007fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000318 MSFT 0x00000097) @ 0x000000007ffff040
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000007fff3530
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebfe000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebff000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 1ee0000000 size 64 MB
Aperture from northbridge cpu 0 beyond 4GB. Ignoring.
No AGP bridge found
Built 2 zonelists
Kernel command line: BOOT_IMAGE=linux ro root=851 console=ttyS0,19200n8 single
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1394.599 MHz processor.
Console: colour VGA+ 80x25
Memory: 2062532k/2097088k available (2541k kernel code, 0k reserved, 1205k data, 180k init)
Calibrating delay loop... 2736.12 BogoMIPS
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 1023.75 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10040e3ff58
Initializing CPU#1
Calibrating delay loop... 2785.28 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 01
Total of 2 processors activated (5521.40 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.451 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 01
  groups: 01
  domain 1: span 03
   groups: 01 02
CPU1:  online
 domain 0: span 02
  groups: 02
  domain 1: span 03
   groups: 02 01
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:07[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:07[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:07[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:07[D] -> 2-19 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (3-3 -> 0xc9 -> IRQ 27 Mode:1 Active:1)
00:02:08[A] -> 3-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (3-0 -> 0xd1 -> IRQ 24 Mode:1 Active:1)
00:02:08[B] -> 3-0 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xd9 -> IRQ 25 Mode:1 Active:1)
00:02:08[C] -> 3-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xe1 -> IRQ 26 Mode:1 Active:1)
00:02:08[D] -> 3-2 -> IRQ 26
IOAPIC[2]: Set PCI routing entry (4-0 -> 0xe9 -> IRQ 28 Mode:1 Active:1)
00:01:03[A] -> 4-0 -> IRQ 28
IOAPIC[2]: Set PCI routing entry (4-1 -> 0x32 -> IRQ 29 Mode:1 Active:1)
00:01:03[B] -> 4-1 -> IRQ 29
IOAPIC[2]: Set PCI routing entry (4-2 -> 0x3a -> IRQ 30 Mode:1 Active:1)
00:01:03[C] -> 4-2 -> IRQ 30
IOAPIC[2]: Set PCI routing entry (4-3 -> 0x42 -> IRQ 31 Mode:1 Active:1)
00:01:03[D] -> 4-3 -> IRQ 31
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    D1
 01 001 01  1    1    0   1   0    1    1    D9
 02 001 01  1    1    0   1   0    1    1    E1
 03 001 01  1    1    0   1   0    1    1    C9

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    E9
 01 001 01  1    1    0   1   0    1    1    32
 02 001 01  1    1    0   1   0    1    1    3A
 03 001 01  1    1    0   1   0    1    1    42
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 2:0
IRQ29 -> 2:1
IRQ30 -> 2:2
IRQ31 -> 2:3
.................................... done.
PCI: Using ACPI for IRQ routing
PCI-DMA: Disabling IOMMU.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.6 (June 12, 2004)
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d6:c9
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d6:ca
eth1: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
sym0: <875> rev 0x26 at pci 0000:03:04.0 irq 16
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: SONY      Model: SDX-400C          Rev: 0702
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi(0:0:4:0): Beginning Domain Validation
sym0:4: wide asynchronous.
sym0:4: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
scsi(0:0:4:0): Domain Validation skipping write tests
scsi(0:0:4:0): Ending Domain Validation
  Vendor: OVERLAND  Model: LIBRARYPRO        Rev: 0417
  Type:   Medium Changer                     ANSI SCSI revision: 02
scsi(0:0:6:0): Beginning Domain Validation
sym0:6: wide asynchronous.
sym0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 15)
scsi(0:0:6:0): Domain Validation skipping write tests
scsi(0:0:6:0): Ending Domain Validation
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 1
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 8
Fusion MPT base driver 3.01.06
Copyright (c) 1999-2004 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.06
scsi1 : ioc0: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=24
  Vendor: SUPER     Model: GEM318            Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi generic sg2 at scsi1, channel 0, id 8, lun 0,  type 3
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi1, channel 0, id 9, lun 0
Attached scsi generic sg3 at scsi1, channel 0, id 9, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 10, lun 0
Attached scsi generic sg4 at scsi1, channel 0, id 10, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdc: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi1, channel 0, id 11, lun 0
Attached scsi generic sg5 at scsi1, channel 0, id 11, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdd: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi1, channel 0, id 12, lun 0
Attached scsi generic sg6 at scsi1, channel 0, id 12, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sde: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sde: drive cache: write back
 sde: sde1
Attached scsi disk sde at scsi1, channel 0, id 13, lun 0
Attached scsi generic sg7 at scsi1, channel 0, id 13, lun 0,  type 0
scsi2 : ioc1: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=25
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdf: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdf: drive cache: write back
 sdf: sdf1 sdf2 sdf3 sdf4
Attached scsi disk sdf at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg8 at scsi2, channel 0, id 0, lun 0,  type 0
USB Universal Host Controller Interface driver v2.2
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   generic_sse:  4256.000 MB/sec
raid5: using function: generic_sse (4256.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sde1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: running: <sde1><sdd1><sdc1><sdb1><sda1>
raid5: device sde1 operational as raid disk 4
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 5300kB for md0
raid5: raid level 5 set md0 active with 5 out of 5 devices, algorithm 2
RAID5 conf printout:
 --- rd:5 wd:5 fd:0
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
 disk 4, o:1, dev:sde1
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 2097136k swap on /dev/sdf2.  Priority:-1 extents:1
EXT3 FS on sdf1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdf3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-32, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-34, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-33, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-35, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-15, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-16, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-17, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-18, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-19, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-20, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-21, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-22, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-23, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-24, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-25, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-26, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-27, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-28, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-29, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-30, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-31, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)
bonding: MII link monitoring set to 100 ms
bonding: bond0: enslaving eth0 as an active interface with a down link.
bonding: bond0: enslaving eth1 as an active interface with a down link.
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is off for TX and off for RX.
bonding: bond0: link status definitely up for interface eth0.
bonding: bond0: link status definitely up for interface eth1.
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
SCSI-3 Opcodes & ASC/ASCQ Strings 3.01.06
mptbase: English readable SCSI-3 strings enabled:-)
isense: Registered SCSI-3 Opcodes & ASC/ASCQ Strings
st0: Block limits 2 - 16777215 bytes.
rpc.mountd[752]: segfault at 000000004b87ad6e rip 00000000080503e9 rsp 00000000ffffd684 error 4
nfsd: last server has exited
nfsd: unexporting all filesystems
rpc.mountd[3959]: segfault at 000000004b87ad6e rip 00000000080503e9 rsp 00000000ffffd494 error 4
nfsd: last server has exited
nfsd: unexporting all filesystems
rpc.mountd[3996]: segfault at 000000004b87ad6e rip 00000000080503e9 rsp 00000000ffffd494 error 4
nfsd: last server has exited
nfsd: unexporting all filesystems
rpciod: active tasks at shutdown?!
RPC: error 5 connecting to server localhost
RPC: failed to contact portmap (errno -5).
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 00003e2596edc7f2     0     1      0     2               (NOTLB)
000001003ff8fd88 0000000000000006 0000007800000002 000001007ff9b070 
       0000000000000626 ffffffff803e23e0 000001007ff9b388 0000000000000246 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff801918ca>{do_select+906} 
       <ffffffff80186c64>{vfs_stat+68} <ffffffff80191380>{__pollwait+0} 
       <ffffffff80186bcb>{vfs_getattr+59} <ffffffff801ab8a1>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
migration/0   S 0000000000000000     0     2      1             3       (L-TLB)
0000010040e73ed8 0000000000000046 00000074349d5cc8 000001007ff9a030 
       00000000000001ec 000001003e29e8d0 000001007ff9a348 00000100349d5cb8 
       00000100349d5cc0 0000000000000000 
Call Trace:<ffffffff8013487c>{migration_thread+236} <ffffffff80134790>{migration_thread+0} 
       <ffffffff80134790>{migration_thread+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff80134790>{migration_thread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
ksoftirqd/0   S 0000000000000000     0     3      1             4     2 (L-TLB)
0000010040e71f08 0000000000000046 0000007d40e71e98 0000010001e6d0b0 
       00000000000000b7 000001003e61b370 0000010001e6d3c8 0000010040e71e98 
       0000010001e12b20 0000000000000000 
Call Trace:<ffffffff8013d0ff>{tasklet_action+111} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8013d2df>{ksoftirqd+63} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
migration/1   S 0000000000000000     0     4      1             5     3 (L-TLB)
0000010001e6bed8 0000000000000046 000000795435fcc8 0000010001e6c890 
       00000000000000fc 000001007ed104b0 0000010001e6cba8 000001005435fcb8 
       000001005435fcc0 0000000000000001 
Call Trace:<ffffffff8013487c>{migration_thread+236} <ffffffff80134790>{migration_thread+0} 
       <ffffffff80134790>{migration_thread+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff80134790>{migration_thread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
ksoftirqd/1   S 00003e1fba66ad5c     0     5      1             6     4 (L-TLB)
0000010001e69f08 0000000000000046 0000010001e69e98 0000010001e6c070 
       000000000000010f 000001007ff9a850 0000010001e6c388 0000010001e69e98 
       0000010040e1e9a0 0000000000000000 
Call Trace:<ffffffff8013d0ff>{tasklet_action+111} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8013d2df>{ksoftirqd+63} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
events/0      R  running task       0     6      1     8       7     5 (L-TLB)
events/1      S 00003e267f613016     0     7      1            42     6 (L-TLB)
000001007ff7fe58 0000000000000046 0000007300000212 0000010040e408d0 
       000000000000039f 000001007ff9a850 0000010040e40be8 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff803774bc>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
khelper       S 000000067c85eea7     0     8      6             9       (L-TLB)
0000010001e4fe58 0000000000000046 000001007f459d38 0000010040e400b0 
       000000000000024d 000001007ff9a850 0000010040e403c8 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801115ef>{child_rip+0} <ffffffff80149df5>{worker_thread+261} 
       <ffffffff803774bc>{thread_return+41} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8014e540>{keventd_create_kthread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
kacpid        S 00000000087a440f     0     9      6            40     8 (L-TLB)
000001007fefde58 0000000000000046 000001007fefde18 0000010001e8d130 
       0000000000002db2 000001007ff9a850 0000010001e8d448 0000000000000001 
       0000000000010000 0000010001e8d130 
Call Trace:<ffffffff80146273>{do_sigaction+659} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff80149df5>{worker_thread+261} <ffffffff803774bc>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
kblockd/0     S 00003e224ad18831     0    40      6            41     9 (L-TLB)
0000010001fb9e58 0000000000000046 0000010040e59800 000001007fec29d0 
       000000000000010b ffffffff803e23e0 000001007fec2ce8 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff803774bc>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
kblockd/1     S 00003e266f08347a     0    41      6            54    40 (L-TLB)
000001007fe95e58 0000000000000046 0000007300000202 000001007fec21b0 
       000000000000004f 0000010001fe8a50 000001007fec24c8 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff803774bc>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
khubd         S 000000001a81861e     0    42      1            56     7 (L-TLB)
000001007fe63f08 0000000000000046 0000000000000000 000001007febf230 
       0000000000002cc2 000001007ff9a850 000001007febf548 0000000000000000 
       0000000000000000 0000000000000216 
Call Trace:<ffffffff802d18b1>{hub_thread+161} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff802d1810>{hub_thread+0} 
       <ffffffff801115ef>{child_rip+0} 
pdflush       S 00000000242315c5     0    54      6            55    41 (L-TLB)
0000010001f77e98 0000000000000046 0000006a01e0f760 0000010001fce2f0 
       0000000000000622 0000010040e410f0 0000010001fce608 0000010040e410f0 
       0000010001e0f760 0000010001e100a0 
Call Trace:<ffffffff8015cae0>{pdflush+0} <ffffffff8015c8c5>{__pdflush+261} 
       <ffffffff8015cae0>{pdflush+0} <ffffffff8015cafc>{pdflush+28} 
       <ffffffff8015cae0>{pdflush+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8014e540>{keventd_create_kthread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
pdflush       S 00003e266dbb5896     0    55      6            58    54 (L-TLB)
000001007fe5fe98 0000000000000046 0000007300000000 0000010001fceb10 
       000000000000055d 0000010001fe8a50 0000010001fcee28 0000000000000000 
       000001007fe5fe18 00000000000003cb 
Call Trace:<ffffffff8015cae0>{pdflush+0} <ffffffff8015c8c5>{__pdflush+261} 
       <ffffffff8015cae0>{pdflush+0} <ffffffff8015cafc>{pdflush+28} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
kswapd1       S 00003e1d6861ae1a     0    56      1            57    42 (L-TLB)
0000010001f75eb8 0000000000000046 0000000000000000 0000010001fcf330 
       0000000000022d38 000001007ff9a850 0000010001fcf648 0000000000000202 
       00000000000000ef 0000000000000000 
Call Trace:<ffffffff80164af2>{balance_pgdat+2} <ffffffff80164e6f>{kswapd+239} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff80131321>{schedule_tail+17} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80164d80>{kswapd+0} <ffffffff801115ef>{child_rip+0} 
       
kswapd0       S 0000000000000000     0    57      1           170    56 (L-TLB)
000001007fe5deb8 0000000000000046 0000007500000000 000001007feba2b0 
       00000000000227e7 0000010001e8c910 000001007feba5c8 0000000000000202 
       00000000000000eb 0000000000000100 
Call Trace:<ffffffff80164e6f>{kswapd+239} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff80131321>{schedule_tail+17} 
       <ffffffff801115f7>{child_rip+8} <ffffffff80164d80>{kswapd+0} 
       <ffffffff801115ef>{child_rip+0} 
aio/0         S 0000000000000000     0    58      6            59    55 (L-TLB)
000001007fe4be58 0000000000000046 0000006b7fe4be18 000001007febaad0 
       000000000000044b 0000010040e410f0 000001007febade8 0000000000000001 
       0000000000010000 000001007febaad0 
Call Trace:<ffffffff80146273>{do_sigaction+659} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff80149df5>{worker_thread+261} <ffffffff803774bc>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
aio/1         S 0000000024252125     0    59      6                  58 (L-TLB)
0000010001f73e58 0000000000000046 0000010001f73e18 000001007febb2f0 
       000000000000147f 000001007ff9a850 000001007febb608 0000000000000001 
       0000000000010000 000001007febb2f0 
Call Trace:<ffffffff80146273>{do_sigaction+659} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff80149df5>{worker_thread+261} <ffffffff803774bc>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
scsi_eh_0     S 000000005fdbff82     0   170      1           188    57 (L-TLB)
000001003fdcde28 0000000000000046 0000000000000246 000001007fec71b0 
       0000000000003031 000001007ff9a850 000001007fec74c8 0000000035c1a774 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80376d2d>{__down_interruptible+301} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133493>{__wake_up_common+67} <ffffffff8037806b>{__down_failed_interruptible+53} 
       <ffffffff80298e53>{.text.lock.scsi_error+213} <ffffffff801115f7>{child_rip+8} 
       <ffffffff802989b0>{scsi_error_handler+0} <ffffffff801115ef>{child_rip+0} 
       
scsi_eh_1     S 00000002446c8a8a     0   188      1           218   170 (L-TLB)
000001003fdade28 0000000000000046 0000000000000246 000001007feea950 
       0000000000002664 000001007ff9a850 000001007feeac68 000000003cab9668 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80376d2d>{__down_interruptible+301} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133493>{__wake_up_common+67} <ffffffff8037806b>{__down_failed_interruptible+53} 
       <ffffffff80298e53>{.text.lock.scsi_error+213} <ffffffff801115f7>{child_rip+8} 
       <ffffffff802989b0>{scsi_error_handler+0} <ffffffff801115ef>{child_rip+0} 
       
scsi_eh_2     S 0000000316deda1b     0   218      1           230   188 (L-TLB)
0000010001fd3e28 0000000000000046 0000000000000246 000001007feeb170 
       0000000000002588 000001007ff9a850 000001007feeb488 000000003ccbede4 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80376d2d>{__down_interruptible+301} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133493>{__wake_up_common+67} <ffffffff8037806b>{__down_failed_interruptible+53} 
       <ffffffff80298e53>{.text.lock.scsi_error+213} <ffffffff801115f7>{child_rip+8} 
       <ffffffff802989b0>{scsi_error_handler+0} <ffffffff801115ef>{child_rip+0} 
       
kseriod       S 0000000416e9c96d     0   230      1           238   218 (L-TLB)
000001007feb9ef8 0000000000000046 0000006900000000 000001007fec6170 
       00000000178bebc3 0000010040e400b0 000001007fec6488 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff802edc34>{serio_thread+244} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80131321>{schedule_tail+17} <ffffffff801115f7>{child_rip+8} 
       <ffffffff802edb40>{serio_thread+0} <ffffffff801115ef>{child_rip+0} 
       
md0_raid5     S 00003e2670610809     0   238      1           239   230 (L-TLB)
000001007f7fdee8 0000000000000046 0000000000000202 0000010001fe8a50 
       0000000000000088 000001007ff9a850 0000010001fe8d68 000001003ffd5948 
       000001003ffd5980 000001003ffd59f4 
Call Trace:<ffffffff802fdcaa>{raid5d+490} <ffffffff80303dc1>{md_thread+417} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80131321>{schedule_tail+17} 
       <ffffffff802fdac0>{raid5d+0} <ffffffff801115f7>{child_rip+8} 
       <ffffffff802fdac0>{raid5d+0} <ffffffff80303c20>{md_thread+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00003e255708fbc8     0   239      1           560   238 (L-TLB)
000001007f7dde38 0000000000000046 000000747f7ddde8 000001007feea130 
       00000000000002d8 ffffffff803e23e0 000001007feea448 0000000000000001 
       0000000000000003 000001003ffbdac8 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000026122613b858     0   560      1           561   239 (L-TLB)
000001003f309e38 0000000000000046 000001007eafbec0 000001007f7a8b50 
       00000000000032f9 ffffffff803e23e0 000001007f7a8e68 0000000000000001 
       0000000000000003 000001003ffaccc8 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00002b440172e760     0   561      1           562   560 (L-TLB)
000001003e7b7e38 0000000000000046 000000763e7b7de8 000001007f6c73f0 
       0000000000001ffe 000001007ff9a850 000001007f6c7708 0000000000000001 
       0000000000000003 000001003ffacac8 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00002760eb1bb445     0   562      1           563   561 (L-TLB)
000001003e271e38 0000000000000046 000001003e271de8 000001007f6c63b0 
       00000000000021e0 000001007ff9a850 000001007f6c66c8 0000000000000001 
       0000000000000003 000001003ffac8c8 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   563      1           564   562 (L-TLB)
000001003e03fe38 0000000000000046 000000763e03fde8 000001007f63ac50 
       00000000000016a2 000001007f6904b0 000001007f63af68 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   564      1           565   563 (L-TLB)
000001003e7fde38 0000000000000046 000000763e7fdde8 000001007f64e3f0 
       00000000000016b9 000001007f6904b0 000001007f64e708 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00003e2557d33302     0   565      1           566   564 (L-TLB)
000001003dff3e38 0000000000000046 0000010067094560 000001007f6334b0 
       00000000000006d3 000001007ff9a850 000001007f6337c8 0000000000000001 
       0000000000000003 000001003ffac2c8 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   566      1           567   565 (L-TLB)
000001003dff1e38 0000000000000046 000000763dff1de8 000001007f6d4b90 
       0000000000001813 000001007f6904b0 000001007f6d4ea8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   567      1           568   566 (L-TLB)
000001003f43fe38 0000000000000046 000000763f43fde8 000001007f63b470 
       000000000000164e 000001007f6904b0 000001007f63b788 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00003e20834b0b52     0   568      1           569   567 (L-TLB)
000001003f271e38 0000000000000046 000000763f271de8 000001007f632470 
       0000000000000406 000001007ff9a850 000001007f632788 0000000000000001 
       0000000000000003 000001007feb74c8 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   569      1           570   568 (L-TLB)
000001003e583e38 0000000000000046 000000763e583de8 000001007f6914f0 
       000000000000184a 000001007f6904b0 000001007f691808 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   570      1           571   569 (L-TLB)
000001003e0fde38 0000000000000046 000000763e0fdde8 000001007f690cd0 
       0000000000001662 000001007f6904b0 000001007f690fe8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   571      1           572   570 (L-TLB)
000001003ff83e38 0000000000000046 000000763ff83de8 000001007f632c90 
       0000000000001843 000001007f6904b0 000001007f632fa8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   572      1           573   571 (L-TLB)
000001003ff81e38 0000000000000046 000000763ff81de8 000001007f641530 
       0000000000001827 000001007f6904b0 000001007f641848 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   573      1           574   572 (L-TLB)
000001003e69fe38 0000000000000046 000000763e69fde8 000001007f63a430 
       0000000000001767 000001007f6904b0 000001007f63a748 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   574      1           575   573 (L-TLB)
000001003e90de38 0000000000000046 000000763e90dde8 0000010001fe8230 
       0000000000001658 000001007f6904b0 0000010001fe8548 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   575      1           576   574 (L-TLB)
000001003e7bbe38 0000000000000046 000000763e7bbde8 000001007f7a9370 
       000000000000176b 000001007f6904b0 000001007f7a9688 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   576      1           577   575 (L-TLB)
000001003e389e38 0000000000000046 000000763e389de8 0000010001fe9270 
       0000000000001945 000001007f6904b0 0000010001fe9588 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000005ebfdef22     0   577      1           578   576 (L-TLB)
000001003e34fe38 0000000000000046 000001003e34fde8 000001007f7a8330 
       0000000001bb1857 000001007ff9a850 000001007f7a8648 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000000064d0606d4     0   578      1           579   577 (L-TLB)
000001003e349e38 0000000000000046 000001003e349de8 000001003e34b570 
       000000003ccbf700 000001007ff9a850 000001003e34b888 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   579      1           580   578 (L-TLB)
000001003e64fe38 0000000000000046 000000763e64fde8 000001003e34ad50 
       00000000000023f3 000001007f6904b0 000001003e34b068 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   580      1           581   579 (L-TLB)
000001003dffde38 0000000000000046 000000763dffdde8 000001003e34a530 
       0000000000001bf7 000001007f6904b0 000001003e34a848 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   581      1           582   580 (L-TLB)
000001003f28fe38 0000000000000046 000000763f28fde8 000001003e0f15b0 
       0000000000001b47 000001007f6904b0 000001003e0f18c8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   582      1           583   581 (L-TLB)
000001003e7a5e38 0000000000000046 000000763e7a5de8 000001003e0f0d90 
       0000000000001936 000001007f6904b0 000001003e0f10a8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   583      1           584   582 (L-TLB)
000001003eaa3e38 0000000000000046 000000763eaa3de8 000001003e0f0570 
       0000000000001929 000001007f6904b0 000001003e0f0888 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   584      1           585   583 (L-TLB)
000001003e73de38 0000000000000046 000000763e73dde8 000001003e73f5f0 
       0000000000001784 000001007f6904b0 000001003e73f908 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   585      1           586   584 (L-TLB)
000001003e943e38 0000000000000046 000000763e943de8 000001003e73edd0 
       0000000000001720 000001007f6904b0 000001003e73f0e8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   586      1           587   585 (L-TLB)
000001003e1d9e38 0000000000000046 000000763e1d9de8 000001003e73e5b0 
       00000000000018b2 000001007f6904b0 000001003e73e8c8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   587      1           588   586 (L-TLB)
000001003e153e38 0000000000000046 000000763e153de8 000001003e155630 
       00000000000018de 000001007f6904b0 000001003e155948 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   588      1           589   587 (L-TLB)
000001003e2f1e38 0000000000000046 000000763e2f1de8 000001003e154e10 
       000000000000194e 000001007f6904b0 000001003e155128 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   589      1           590   588 (L-TLB)
000001003f1e7e38 0000000000000046 000000763f1e7de8 000001003e1545f0 
       00000000000016eb 000001007f6904b0 000001003e154908 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   590      1           591   589 (L-TLB)
000001003f1e1e38 0000000000000046 000000773f1e1de8 000001003f1e3670 
       000000000000181b 000001007f6904b0 000001003f1e3988 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   591      1           592   590 (L-TLB)
000001003e577e38 0000000000000046 000000773e577de8 000001003f1e2e50 
       000000000000179c 000001007f6904b0 000001003f1e3168 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   592      1           593   591 (L-TLB)
000001003e455e38 0000000000000046 000000773e455de8 000001003f1e2630 
       00000000000016ba 000001007f6904b0 000001003f1e2948 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   593      1           594   592 (L-TLB)
000001003e39fe38 0000000000000046 000000773e39fde8 000001003e4516b0 
       00000000000017b9 000001007f6904b0 000001003e4519c8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   594      1           595   593 (L-TLB)
000001003e1bde38 0000000000000046 000000773e1bdde8 000001003e450e90 
       00000000000015fd 000001007f6904b0 000001003e4511a8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000006691aead7     0   595      1           596   594 (L-TLB)
000001003e4dbe38 0000000000000046 000001003e4dbde8 000001003e450670 
       000000000b3c589b 000001007ff9a850 000001003e450988 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000000000000000     0   596      1           690   595 (L-TLB)
000001003e4d9e38 0000000000000046 000000773e4d9de8 000001007f6c6bd0 
       0000000000001c3a 000001007f6904b0 000001007f6c6ee8 0000000000000001 
       0000000000000003 0000000000000008 
Call Trace:<ffffffff801cf1ec>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801ceec0>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceee0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
syslogd       S 0000000000000000     0   690      1           693   596 (NOTLB)
000001007f687d88 0000000000000006 0000007400000000 000001003e4a8ed0 
       0000000000000fdd 000001003e4a96f0 000001003e4a91e8 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff80313e45>{datagram_poll+21} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff801ab8a1>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
klogd         R  running task       0   693      1           696   690 (NOTLB)
rpc.statd     S 0000275d80f36f11     0   696      1           707   693 (NOTLB)
000001003e3bfd88 0000000000000006 0000010034f5a3a0 000001003e931730 
       0000000000001f26 ffffffff803e23e0 000001003e931a48 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff80330341>{tcp_poll+33} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff801ab8a1>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
exim          S 00003c9d5e980681     0   707      1           714   696 (NOTLB)
000001003e7c5d88 0000000000000006 000001000000d700 000001003e308f50 
       0000000000007e6c ffffffff803e23e0 000001003e309268 ffffffff8015a512 
       000001000000d700 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff80330341>{tcp_poll+33} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
inetd         S 0000000000000000     0   714      1           720   707 (NOTLB)
000001003e05bd88 0000000000000006 0000007800000000 000001003e49d070 
       00000000002a0f7f 000001003e308730 000001003e49d388 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff80330341>{tcp_poll+33} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff8016c109>{unmap_region+409} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
rngd          S 00003e2325ef73e8     0   720      1           730   714 (NOTLB)
0000010040f27e68 0000000000000006 00000010ffffd36c 000001003e308730 
       0000000000000d85 ffffffff803e23e0 000001003e308a48 0000000000000246 
       ffffffff80443da0 0000000000000001 
Call Trace:<ffffffff8015a555>{__get_free_pages+37} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff80192011>{do_poll+177} 
       <ffffffff8019219e>{sys_poll+350} <ffffffff80191380>{__pollwait+0} 
       <ffffffff80123f81>{ia32_sysret+0} 
lpd           S 0000009c08291736     0   730      1           755   720 (NOTLB)
000001003e63dd88 0000000000000006 000001000000d700 000001003e49c850 
       0000000000002d11 ffffffff803e23e0 000001003e49cb68 ffffffff8015a512 
       000001000000d700 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff8018a812>{pipe_poll+50} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
smartd        S 00003c9e89326754     0   755      1           761   730 (NOTLB)
000001003e11fee8 0000000000000006 000001003ffba600 000001003e1210b0 
       00000000000035ab ffffffff803e23e0 000001003e1213c8 0000000000000246 
       0000000000000009 ffffffff802761db 
Call Trace:<ffffffff802761db>{blkdev_ioctl+955} <ffffffff80190cf6>{sys_ioctl+678} 
       <ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
sshd          S 00003e224ac5a392     0   761      1  1090     764   755 (NOTLB)
000001003e80bd88 0000000000000006 000001000000d700 000001003e120890 
       000000000000c315 ffffffff803e23e0 000001003e120ba8 ffffffff8015a512 
       000001000000d700 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff80330341>{tcp_poll+33} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
ntpd          S 00003e276959b563     0   764      1           768   761 (NOTLB)
000001007ed8fd88 0000000000000006 0000007940fc0830 000001003e120070 
       0000000000000421 000001007ff9a850 000001003e120388 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff80313e45>{datagram_poll+21} <ffffffff801918ca>{do_select+906} 
       <ffffffff80191380>{__pollwait+0} <ffffffff8011084f>{do_signal+175} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
atd           S 00003afba35fb0da     0   768      1           771   764 (NOTLB)
000001007f407ee8 0000000000000006 0000000000000000 000001007f6d4370 
       0000000000004080 000001007ff9a850 000001007f6d4688 0000000000000246 
       0000000000000000 ffffffff80186c64 
Call Trace:<ffffffff80186c64>{vfs_stat+68} <ffffffff80141011>{del_timer_sync+49} 
       <ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
cron          S 00003e21579855b4     0   771      1           775   768 (NOTLB)
000001007f405ee8 0000000000000006 0000000000000000 000001007f6404f0 
       0000000000001261 ffffffff803e23e0 000001007f640808 0000000000000246 
       0000000000000000 ffffffff80186c64 
Call Trace:<ffffffff80186c64>{vfs_stat+68} <ffffffff80141011>{del_timer_sync+49} 
       <ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
irqbalance    S 00003e270edcc3d0     0   775      1           785   771 (NOTLB)
000001003ea49ee8 0000000000000006 0000000000000212 000001003e29e0b0 
       0000000000006564 000001007ff9a850 000001003e29e3c8 0000000000000246 
       0000000000000216 0000010060208358 
Call Trace:<ffffffff8016a7c7>{remove_vm_struct+231} <ffffffff8016c109>{unmap_region+409} 
       <ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           R  running task       0   785      1          1797   775 (NOTLB)
sshd          S 0000000000000000     0  1090    761  1092    1101       (NOTLB)
000001003ea33c18 0000000000000006 0000007500001000 000001003ea35130 
       00000000000003a1 0000010001e8c0f0 000001003ea35448 ffffffff80382270 
       000001003e180520 0000000000000374 
Call Trace:<ffffffff801c470d>{__ext3_journal_stop+45} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff801582b7>{generic_file_aio_write_nolock+2055} 
       <ffffffff8035dc57>{unix_stream_data_wait+263} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff8035de31>{unix_stream_recvmsg+369} 
       <ffffffff8030d5a4>{sock_aio_read+180} <ffffffff8017bb93>{do_sync_read+115} 
       <ffffffff8017ae77>{dentry_open+263} <ffffffff8017ad52>{filp_open+66} 
       <ffffffff8017bcba>{vfs_read+218} <ffffffff8017bf19>{sys_read+73} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 0000000000000000     0  1092   1090  1093               (NOTLB)
000001003e9edd88 0000000000000006 000000750000d700 0000010001e8c0f0 
       0000000000000c00 000001007f640d10 0000010001e8c408 ffffffff8015a512 
       0000000008098450 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff8024e52b>{pty_write_room+43} <ffffffff8024d521>{normal_poll+305} 
       <ffffffff801918ca>{do_select+906} <ffffffff80191380>{__pollwait+0} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           S 00003d93b2c81863     0  1093   1092  1119               (NOTLB)
000001003de79f18 0000000000000006 0000000000000216 000001003dece9d0 
       0000000000001398 ffffffff803e23e0 000001003decece8 000001003e6b44c0 
       000001003e6b44c0 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff801958d1>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
sshd          S 0000000000000000     0  1101    761  1103          1090 (NOTLB)
000001003de0fc18 0000000000000006 0000007600001000 000001003e29f0f0 
       00000000000003f5 000001003decf1f0 000001003e29f408 ffffffff80382270 
       000001003e180a00 0000000000000374 
Call Trace:<ffffffff801c470d>{__ext3_journal_stop+45} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff801582b7>{generic_file_aio_write_nolock+2055} 
       <ffffffff8035dc57>{unix_stream_data_wait+263} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff8035de31>{unix_stream_recvmsg+369} 
       <ffffffff8030d5a4>{sock_aio_read+180} <ffffffff8017bb93>{do_sync_read+115} 
       <ffffffff8017ae77>{dentry_open+263} <ffffffff8017ad52>{filp_open+66} 
       <ffffffff8017bcba>{vfs_read+218} <ffffffff8017bf19>{sys_read+73} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 00003e242c914ec0     0  1103   1101  1104               (NOTLB)
000001003dc05d88 0000000000000006 000000740000d700 000001003decf1f0 
       0000000000000e87 000001003e29e8d0 000001003decf508 ffffffff8015a512 
       0000000008098430 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff8024e52b>{pty_write_room+43} <ffffffff8024d521>{normal_poll+305} 
       <ffffffff801918ca>{do_select+906} <ffffffff80191380>{__pollwait+0} 
       <ffffffff801ab8a1>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           S 00003e242c9c72d2     0  1104   1103  8825               (NOTLB)
000001003dba3f18 0000000000000006 0000000000000216 000001003e29e8d0 
       0000000000009ded ffffffff803e23e0 000001003e29ebe8 000001003e6b4b80 
       000001003e6b4b80 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff801958d1>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
zsh           S 00003e1fc58e116c     0  1119   1093  8824    8727       (NOTLB)
000001003da01f18 0000000000000006 0000000000000216 000001003ea340f0 
       000000000000179b ffffffff803e23e0 000001003ea34408 000001003e6b4940 
       000001003e6b4940 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff801958d1>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
apcupsd       S 00000a987aa07cb0     0  1797      1  1896    4010   785 (NOTLB)
000001003d571de8 0000000000000006 000001003e2903d8 000001003e9306f0 
       000000000000b624 ffffffff803e23e0 000001003e930a08 ffffffff801584eb 
       00000000ffffdbdc 0000000000000038 
Call Trace:<ffffffff801584eb>{generic_file_aio_write+107} <ffffffff801bbbf3>{ext3_file_write+35} 
       <ffffffff8013bdb2>{sys_wait4+642} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff80146273>{do_sigaction+659} <ffffffff8017bea7>{vfs_write+247} 
       <ffffffff8017bf99>{sys_write+73} <ffffffff80123f81>{ia32_sysret+0} 
       
apcupsd       R  running task       0  1896   1797                     (NOTLB)
portmap       S 00003c7c39328cc8     0  4010      1          4021  1797 (NOTLB)
000001007f2e1e68 0000000000000006 0000001000000216 0000010034d8a3b0 
       0000000000001647 000001007ff9a850 0000010034d8a6c8 0000000000000246 
       000001003e293730 0000000000000006 
Call Trace:<ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff80192011>{do_poll+177} <ffffffff8019219e>{sys_poll+350} 
       <ffffffff80191380>{__pollwait+0} <ffffffff80123f81>{ia32_sysret+0} 
       
nfsd          S 00003d33ef5e1212     0  4021      1          4022  4010 (L-TLB)
0000010034c71d98 0000000000000046 0000007340a62e88 000001007f6904b0 
       0000000000001dff 000001003e4a86b0 000001007f6907c8 0000000000000246 
       0000000000000256 0000010034c71d58 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00003d33ef5e1d69     0  4022      1          4025  4021 (L-TLB)
0000010034badd98 0000000000000046 0000007301b7b698 000001003e4a86b0 
       0000000000000122 ffffffff803e23e0 000001003e4a89c8 0000000000000246 
       000001003fd554a0 0000000000000216 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00003e0570804991     0  4025      1          4023  4022 (L-TLB)
0000010034c09d98 0000000000000046 0000010001b79788 000001003e309770 
       0000000000003076 000001007ff9a850 000001003e309a88 0000000000000246 
       000001003fd434a0 0000000000000216 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00003e057080e3f4     0  4023      1          4027  4025 (L-TLB)
000001003e08fd98 0000000000000046 00000100405be440 000001007febea10 
       0000000000001712 ffffffff803e23e0 000001007febed28 0000000000000246 
       000001007fe7c4a0 000001007f6b8cc0 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00003b3d1f1b4de6     0  4027      1          4024  4023 (L-TLB)
000001003e04bd98 0000000000000046 0000007340db8990 000001007fec6990 
       000000000000019c 000001007ff9a850 000001007fec6ca8 0000000000000246 
       000001007ffb24a0 0000000000000216 
Call Trace:<ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff8036e0fb>{svc_recv+987} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801f8f87>{nfsd+471} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115f7>{child_rip+8} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115ef>{child_rip+0} 
nfsd          S 00003b90f03a78c3     0  4024      1          4026  4027 (L-TLB)
0000010001e77d98 0000000000000046 0000007301b8b030 000001007fec31f0 
       00000000000000ab ffffffff803e23e0 000001007fec3508 0000000000000246 
       000001007fe814a0 0000000000000216 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00003b3d1f1b6fe4     0  4026      1          4028  4024 (L-TLB)
000001003e6bfd98 0000000000000046 0000010001b7e610 000001003e49c030 
       000000000000066f ffffffff803e23e0 000001003e49c348 0000000000000246 
       000001007ffb44a0 000001007f6b8cc0 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00003b90f03a7214     0  4028      1          4030  4026 (L-TLB)
000001003e3bdd98 0000000000000046 0000007340d8c188 0000010034d8b3f0 
       0000000000000940 000001007fec31f0 0000010034d8b708 0000000000000246 
       000001007fe734a0 000001007f6b8cc0 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377ef4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8f87>{nfsd+471} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8db0>{nfsd+0} 
       <ffffffff801f8db0>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
lockd         S 0000000000000000     0  4030      1          4031  4028 (L-TLB)
000001007ed13de8 0000000000000046 000000763e61a330 000001003e61a330 
       000000000000111d 000001003e61ab50 000001003e61a648 ffffffff803774bc 
       0000007300000001 0000000000000212 
Call Trace:<ffffffff803774bc>{thread_return+41} <ffffffff80377e65>{schedule_timeout+37} 
       <ffffffff8036c679>{svc_sock_release+569} <ffffffff8036e0fb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80378031>{__down_failed+53} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff8020a6d9>{lockd+377} <ffffffff8020a560>{lockd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8020a560>{lockd+0} 
       <ffffffff8020a560>{lockd+0} <ffffffff801115ef>{child_rip+0} 
       
rpciod        S 0000000000000000     0  4031      1          4033  4030 (L-TLB)
000001007e893e88 0000000000000046 0000007440000000 000001007ed114f0 
       00000000000012cf 000001007f6904b0 000001007ed11808 000001003e5e8668 
       ffffffff8020a560 0000000000000008 
Call Trace:<ffffffff8020a560>{lockd+0} <ffffffff803780df>{__up_wakeup+53} 
       <ffffffff8020a560>{lockd+0} <ffffffff8036952a>{rpciod+1050} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff80131321>{schedule_tail+17} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8020a560>{lockd+0} <ffffffff80369110>{rpciod+0} 
       <ffffffff801115ef>{child_rip+0} 
rpc.mountd    S 000027aa351b4f23     0  4033      1                4031 (NOTLB)
000001003e4c5e68 0000000000000006 0000001080000000 000001007f64f430 
       00000000000000ef ffffffff803e23e0 000001007f64f748 0000000000000246 
       0000010040f5f8f0 0000000000000002 
Call Trace:<ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff80192011>{do_poll+177} <ffffffff8019219e>{sys_poll+350} 
       <ffffffff80191380>{__pollwait+0} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           S 00003e14d482c249     0  8727   1093  8775          1119 (NOTLB)
0000010024b3ff18 0000000000000006 0000000000000216 000001003e61b370 
       0000000000001960 ffffffff803e23e0 000001003e61b688 000001003e6b4940 
       000001003e6b4940 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff801958d1>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
dump          D 00003e14e808f7df     0  8775   8727                     (NOTLB)
000001002ef31bb8 0000000000000006 000001003ffd5948 000001007f640d10 
       0000000000007df3 ffffffff803e23e0 000001007f641028 ffffffff802fd683 
       0000000000000212 0000000000000001 
Call Trace:<ffffffff802fd683>{raid5_unplug_device+291} <ffffffff80377d3b>{io_schedule+43} 
       <ffffffff80155f6a>{__lock_page+250} <ffffffff80155c40>{page_wake_function+0} 
       <ffffffff80155c40>{page_wake_function+0} <ffffffff801567f6>{do_generic_mapping_read+502} 
       <ffffffff80156a70>{file_read_actor+0} <ffffffff80156d14>{__generic_file_aio_read+372} 
       <ffffffff80156dfb>{generic_file_read+123} <ffffffff80169994>{handle_mm_fault+292} 
       <ffffffff80122ad8>{do_page_fault+440} <ffffffff80130948>{recalc_task_prio+424} 
       <ffffffff803774bc>{thread_return+41} <ffffffff8017bca7>{vfs_read+199} 
       <ffffffff8017bf19>{sys_read+73} <ffffffff80123f81>{ia32_sysret+0} 
       
sleep         S 00003e1fc5e0bf41     0  8824   1119                     (NOTLB)
0000010054f3fee8 0000000000000006 00000100115c0aa8 000001007febe1f0 
       00000000000e9920 000001007ff9a850 000001007febe508 0000000000000246 
       00000000ffffd724 0000000000000014 
Call Trace:<ffffffff80377ef4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
ls            D 00003e242d2c4ffe     0  8825   1104                     (NOTLB)
00000100349d5d38 0000000000000006 000001003ffd5948 000001003e61ab50 
       00000000001349ac ffffffff803e23e0 000001003e61ae68 ffffffff802fd683 
       0000000000000216 000001003e26ed58 
Call Trace:<ffffffff802fd683>{raid5_unplug_device+291} <ffffffff80377d3b>{io_schedule+43} 
       <ffffffff8017d4f8>{__wait_on_buffer+168} <ffffffff8017d310>{bh_wake_function+0} 
       <ffffffff8017d310>{bh_wake_function+0} <ffffffff801be1cb>{ext3_bread+91} 
       <ffffffff801bb348>{ext3_readdir+232} <ffffffff80191120>{filldir64+0} 
       <ffffffff80122ad8>{do_page_fault+440} <ffffffff8016b23b>{vma_merge+331} 
       <ffffffff80190db7>{vfs_readdir+119} <ffffffff80191294>{sys_getdents64+132} 
       <ffffffff80111441>{error_exit+0} <ffffffff80123f81>{ia32_sysret+0} 
       

-ryan
