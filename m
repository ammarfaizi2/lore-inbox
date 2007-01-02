Return-Path: <linux-kernel-owner+w=401wt.eu-S1755208AbXAAOi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbXAAOi5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212AbXAAOi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 09:38:57 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:42074 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbXAAOiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 09:38:55 -0500
Date: Tue, 2 Jan 2007 15:37:49 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [2.6.20-rc3] PATA_MARVELL: total machine freeze
Message-ID: <20070102153749.7def11c7@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_oRlYmJidYbc7t+vcLfzUswF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_oRlYmJidYbc7t+vcLfzUswF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

	Hardware

MOBO		Intel DG965SS (chipset G965 Express)
PATA CDRW	LG GCE-8400B

I'm using PATA_MARVELL driver, and trying to burn a CD results in a
total machine freeze (no SysRq / no output over serial console).

The freeze doesn't happens immediately: the writing process stalls for
several seconds during which the machine works flawlessy.


I've found that even a simple "sdparm -a /dev/sr0" have the same
effect, so I've done an strace:

execve("/usr/bin/sdparm", ["sdparm", "-a", "/dev/sr0"], [/* 63 vars */]) = 0
brk(0)                                  = 0x52c000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b3bfa0b3000
uname({sys="Linux", node="tux", ...})   = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=129796, ...}) = 0
mmap(NULL, 129796, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b3bfa0b4000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000\322\1"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1256568, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b3bfa0d4000
mmap(NULL, 2273448, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b3bfa1b4000
mprotect(0x2b3bfa2d6000, 1048576, PROT_NONE) = 0
mmap(0x2b3bfa3d6000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x122000) = 0x2b3bfa3d6000
mmap(0x2b3bfa3db000, 16552, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b3bfa3db000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b3bfa3e0000
arch_prctl(ARCH_SET_FS, 0x2b3bfa3e06d0) = 0
mprotect(0x2b3bfa3d6000, 12288, PROT_READ) = 0
mprotect(0x2b3bfa1b2000, 4096, PROT_READ) = 0
munmap(0x2b3bfa0b4000, 129796)          = 0
open("/dev/sr0", O_RDONLY|O_NONBLOCK)   = 3
brk(0)                                  = 0x52c000
brk(0x54d000)                           = 0x54d000
ioctl(3, SG_IO, 0x52c010)               = 0
fstat(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 1), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b3bfa0b4000
write(1, "    /dev/sr0: HL-DT-ST  CD-RW GC"..., 57) = 57
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
write(1, "Read write error recovery mode p"..., 37) = 37
write(1, "  AWRE        0  [cha: n, def:  "..., 35) = 35
write(1, "  ARRE        0  [cha: n, def:  "..., 35) = 35
write(1, "  TB          0  [cha: n, def:  "..., 35) = 35
write(1, "  RC          0  [cha: n, def:  "..., 35) = 35
write(1, "  EER         0  [cha: n, def:  "..., 35) = 35
write(1, "  PER         0  [cha: n, def:  "..., 35) = 35
write(1, "  DTE         0  [cha: n, def:  "..., 35) = 35
write(1, "  DCR         0  [cha: y, def:  "..., 35) = 35
write(1, "  RRC        32  [cha: y, def: 3"..., 35) = 35
write(1, "  COR_S       0  [cha: n, def:  "..., 35) = 35
write(1, "  HOC         0  [cha: n, def:  "..., 35) = 35
write(1, "  DSOC        0  [cha: n, def:  "..., 35) = 35
write(1, "  EMCDR       0  [cha: n, def:  "..., 35) = 35
write(1, "  WRC         0  [cha: n, def:  "..., 35) = 35
write(1, "  ERTL        0  [cha: n, def:  "..., 35) = 35
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
write(1, "Write parameters (MMC) mode page"..., 34) = 34
write(1, "  BUFE        0  [cha: y, def:  "..., 35) = 35
write(1, "  LS_V        0  [cha: n, def:  "..., 35) = 35
write(1, "  TST_W       0  [cha: y, def:  "..., 35) = 35
write(1, "  WR_T        1  [cha: y, def:  "..., 35) = 35
write(1, "  MULTI_S     0  [cha: y, def:  "..., 35) = 35
write(1, "  FP          0  [cha: y, def:  "..., 35) = 35
write(1, "  COPY        0  [cha: y, def:  "..., 35) = 35
write(1, "  TRACK_M     4  [cha: y, def:  "..., 35) = 35
write(1, "  DBT         8  [cha: y, def:  "..., 35) = 35
write(1, "  LINK_S      0  [cha: n, def:  "..., 35) = 35
write(1, "  IAC         0  [cha: y, def:  "..., 35) = 35
write(1, "  SESS_F      0  [cha: y, def:  "..., 35) = 35
write(1, "  PACK_S      0  [cha: y, def:  "..., 35) = 35
write(1, "  APL       150  [cha: y, def:15"..., 35) = 35
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
write(1, "Protocol specific logical unit m"..., 42) = 42
write(1, "  LUPID       0  [cha: n, def:  "..., 35) = 35
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
write(1, "Power condition mode page:\n", 27) = 27
write(1, "  IDLE        1  [cha: n, def:  "..., 35) = 35
write(1, "  STANDBY     1  [cha: n, def:  "..., 35) = 35
write(1, "  ICT       1200  [cha: n, def:1"..., 37) = 37
write(1, "  SCT       2400  [cha: n, def:2"..., 37) = 37
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO, 0x52c010)               = 0
ioctl(3, SG_IO

^^^^^^^^^^^^^^^^^^^

I don't know why the output is truncated that way... anyway, as said
before, the machine works for something like 30s after this (in the
above example it survived >60s).

dmesg / lspci / config attached


Any idea?

-- 
	Paolo Ornati
	Linux 2.6.20-rc3 on x86_64

--MP_oRlYmJidYbc7t+vcLfzUswF
Content-Type: text/plain; name=dmesg.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.txt

[    0.000000] Linux version 2.6.20-rc3 (paolo@tux) (gcc version 4.1.1 (Gentoo 4.1.1-r1)) #46 SMP Tue Jan 2 10:46:33 CET 2007
[    0.000000] Command line: root=/dev/sda6 video=intelfb:1024x768@60
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
[    0.000000]  BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003e599000 (usable)
[    0.000000]  BIOS-e820: 000000003e599000 - 000000003e5a6000 (reserved)
[    0.000000]  BIOS-e820: 000000003e5a6000 - 000000003e655000 (usable)
[    0.000000]  BIOS-e820: 000000003e655000 - 000000003e6a6000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003e6a6000 - 000000003e6ab000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003e6ab000 - 000000003e6ac000 (usable)
[    0.000000]  BIOS-e820: 000000003e6ac000 - 000000003e6f2000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003e6f2000 - 000000003e6ff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003e6ff000 - 000000003e700000 (usable)
[    0.000000]  BIOS-e820: 000000003e700000 - 000000003f000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 143) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 255385) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 255398, 255573) 2 entries of 256 used
[    0.000000] Entering add_active_range(0, 255659, 255660) 3 entries of 256 used
[    0.000000] Entering add_active_range(0, 255743, 255744) 4 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
[    0.000000] ACPI: RSDT (v001 INTEL  DG965SS  0x00000629      0x01000013) @ 0x000000003e6fd038
[    0.000000] ACPI: FADT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6fc000
[    0.000000] ACPI: MADT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f6000
[    0.000000] ACPI: WDDT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f5000
[    0.000000] ACPI: MCFG (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f4000
[    0.000000] ACPI: ASF! (v032 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f3000
[    0.000000] ACPI: HPET (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f2000
[    0.000000] ACPI: SSDT (v001 INTEL     CpuPm 0x00000629 MSFT 0x01000013) @ 0x000000003e6aa000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu0Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a9000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu1Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a8000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu2Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a7000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu3Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a6000
[    0.000000] ACPI: DSDT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 143) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 255385) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 255398, 255573) 2 entries of 256 used
[    0.000000] Entering add_active_range(0, 255659, 255660) 3 entries of 256 used
[    0.000000] Entering add_active_range(0, 255743, 255744) 4 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[5] active PFN ranges
[    0.000000]     0:        0 ->      143
[    0.000000]     0:      256 ->   255385
[    0.000000]     0:   255398 ->   255573
[    0.000000]     0:   255659 ->   255660
[    0.000000]     0:   255743 ->   255744
[    0.000000] On node 0 totalpages: 255449
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1186 pages reserved
[    0.000000]   DMA zone: 2741 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3440 pages used for memmap
[    0.000000]   DMA32 zone: 248026 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000008f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 000000003e599000 - 000000003e5a6000
[    0.000000] Nosave address range: 000000003e655000 - 000000003e6a6000
[    0.000000] Nosave address range: 000000003e6a6000 - 000000003e6ab000
[    0.000000] Nosave address range: 000000003e6ac000 - 000000003e6f2000
[    0.000000] Nosave address range: 000000003e6f2000 - 000000003e6ff000
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 3f000000:c0f00000)
[    0.000000] PERCPU: Allocating 32192 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 250767
[    0.000000] Kernel command line: root=/dev/sda6 video=intelfb:1024x768@60
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   30.695838] Console: colour VGA+ 80x25
[   30.698825] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   30.699246] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   30.699375] Checking aperture...
[   30.709425] Memory: 998844k/1022976k available (2528k kernel code, 22412k reserved, 1477k data, 232k init)
[   30.768911] Calibrating delay using timer specific routine.. 3732.22 BogoMIPS (lpj=1866110)
[   30.769204] Mount-cache hash table entries: 256
[   30.769519] CPU: L1 I cache: 32K, L1 D cache: 32K
[   30.769583] CPU: L2 cache: 2048K
[   30.769625] using mwait in idle threads.
[   30.769668] CPU: Physical Processor ID: 0
[   30.769711] CPU: Processor Core ID: 0
[   30.769759] CPU0: Thermal monitoring enabled (TM2)
[   30.769816] Freeing SMP alternatives: 28k freed
[   30.769876] ACPI: Core revision 20060707
[   30.787318] Using local APIC timer interrupts.
[   30.840977] result 16650039
[   30.841018] Detected 16.650 MHz APIC timer.
[   30.842418] Booting processor 1/2 APIC 0x1
[   30.853049] Initializing CPU#1
[   30.912874] Calibrating delay using timer specific routine.. 3729.65 BogoMIPS (lpj=1864828)
[   30.912881] CPU: L1 I cache: 32K, L1 D cache: 32K
[   30.912883] CPU: L2 cache: 2048K
[   30.912886] CPU: Physical Processor ID: 0
[   30.912887] CPU: Processor Core ID: 1
[   30.912894] CPU1: Thermal monitoring enabled (TM2)
[   30.913233] Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
[   30.913885] Brought up 2 CPUs
[   30.914323] testing NMI watchdog ... OK.
[   30.924395] time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
[   30.924444] time.c: Detected 1864.805 MHz processor.
[   30.970831] migration_cost=25
[   30.971498] NET: Registered protocol family 16
[   30.971717] ACPI: bus type pci registered
[   30.971766] PCI: Using configuration type 1
[   30.982561] ACPI: Interpreter enabled
[   30.982605] ACPI: Using IOAPIC for interrupt routing
[   30.983723] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   30.983771] PCI: Probing PCI hardware (bus 00)
[   30.983802] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   30.986227] Boot video device is 0000:00:02.0
[   30.986935] PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[   30.986985] PCI quirk: region 0500-053f claimed by ICH6 GPIO
[   30.987956] PCI: Transparent bridge - 0000:00:1e.0
[   30.988065] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   31.000280] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[   31.001963] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[   31.002617] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
[   31.003278] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[   31.003934] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[   31.004594] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
[   31.005255] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[   31.005913] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
[   31.006565] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
[   31.009995] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[   31.010531] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[   31.011077] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[   31.011612] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[   31.012153] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[   31.015799] Linux Plug and Play Support v0.97 (c) Adam Belay
[   31.015864] pnp: PnP ACPI init
[   31.021767] pnp: PnP ACPI: found 13 devices
[   31.022911] SCSI subsystem initialized
[   31.023017] libata version 2.00 loaded.
[   31.023140] usbcore: registered new interface driver usbfs
[   31.023270] usbcore: registered new interface driver hub
[   31.023408] usbcore: registered new device driver usb
[   31.023596] PCI: Using ACPI for IRQ routing
[   31.023640] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   31.023806] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   31.023930] hpet0: 3 64-bit timers, 14318180 Hz
[   31.024989] PCI-GART: No AMD northbridge found.
[   31.025165] pnp: 00:06: ioport range 0x500-0x53f has been reserved
[   31.025215] pnp: 00:06: ioport range 0x400-0x47f could not be reserved
[   31.025264] pnp: 00:06: ioport range 0x680-0x6ff has been reserved
[   31.026116] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[   31.026166] PCI: Bridge: 0000:00:1c.0
[   31.026208]   IO window: disabled.
[   31.026252]   MEM window: 50400000-504fffff
[   31.026297]   PREFETCH window: disabled.
[   31.026342] PCI: Bridge: 0000:00:1c.1
[   31.026385]   IO window: 2000-2fff
[   31.026429]   MEM window: 50100000-501fffff
[   31.026475]   PREFETCH window: disabled.
[   31.026520] PCI: Bridge: 0000:00:1c.2
[   31.026562]   IO window: disabled.
[   31.026606]   MEM window: 50500000-505fffff
[   31.026651]   PREFETCH window: disabled.
[   31.026696] PCI: Bridge: 0000:00:1c.3
[   31.026737]   IO window: disabled.
[   31.026782]   MEM window: 50600000-506fffff
[   31.026827]   PREFETCH window: disabled.
[   31.026876] PCI: Bridge: 0000:00:1c.4
[   31.026918]   IO window: disabled.
[   31.026962]   MEM window: 50700000-507fffff
[   31.027007]   PREFETCH window: disabled.
[   31.027052] PCI: Bridge: 0000:00:1e.0
[   31.027095]   IO window: 1000-1fff
[   31.027140]   MEM window: 50000000-500fffff
[   31.027184]   PREFETCH window: disabled.
[   31.027246] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   31.027334] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   31.027349] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
[   31.027435] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   31.027451] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   31.027537] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   31.027552] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   31.027638] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   31.027652] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
[   31.027739] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   31.027748] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   31.027819] NET: Registered protocol family 2
[   31.040181] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   31.040510] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   31.041444] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   31.042143] TCP: Hash tables configured (established 131072 bind 65536)
[   31.042193] TCP reno registered
[   31.045808] checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
[   31.048307] Freeing initrd memory: 2000k freed
[   31.050066] IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
[   31.051776] fuse init (API version 7.8)
[   31.052029] io scheduler noop registered
[   31.052121] io scheduler cfq registered (default)
[   31.052905] input: Power Button (FF) as /class/input/input0
[   31.052953] ACPI: Power Button (FF) [PWRF]
[   31.053121] input: Sleep Button (CM) as /class/input/input1
[   31.053174] ACPI: Sleep Button (CM) [SLPB]
[   31.053609] ACPI: Processor [CPU0] (supports 8 throttling states)
[   31.053804] ACPI: Processor [CPU1] (supports 8 throttling states)
[   31.053895] ACPI: Getting cpuindex for acpiid 0x3
[   31.053944] ACPI: Getting cpuindex for acpiid 0x4
[   31.060298] Real Time Clock Driver v1.12ac
[   31.060450] hpet_resources: 0xfed00000 is busy
[   31.060456] Linux agpgart interface v0.101 (c) Dave Jones
[   31.060584] agpgart: Detected an Intel 965G Chipset.
[   31.063093] agpgart: Detected 7676K stolen memory.
[   31.075915] agpgart: AGP aperture is 512M @ 0x40000000
[   31.076011] [drm] Initialized drm 1.1.0 20060810
[   31.076078] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[   31.076290] [drm] Initialized i915 1.6.0 20060119 on minor 0
[   31.076338] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
[   31.076409] intelfb: Version 0.9.4
[   31.076533] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   31.076770] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.077661] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.078009] Floppy drive(s): fd0 is 1.44M
[   31.092438] FDC 0 is a National Semiconductor PC87306
[   31.095086] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   31.095941] loop: loaded (max 8 devices)
[   31.095984] Intel(R) PRO/10GbE Network Driver - version 1.0.117-k2
[   31.096032] Copyright (c) 1999-2006 Intel Corporation.
[   31.096660] 8139too Fast Ethernet driver 0.9.28
[   31.096726] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[   31.097207] eth0: RealTek RTL8139 at 0xffffc2000000e000, 00:e0:4c:f0:a9:84, IRQ 21
[   31.097274] eth0:  Identified 8139 chip type 'RTL-8139C'
[   31.097279] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   31.097328] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   31.097521] Probing IDE interface ide0...
[   31.610694] Probing IDE interface ide1...
[   32.124312] ahci 0000:00:1f.2: version 2.0
[   32.124325] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
[   33.125036] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   33.125042] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[   33.125113] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
[   33.125320] ata1: SATA max UDMA/133 cmd 0xFFFFC20000024100 ctl 0x0 bmdma 0x0 irq 19
[   33.125488] ata2: SATA max UDMA/133 cmd 0xFFFFC20000024180 ctl 0x0 bmdma 0x0 irq 19
[   33.125625] ata3: DUMMY
[   33.125734] ata4: DUMMY
[   33.125877] ata5: SATA max UDMA/133 cmd 0xFFFFC20000024300 ctl 0x0 bmdma 0x0 irq 19
[   33.126047] ata6: SATA max UDMA/133 cmd 0xFFFFC20000024380 ctl 0x0 bmdma 0x0 irq 19
[   33.126124] scsi0 : ahci
[   33.584213] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.585522] ata1.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
[   33.586989] ata1.00: configured for UDMA/133
[   33.587039] scsi1 : ahci
[   33.889314] ata2: SATA link down (SStatus 0 SControl 300)
[   33.889368] scsi2 : ahci
[   33.889520] scsi3 : ahci
[   33.889656] scsi4 : ahci
[   34.192407] ata5: SATA link down (SStatus 0 SControl 300)
[   34.192462] scsi5 : ahci
[   34.495480] ata6: SATA link down (SStatus 0 SControl 300)
[   34.495671] scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 ANSI: 5
[   34.495990] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[   34.496050] sda: Write Protect is off
[   34.496093] sda: Mode Sense: 00 3a 00 00
[   34.496116] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   34.496249] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[   34.496309] sda: Write Protect is off
[   34.496351] sda: Mode Sense: 00 3a 00 00
[   34.496374] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   34.496466]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
[   34.550843] sd 0:0:0:0: Attached scsi disk sda
[   34.551052] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   34.551222] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   34.551325] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   34.551399] ata7: PATA max UDMA/100 cmd 0x2018 ctl 0x2026 bmdma 0x2000 irq 17
[   34.551460] scsi6 : pata_marvell
[   34.551614] BAR5:00:00 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:01 0D:00 0E:00 0F:00 
[   34.858084] ata7.00: ATAPI, max MWDMA2
[   35.013190] ata7.00: configured for MWDMA2
[   35.013501] scsi 6:0:0:0: CD-ROM            HL-DT-ST CD-RW GCE-8400B  1.03 PQ: 0 ANSI: 5
[   35.016392] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
[   35.016445] Uniform CD-ROM driver Revision: 3.20
[   35.016644] sr 6:0:0:0: Attached scsi CD-ROM sr0
[   35.016805] sr 6:0:0:0: Attached scsi generic sg1 type 5
[   35.016962] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
[   35.017057] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   35.017060] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   35.017212] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[   35.017335] ehci_hcd 0000:00:1a.7: debug port 1
[   35.017383] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
[   35.017396] ehci_hcd 0000:00:1a.7: irq 18, io mem 0x50325c00
[   35.021323] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   35.021660] usb usb1: configuration #1 chosen from 1 choice
[   35.021803] hub 1-0:1.0: USB hub found
[   35.021853] hub 1-0:1.0: 4 ports detected
[   35.122200] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[   35.122295] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   35.122298] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   35.122440] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[   35.122561] ehci_hcd 0000:00:1d.7: debug port 1
[   35.122608] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   35.122617] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x50325800
[   35.126553] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   35.126849] usb usb2: configuration #1 chosen from 1 choice
[   35.126992] hub 2-0:1.0: USB hub found
[   35.127042] hub 2-0:1.0: 6 ports detected
[   35.228192] USB Universal Host Controller Interface driver v3.0
[   35.228357] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
[   35.228448] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   35.228451] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   35.228579] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[   35.228675] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000030c0
[   35.229004] usb usb3: configuration #1 chosen from 1 choice
[   35.229147] hub 3-0:1.0: USB hub found
[   35.229197] hub 3-0:1.0: 2 ports detected
[   35.330216] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
[   35.330308] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   35.330311] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   35.330452] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[   35.330546] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000030a0
[   35.330866] usb usb4: configuration #1 chosen from 1 choice
[   35.331016] hub 4-0:1.0: USB hub found
[   35.331066] hub 4-0:1.0: 2 ports detected
[   35.432238] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[   35.432329] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   35.432332] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   35.432479] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[   35.432569] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
[   35.432882] usb usb5: configuration #1 chosen from 1 choice
[   35.433026] hub 5-0:1.0: USB hub found
[   35.433076] hub 5-0:1.0: 2 ports detected
[   35.534251] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   35.534342] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   35.534345] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   35.534489] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[   35.534580] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
[   35.534905] usb usb6: configuration #1 chosen from 1 choice
[   35.535045] hub 6-0:1.0: USB hub found
[   35.535097] hub 6-0:1.0: 2 ports detected
[   35.636320] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   35.636420] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   35.636423] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   35.636585] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[   35.636675] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[   35.636995] usb usb7: configuration #1 chosen from 1 choice
[   35.637149] hub 7-0:1.0: USB hub found
[   35.637199] hub 7-0:1.0: 2 ports detected
[   35.738468] usbcore: registered new interface driver cdc_acm
[   35.738519] drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
[   35.738675] usbcore: registered new interface driver usblp
[   35.738723] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   35.738775] Initializing USB Mass Storage driver...
[   35.738893] usbcore: registered new interface driver usb-storage
[   35.738941] USB Mass Storage support registered.
[   35.739163] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   35.742158] serio: i8042 KBD port at 0x60,0x64 irq 1
[   35.742206] serio: i8042 AUX port at 0x60,0x64 irq 12
[   35.742393] mice: PS/2 mouse device common for all mice
[   35.742801] i2c /dev entries driver
[   35.743009] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 21 (level, low) -> IRQ 21
[   35.763620] EDAC MC: Ver: 2.0.1 Jan  1 2007
[   35.764033] Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Wed Dec 20 08:11:48 2006 UTC).
[   35.764808] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
[   35.764908] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   35.886596] ALSA device list:
[   35.886644]   #0: HDA Intel at 0x50320000 irq 22
[   35.886718] nf_conntrack version 0.5.0 (3996 buckets, 31968 max)
[   35.886890] ip_tables: (C) 2000-2006 Netfilter Core Team
[   35.928506] TCP cubic registered
[   35.928567] NET: Registered protocol family 1
[   35.928629] NET: Registered protocol family 17
[   35.930585] NET: Registered protocol family 15
[   36.463434] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
[   36.486984] input: AT Translated Set 2 keyboard as /class/input/input3
[   36.538215] RAMDISK: ext2 filesystem found at block 0
[   36.538269] RAMDISK: Loading 2000KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done.
[   36.544842] VFS: Mounted root (ext2 filesystem).
[   36.566730] EXT3-fs: INFO: recovery required on readonly filesystem.
[   36.566733] EXT3-fs: write access will be enabled during recovery.
[   36.607168] kjournald starting.  Commit interval 5 seconds
[   36.607180] EXT3-fs: recovery complete.
[   36.607634] EXT3-fs: mounted filesystem with ordered data mode.
[   36.607751] VFS: Mounted root (ext3 filesystem) readonly.
[   36.607754] Trying to move old root to /initrd ... /initrd does not exist. Ignored.
[   36.611497] Unmounting old root
[   36.611708] Trying to free ramdisk memory ... okay
[   36.612004] Freeing unused kernel memory: 232k freed
[   41.326389] EXT3 FS on sda6, internal journal
[   44.093173] kjournald starting.  Commit interval 5 seconds
[   44.093377] EXT3 FS on sda8, internal journal
[   44.093381] EXT3-fs: mounted filesystem with ordered data mode.
[   44.161756] Adding 1004016k swap on /dev/sda7.  Priority:-1 extents:1 across:1004016k
[   65.317093] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[  330.980512] Machine check events logged
[  434.698062] ISO 9660 Extensions: Microsoft Joliet Level 3
[  434.715801] ISO 9660 Extensions: RRIP_1991A

--MP_oRlYmJidYbc7t+vcLfzUswF
Content-Type: text/plain; name=lspci.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci.txt

00:00.0 Host bridge: Intel Corporation Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Integrated Graphics Controller (rev 02)
00:03.0 Communication controller: Intel Corporation HECI Controller (rev 02)
00:19.0 Ethernet controller: Intel Corporation Ethernet Controller (rev 02)
00:1a.0 USB Controller: Intel Corporation USB UHCI Controller #4 (rev 02)
00:1a.1 USB Controller: Intel Corporation USB UHCI Controller #5 (rev 02)
00:1a.7 USB Controller: Intel Corporation USB2 EHCI Controller #2 (rev 02)
00:1b.0 Audio device: Intel Corporation HD Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation PCI Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation PCI Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation PCI Express Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation PCI Express Port 4 (rev 02)
00:1c.4 PCI bridge: Intel Corporation PCI Express Port 5 (rev 02)
00:1d.0 USB Controller: Intel Corporation USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation USB UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation USB2 EHCI Controller #1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation SATA Controller AHCI (rev 02)
00:1f.3 SMBus: Intel Corporation SMBus Controller (rev 02)
02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

--MP_oRlYmJidYbc7t+vcLfzUswF
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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

--MP_oRlYmJidYbc7t+vcLfzUswF--
