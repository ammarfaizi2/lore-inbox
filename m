Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSLBT30>; Mon, 2 Dec 2002 14:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSLBT30>; Mon, 2 Dec 2002 14:29:26 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:37046 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264954AbSLBT3G>;
	Mon, 2 Dec 2002 14:29:06 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Mon, 2 Dec 2002 20:36:14 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: MPT Fussion crashes in 2.5.49/2.5.50
Cc: hulinsky@feld.cvut.cz
X-mailer: Pegasus Mail v3.50
Message-ID: <9336EEE7B50@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  friend has a Dell box with MPT, and unfortunately 2.5.50 dies
on that system. It dies in scsi_dispatch_cmd because of Fussion
defines command as NULL, and for some reason can_queue is set to 0
(probably during I/O error recovery) when (crashing) scsi_dispatch_cmd
enters.

  Is there some guide what (and how) should be done to get this
driver back into working state? Is now 'command' mandatory?

  For information also 2.4.20-rc3 log (which works) is appended:
with 2.4.20-rc3 it works correctly on same IRQ (72) without timeouts.
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010046
EIP is at 0x0
eax: 00000000   ebx: c1918000   ecx: 00000246   edx: 0000000c
esi: 00000297   edi: f7cc0800   ebp: f7cc8200   esp: c1919df4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c1918000 task=f7f9e080)
Stack: c021e263 f7cc8200 c021e954 f7cc8e8c f7c31400 f7cc0800 c1919e34 00000000 
       c02240a2 f7cc8200 f7cc8200 c1918000 f7c31428 00000202 f7cc8200 c1918000 
       f7cc8e8c c01e6c9b f7c31428 f7c31428 f7cc8e8c 00000001 00000000 f7c31428 
Call Trace:
 [<c021e263>] scsi_dispatch_cmd+0x193/0x308
 [<c021e954>] scsi_done+0x0/0x7c
 [<c02240a2>] scsi_request_fn+0x256/0x284
 [<c01e6c9b>] blk_insert_request+0x63/0x88
 [<c02233b6>] scsi_insert_special_req+0x22/0x2c
 [<c021e5ba>] scsi_do_req+0x12a/0x150
 [<c021e455>] scsi_wait_req+0x7d/0xb8
 [<c021da34>] scsi_wait_done+0x0/0x80
 [<c0224f2f>] scsi_probe_lun+0x93/0x238
 [<c0225469>] scsi_probe_and_add_lun+0x99/0x1a8
 [<c0225c34>] scsi_scan_target+0x40/0x70
 [<c0225cbf>] scsi_scan_host+0x5b/0x80
 [<c021ffd9>] __scsi_add_host+0x39/0x70
 [<c022041b>] scsi_register_host+0x7f/0xa8
 [<c01050ab>] init+0x47/0x1ac
 [<c0105064>] init+0x0/0x1ac
 [<c0108941>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!



Linux version 2.5.50bk2 (root@amik2) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Dec 2 17:08:38 CET 2002Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000003ffe0000 (usable)
 BIOS-e820: 000000003ffe0000 - 000000003ffefc00 (ACPI data)
 BIOS-e820: 000000003ffefc00 - 000000003ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 DELL                       ) @ 0x000fdc20
ACPI: RSDT (v001 DELL   PE2600   00000.00001) @ 0x000fdc34
ACPI: FADT (v001 DELL   PE2600   00000.00001) @ 0x000fdc64
ACPI: MADT (v001 DELL   PE2600   00000.00001) @ 0x000fdcd8
ACPI: SPCR (v001 DELL   PE2600   00000.00001) @ 0x000fdd96
ACPI: DSDT (v001 DELL   PE2600   00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:2 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:2 APIC version 16
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0123      APIC at: 0xFEE00000
I/O APIC #4 Version 32 at 0xFEC00000.
I/O APIC #5 Version 32 at 0xFEC80000.
I/O APIC #6 Version 32 at 0xFEC81000.
I/O APIC #7 Version 32 at 0xFEC82000.
I/O APIC #8 Version 32 at 0xFEC82800.
Enabling APIC mode:  Flat.  Using 5 I/O APICs
Processors: 4
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=802 console=ttyS0,9600 console=tty
Initializing CPU#0
Detected 2392.098 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4718.59 BogoMIPS
Memory: 903260k/917504k available (2108k kernel code, 13460k reserved, 1247k data, 340k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX

CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4767.74 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4767.74 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4767.74 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (19021.82 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 6 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 6 ... ok.
Setting 7 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 7 ... ok.
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2391.0992 MHz.
..... host bus clock speed is 99.0666 MHz.
checking TSC synchronization across 4 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfc6ce, last bus=11
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
SCSI subsystem driver Revision: 1.00
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I31,P0) -> 16
PCI->APIC IRQ transform: (B3,I1,P0) -> 28
PCI->APIC IRQ transform: (B5,I4,P0) -> 48
PCI->APIC IRQ transform: (B5,I4,P1) -> 49
PCI->APIC IRQ transform: (B5,I5,P0) -> 52
PCI->APIC IRQ transform: (B5,I5,P1) -> 53
PCI->APIC IRQ transform: (B9,I13,P0) -> 72
PCI->APIC IRQ transform: (B9,I13,P1) -> 73
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
aio_setup: sizeof(struct page) = 40
[f7f9e080] eventpoll: successfully initialized.
Journalled Block Device driver loaded
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
i810_rng hardware driver 0.9.8 loaded
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
Copyright (c) 1999-2002 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hda, sector 0
st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
Fusion MPT base driver 2.03.00.02
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 recovery
mptbase: Initiating ioc1 recovery
mptbase: Initiating ioc1 recovery
mptbase: Initiating ioc1 recovery
mptbase: 2 MPT adapters found, 2 installed.
Fusion MPT SCSI Host driver 2.03.00.02
scsi0 : ioc0: LSI53C1030, FwRev=01000c00h, Ports=1, MaxQ=255, IRQ=72
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010046
EIP is at 0x0
eax: 00000000   ebx: c1918000   ecx: 00000246   edx: 0000000c
esi: 00000297   edi: f7cc0800   ebp: f7cc8200   esp: c1919df4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c1918000 task=f7f9e080)
Stack: c021e263 f7cc8200 c021e954 f7cc8e8c f7c31400 f7cc0800 c1919e34 00000000 
       c02240a2 f7cc8200 f7cc8200 c1918000 f7c31428 00000202 f7cc8200 c1918000 
       f7cc8e8c c01e6c9b f7c31428 f7c31428 f7cc8e8c 00000001 00000000 f7c31428 
Call Trace:
 [<c021e263>] scsi_dispatch_cmd+0x193/0x308
 [<c021e954>] scsi_done+0x0/0x7c
 [<c02240a2>] scsi_request_fn+0x256/0x284
 [<c01e6c9b>] blk_insert_request+0x63/0x88
 [<c02233b6>] scsi_insert_special_req+0x22/0x2c
 [<c021e5ba>] scsi_do_req+0x12a/0x150
 [<c021e455>] scsi_wait_req+0x7d/0xb8
 [<c021da34>] scsi_wait_done+0x0/0x80
 [<c0224f2f>] scsi_probe_lun+0x93/0x238
 [<c0225469>] scsi_probe_and_add_lun+0x99/0x1a8
 [<c0225c34>] scsi_scan_target+0x40/0x70
 [<c0225cbf>] scsi_scan_host+0x5b/0x80
 [<c021ffd9>] __scsi_add_host+0x39/0x70
 [<c022041b>] scsi_register_host+0x7f/0xa8
 [<c01050ab>] init+0x47/0x1ac
 [<c0105064>] init+0x0/0x1ac
 [<c0108941>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!

------------------------------------------------------------------------
Linux version 2.4.20-rc3 (root@amik2) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 SMP Mon Nov 25 15:27:34 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000003ffe0000 (usable)
 BIOS-e820: 000000003ffe0000 - 000000003ffefc00 (ACPI data)
 BIOS-e820: 000000003ffefc00 - 000000003ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00fdc20
RSD PTR  v0 [DELL  ]
__va_range(0xfdc34, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [DELL   PE2600   0.1]
__va_range(0xfdc64, 0x24): idx=8 mapped at ffff6000
__va_range(0xfdc64, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [DELL   PE2600   0.1]
__va_range(0xfdcd8, 0x24): idx=8 mapped at ffff6000
__va_range(0xfdcd8, 0xbe): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [DELL   PE2600   0.1]
__va_range(0xfdcd8, 0xbe): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
CPU 1 (0x0200) enabledProcessor #2 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0003] id[0x1] enabled[1])
CPU 2 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0004] id[0x3] enabled[1])
CPU 3 (0x0300) enabledProcessor #3 Pentium 4(tm) XEON(tm) APIC version 16

IOAPIC (id[0x4] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0x5] address[0xfec80000] global_irq_base[0x18])
IOAPIC (id[0x6] address[0xfec81000] global_irq_base[0x48])
IOAPIC (id[0x7] address[0xfec82000] global_irq_base[0x78])
IOAPIC (id[0x8] address[0xfec82800] global_irq_base[0x90])
LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0004] polarity[0x1] trigger[0x1] lint[0x1])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
INT_SRC_OVR (bus[0] irq[0xa] global_irq[0xa] polarity[0x1] trigger[0x1])
4 CPUs total
Local APIC address fee00000
__va_range(0xfdd96, 0x24): idx=8 mapped at ffff6000
__va_range(0xfdd96, 0x50): idx=8 mapped at ffff6000
ACPI table found: SPCR v1 [DELL   PE2600   0.1]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0123      APIC at: 0xFEE00000
I/O APIC #4 Version 32 at 0xFEC00000.
I/O APIC #5 Version 32 at 0xFEC80000.
I/O APIC #6 Version 32 at 0xFEC81000.
I/O APIC #7 Version 32 at 0xFEC82000.
I/O APIC #8 Version 32 at 0xFEC82800.
Processors: 4
Kernel command line: BOOT_IMAGE=LinuxCHODI ro root=802 console=ttyS0,9600 console=tty
Initializing CPU#0
Detected 2392.264 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 904348k/917504k available (1481k kernel code, 12772k reserved, 513k data, 288k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4771.02 BogoMIPS
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (19110.29 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 6 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 6 ... ok.
Setting 7 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 7 ... ok.
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2392.3472 MHz.
..... host bus clock speed is 99.6809 MHz.
cpu: 0, clocks: 996809, slice: 199361
CPU0<T0:996800,T1:797424,D:15,S:199361,C:996809>
cpu: 1, clocks: 996809, slice: 199361
cpu: 3, clocks: 996809, slice: 199361
cpu: 2, clocks: 996809, slice: 199361
CPU3<T0:996800,T1:199344,D:12,S:199361,C:996809>
CPU2<T0:996800,T1:398704,D:13,S:199361,C:996809>
CPU1<T0:996800,T1:598064,D:14,S:199361,C:996809>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfc6ce, last bus=11
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I31,P0) -> 16
PCI->APIC IRQ transform: (B3,I1,P0) -> 28
PCI->APIC IRQ transform: (B5,I4,P0) -> 48
PCI->APIC IRQ transform: (B5,I4,P1) -> 49
PCI->APIC IRQ transform: (B5,I5,P0) -> 52
PCI->APIC IRQ transform: (B5,I5,P1) -> 53
PCI->APIC IRQ transform: (B9,I13,P0) -> 72
PCI->APIC IRQ transform: (B9,I13,P1) -> 73
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
Journalled Block Device driver loaded
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI bus 00 dev f9
ICH3: detected chipset, but driver not compiled in!
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: BIOS setup was incomplete.
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Fusion MPT base driver 2.02.01
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
mptbase: 2 MPT adapters found, 2 installed.
Fusion MPT SCSI Host driver 2.02.01
scsi0 : ioc0: LSI53C1030, FwRev=01000c00h, Ports=1, MaxQ=255, IRQ=72
scsi1 : ioc1: LSI53C1030, FwRev=01000c00h, Ports=1, MaxQ=255, IRQ=73
  Vendor: SEAGATE   Model: ST318432LC        Rev: 2226
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: MAXTOR    Model: ATLASU320_73_SCA  Rev: B120
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: PE/PV     Model: 1x6 SCSI BP       Rev: 0.29
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
SCSI device sdb: 143374650 512-byte hdwr sectors (73408 MB)
 sdb:
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 11
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
i2o_scsi.c: Version 0.0.1
  chain_pool: 0 bytes @ f7e19240
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
802.1Q VLAN Support v1.7 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 288k freed
Adding Swap: 1951888k swap-space (priority -1)
Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
Copyright (c) 1999-2002 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
