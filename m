Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUF1TKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUF1TKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUF1TKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:10:33 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:59598 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265133AbUF1TJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:09:50 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm3 [broken serial console and Kernel BUG on dual Opteron]
Date: Mon, 28 Jun 2004 21:18:36 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040626233105.0c1375b2.akpm@osdl.org> <200406271338.30803.rjwysocki@sisk.pl> <20040628001935.37b19aa2.akpm@osdl.org>
In-Reply-To: <20040628001935.37b19aa2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_M8G4AnYkATnEhvV"
Message-Id: <200406282118.36911.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_M8G4AnYkATnEhvV
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 28 of June 2004 09:19, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> >  On Sunday 27 of June 2004 08:31, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.
> >  >6.7-m m3/
> >
> >  I see the following: (in the order of importance - to me ;-)):
> >
> >  1) Serial console does not work (at all), but earlyprintk _does_ (output
> > goes to tty0 after earlyprintk has finished).
> >
> >  Please, fix the serial console ASAP.  It's a pain to hand-rewrite call
> > traces
>
> erk, sorry, I thought the x86_64 console= parsing breakage had been fixed.
>
> The below should get you going again while we remember what the problem
> was.

It's revived the serial console, so thanks a lot!  BTW, can you tell me 
please, what it actually does?  I see that it applies to many architectures, 
not just x86-64 ...

FYIO, I see that for the following command line:

root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 
console=tty0 hdc=ide-scsi

it makes all of the kernel and system boot messages go to ttyS0 (see the 
attached log) while tty0 gets only kernel messages ("normally" it worked in 
the reverse way), which of course is not a big deal.

Now, I'm going to set the DEBUG_SLAB and see what happens. ;-)

Yours,
rjw

----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
--Boundary-00=_M8G4AnYkATnEhvV
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.6.7-mm3-boot.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.7-mm3-boot.log"

Bootdata ok (command line is root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 console=tty0 hdc=)
Linux version 2.6.7-mm3 (rafael@chimera) (gcc version 3.3.3 (SuSE Linux)) #4 SMP Mon Jun 28 20:49:29 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-c000
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
No mptable found.
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 console=tty0 hdc=ide-scsi
ide_setup: hdc=ide-scsi
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1386.661 MHz processor.
disabling early console
Bootdata ok (command line is root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 console=tty0 hdc=)
Linux version 2.6.7-mm3 (rafael@chimera) (gcc version 3.3.3 (SuSE Linux)) #4 SMP Mon Jun 28 20:49:29 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
No mptable found.
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 console=tty0 hdc=ide-scsi
ide_setup: hdc=ide-scsi
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1386.661 MHz processor.
disabling early console
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1025868k/1048512k available (2203k kernel code, 0k reserved, 1129k data, 188k init)
Calibrating delay loop... 2719.74 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 1024.36 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 1003ff95f58
Initializing CPU#1
Calibrating delay loop... 2768.89 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 01
Total of 2 processors activated (5488.64 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.380 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040615
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCIB] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:03:0a.0[A] -> GSI 16 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:03:0a.1[B] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:03:0a.2[C] -> GSI 18 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:03:0c.0[A] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 26 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 27 (level, low) -> IRQ 209
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 217
ACPI: PCI interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 185
testing the IO APIC.......................



Using vector-based indexing
.................................... done.
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
vesafb: framebuffer at 0xe0000000, mapped to 0xffffff000004f000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1088448683.969:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON DVDRW LDW-851S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 26 (level, low) -> IRQ 201
sym0: <1010-66> rev 0x1 at pci 0000:02:07.0 irq 201
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: asynchronous.
sym0:0: wide asynchronous.
sym0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
scsi(0:0:0:0): Ending Domain Validation
  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:10:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:10:0): Beginning Domain Validation
sym0:10: wide asynchronous.
sym0:10: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
scsi(0:0:10:0): Ending Domain Validation
3ware Storage Controller device driver for Linux v1.26.00.039.
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 27 (level, low) -> IRQ 209
scsi1 : Found a 3ware Storage Controller at 0x8c00, IRQ: 209, P-chip: 1.3
scsi1 : 3ware Storage Controller
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
ACPI: PCI interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xFFFFFF0000655C80 ctl 0xFFFFFF0000655C8A bmdma 0xFFFFFF0000655C00 irq 177
ata2: SATA max UDMA/100 cmd 0xFFFFFF0000655CC0 ctl 0xFFFFFF0000655CCA bmdma 0xFFFFFF0000655C08 irq 177
ata3: SATA max UDMA/100 cmd 0xFFFFFF0000655E80 ctl 0xFFFFFF0000655E8A bmdma 0xFFFFFF0000655E00 irq 177
ata4: SATA max UDMA/100 cmd 0xFFFFFF0000655EC0 ctl 0xFFFFFF0000655ECA bmdma 0xFFFFFF0000655E08 irq 177
ata1: no device found (phy stat 00000000)
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
ata3: no device found (phy stat 00000000)
scsi4 : sata_sil
ata4: no device found (phy stat 00000000)
scsi5 : sata_sil
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 >
Attached scsi disk sdb at scsi0, channel 0, id 10, lun 0
SCSI device sdc: 156365968 512-byte hdwr sectors (80059 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 >
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  4204.000 MB/sec
raid5: using function: generic_sse (4204.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
PERFCTR INIT: vendor 2, family 15, model 5, stepping 1, clock 1386661 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 643 cycles
PERFCTR INIT: rdtsc cost is 6710885.5 cycles (590 total)
PERFCTR INIT: rdpmc cost is 6710885.7 cycles (603 total)
PERFCTR INIT: rdmsr (counter) cost is 42.1 cycles (3343 total)
PERFCTR INIT: rdmsr (evntsel) cost is 47.8 cycles (3703 total)
PERFCTR INIT: wrmsr (counter) cost is 60.7 cycles (4528 total)
PERFCTR INIT: wrmsr (evntsel) cost is 309.1 cycles (20428 total)
PERFCTR INIT: read cr4 cost is 6710884.4 cycles (519 total)
PERFCTR INIT: write cr4 cost is 57.8 cycles (4348 total)
PERFCTR INIT: write LVTPC cost is 3.1 cycles (846 total)
perfctr: driver 2.7.3, cpu type AMD K7/K8 at 1386661 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 440 bytes per conntrack
NET: Registered protocol family 1
NET: Registered protocol family 15
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
INIT: version 2.85 booting
System Boot Control: Running /etc/init.d/boot
Mounting /proc filesystem                                             done
Mounting sysfs on /sys                                                done
Mounting /dev/pts                                                     done
Configuring serial ports...
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
/dev/ttyS1 at 0x02f8 (irq = 3) is a 16550A
Configured serial ports                                               done
Mounting shared memory FS on /dev/shm                                 done
Activating swap-devices in /etc/fstab...
Adding 1001464k swap on /dev/sda2.  Priority:42 extents:1
Adding 1004052k swap on /dev/sdc2.  Priority:42 extents:1             done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking root file system...
fsck 1.34 (25-Jul-2003)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sdc3
/1 (/dev/sdc3): clean, 329534/1001920 files, 1549964/2002100 blocks   done
EXT3 FS on sdc3, internal journal
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Activating device mapper...
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Creating /dev/mapper/control character device with major:10 minor:63.
                                                                      done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.34 (25-Jul-2003)
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sdc1
[/sbin/fsck.ext3 (2) -- /backup] fsck.ext3 -a /dev/sda7
/boot1 (/dev/sdc1): clean, 81/64256 files, 54510/257008 blocks
[/sbin/fsck.ext3 (2) -- /tmp] fsck.ext3 -a /dev/sdc5
/home (/dev/sda7): clean, 30592/1343488 files, 883147/2685692 blocks
[/sbin/fsck.ext3 (2) -- /local] fsck.ext3 -a /dev/sda8
/tmp1 (/dev/sdc5): clean, 89/125696 files, 8132/251007 blocks
[/sbin/fsck.ext3 (2) -- /var] fsck.ext3 -a /dev/sdc6
/dev/sda8: clean, 594324/1482208 files, 2206137/2961148 blocks
/var1 (/dev/sdc6): clean, 4257/251392 files, 77742/502023 blocks
[/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a /dev/sdc7
/home1 (/dev/sdc7): clean, 21438/2003424 files, 492995/4002185 blocks
[/sbin/fsck.ext3 (1) -- /storage] fsck.ext3 -a /dev/sdc8
/local (/dev/sdc8): clean, 29729/6238080 files, 9304579/12451840 blockdone
Setting up                                                            done
Mounting local file systems...
proc on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sdc1 on /boot type ext3 (rw,acl,user_xattr)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sdc5 on /tmp type ext3 (rw,acl,user_xattr)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sdc6 on /var type ext3 (rw,acl,user_xattr)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sdc7 on /home type ext3 (rw,acl,user_xattr)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sdc8 on /storage type ext3 kjournald starting.  Commit interval 5 seconds
(rw,acl,user_xattr)
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/sda7 on /backup type ext3 (rw,acl,user_xattr)
kjournald starting.  Commit interval 5 seconds
/dev/sda8 on /local type ext3 (rw,acl,user_xattrEXT3 FS on sda8, internal journal
)                                                                     done
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Loading required kernel modules                                       done
Restore device permissions                                            done
Activating remaining swap-devices in /etc/fstab...                    done
Setting up the CMOS clock                                             done
Setting up timezone data                                              done
Setting scheduling timeslices                                         unused
Setting up hostname 'chimera'                                         done
Setting up loopback interface     lo
    lo        IP address: 127.0.0.1/8
                                                                      done
Enabling syn flood protection                                         done
Disabling IP forwarding                                               done
Creating /var/log/boot.msg                                            done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
System Boot Control: The system has been                              set up
Skipped features:                                                                boot.sched
System Boot Control: Running /etc/init.d/boot.local                   done
INIT: Entering runlevel: 5
Boot logging started on /dev/ttyS0(/dev/console) at Mon Jun 28 20:51:53 2004
Master Resource Control: previous runlevel: N, switching to runlevel: 5
Hotplug is already active  (disable with  NOHOTPLUG=1 at the boot promdone
Initializing random number generator                                  done
coldplug scanning input:                                              done
         scanning pci: **.**W*W*W********.*******.*.*W                done
         scanning usb:                                                done
         .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .done .  .
Setting up network interfaces:
    lo
    lo        IP address: 127.0.0.1/8                                 done
Waiting for mandatory devices:  eth0
20 19 18 16 15 modprobe: FATAL: Module 3w_xxxx not found.

tg3.c:v3.6 (June 12, 2004)
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 217
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:a0:bf
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 169
ohci_hcd 0000:03:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:03:00.0: irq 169, pci mem ffffff000077b000
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 169
ohci_hcd 0000:03:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:03:00.1: irq 169, pci mem ffffff000077d000
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:03:0a.0[A] -> GSI 16 (level, low) -> IRQ 185
ohci_hcd 0000:03:0a.0: NEC Corporation USB
ohci_hcd 0000:03:0a.0: irq 185, pci mem ffffff000077f000
ohci_hcd 0000:03:0a.0: new USB bus registered, assigned bus number 3

    eth0      device: Broadcom Corporation NetXtreme BCM5703 Gigabit Ethernet (rev 02)
    eth0      IP address: 192.168.100.1/24                            done
Setting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  done
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
Starting syslog services                                              done
Starting RPC portmap daemon                                           done
Starting resource manager                                             done
Mount SMB/ CIFS File Systems                                          unused
Starting nfsboot (sm-notify)                                          done
ACPI: PCI interrupt 0000:03:0a.1[B] -> GSI 17 (level, low) -> IRQ 177
ohci_hcd 0000:03:0a.1: NEC Corporation USB (#2)
ohci_hcd 0000:03:0a.1: irq 177, pci mem ffffff0000795000
ohci_hcd 0000:03:0a.1: new USB bus registered, assigned bus number 4
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Starting SSH daemon                                                   done
ACPI: PCI interrupt 0000:03:0a.2[C] -> GSI 18 (level, low) -> IRQ 193
ehci_hcd 0000:03:0a.2: NEC Corporation USB 2.0
ehci_hcd 0000:03:0a.2: irq 193, pci mem ffffff0000797800
ehci_hcd 0000:03:0a.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:03:0a.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 5 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:0c.0[A] -> GSI 19 (level, low) -> IRQ 169
Starting name server BIND 9                                           done
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[169]  MMIO=[fc8ff000-fc8ff7ff]  Max Packet=[2048]
ACPI: PCI interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 177
Starting sound driver:  intel8x0ALSA sound/pci/ac97/ac97_codec.c:1922: AC'97 0 analog subsections not ready
ALSA sound/pci/ac97/ac97_codec.c:2365: ac97 quirk for AMD64 Mobo (10f1:2885)
intel8x0_measure_ac97_clock: measured 49913 usecs
intel8x0: clocking to 48000
ALSA sound/pci/intel8x0.c:2833: joystick(s) found
                                                                      done
Restoring the previous sound setting                                  done
Loading keymap qwerty/Pl02.map.gz                                     done
Loading compose table latin2                                          done
Start Unicode mode                                                    done
Loading console font lat9w-16.psfu  -m trivial (K                     done
Starting cupsd                                                        done
Starting service kdm                                                  done
Starting mail service (Postfix)                                       done
Starting CRON daemon                                                  done
Master Resource Control: runlevel 5 has been                          reached
Skipped services in runlevel 5:                                                              smbfs splash

--Boundary-00=_M8G4AnYkATnEhvV--

