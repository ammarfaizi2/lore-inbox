Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271119AbTHQXfV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 19:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271124AbTHQXfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 19:35:21 -0400
Received: from bayxiii.ne.client2.attbi.com ([65.96.167.187]:48122 "EHLO
	galaxia.bay13.org") by vger.kernel.org with ESMTP id S271119AbTHQXe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 19:34:57 -0400
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, gtm.kramer@inter.nl.net
Subject: High interrupt load with ICH5 and ide-scsi & no mounted fs (on 2.4.21)
Date: Sun, 17 Aug 2003 19:34:55 -0400
From: Erik Nygren <nygren@mit.edu>
Message-Id: <E19oX31-0000YH-00@galaxia.bay13.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the 2.4.21 kernel I'm seeing extremely high interrupt/system loads
(on the order of 15,000 interrupts/sec) on irq 11 when I load the ide-scsi
module.  Mounting a filesystem on my CD drive (the only ide-scsi
device) causes the interrupts to go back to a normal level.  Removing
the ide-scsi module doesn't cause the problem to clear up (the high
level of interrupts continue).  The interrupt level is high enough to
cause the system to lock up entirely sometimes until some other
interrupt (eg, from my USB mouse) is received.
Until I load ide-scsi, things work fine.

Motherboard is an ASUS P4C800-E with the 875P/ICH5-R chipset.
I have the BIOS configured into "enhanced" mode.  
The CD drive is a "Sony DVD RW DW-U10A" (actually a DVD[+-]RW drive).

Twiddling unmaskirq in /proc/ide/hdc/settings does not help.
Enabling debugging in ide-scsi.c doesn't yield anything.

Thoughts of where I might want to look?    

# cat /proc/interrupts 
           CPU0       CPU1       
  0:     323428          0    IO-APIC-edge  timer
  1:       7715          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:     129965          0   IO-APIC-level  ehci-hcd, EMU10K1
  8:          3          0    IO-APIC-edge  rtc
 10:     266944          0   IO-APIC-level  usb-uhci, usb-uhci, nvidia
 11:   21509292        131   IO-APIC-level  ide0, ide1, ide2, usb-uhci, eth0
 15:      33947          0   IO-APIC-level  usb-uhci
NMI:          0          0 
LOC:     323876     323876 
ERR:          0
MIS:        132


>From dmesg:

Linux version 2.4.21-p4smp-2 (root@galaxia) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Thu Aug 7 23:08:04 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 261936
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32560 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f9fb0
RSD PTR  v0 [ACPIAM]
__va_range(0x3ff30000, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [A M I  OEMRSDT  1536.770]
__va_range(0x3ff30200, 0x24): idx=8 mapped at ffff6000
__va_range(0x3ff30200, 0x81): idx=8 mapped at ffff6000
ACPI table found: FACP v2 [A M I  OEMFACP  1536.770]
__va_range(0x3ff30390, 0x24): idx=8 mapped at ffff6000
__va_range(0x3ff30390, 0x5c): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [A M I  OEMAPIC  1536.770]
__va_range(0x3ff30390, 0x5c): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
CPU 1 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16

IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
2 CPUs total
Local APIC address fee00000
__va_range(0x3ff40040, 0x24): idx=8 mapped at ffff6000
__va_range(0x3ff40040, 0x3f): idx=8 mapped at ffff6000
ACPI table found: OEMB v1 [A M I  OEMBIOS  1536.770]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTek  Product ID: P4C800-E     APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux2421smp2 ro root=2101
Initializing CPU#0
Detected 2798.698 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5583.66 BogoMIPS
Memory: 1032540k/1047744k available (1281k kernel code, 14816k reserved, 586k data, 112k init, 130240k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1463.16 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5596.77 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11180.44 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-14, 2-15, 2-21 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
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
.... register #02: 00178020
.......     : arbitration: 00
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 003 03  1    1    0   1   0    1    1    81
 11 003 03  1    1    0   1   0    1    1    89
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 003 03  1    1    0   1   0    1    1    81
 15 000 00  1    0    0   0   0    0    0    00
 16 003 03  1    1    0   1   0    1    1    A1
 17 003 03  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:22-> 0:23
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:16-> 0:20
IRQ11 -> 0:18
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:17
IRQ15 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2798.7566 MHz.
..... host bus clock speed is 199.9108 MHz.
cpu: 0, clocks: 1999108, slice: 666369
CPU0<T0:1999104,T1:1332720,D:15,S:666369,C:1999108>
cpu: 1, clocks: 1999108, slice: 666369
CPU1<T0:1999104,T1:666352,D:14,S:666369,C:1999108>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router default [8086/24d0] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 11
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:DMA, hdd:pio
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 11
    ide2: BM-DMA at 0xee60-0xee67, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xee68-0xee6f, BIOS settings: hdg:pio, hdh:pio
hda: IC35L120AVVA07-0, ATA DISK drive
blk: queue c034af00, I/O limit 4095Mb (mask 0xffffffff)
hdc: SONY DVD RW DW-U10A, ATAPI CD/DVD-ROM drive
hde: WDC WD360GD-00FNA0, ATA DISK drive
blk: queue c034b7e8, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0xefe0-0xefe7,0xefae on irq 11
ide1 at 0xefa0-0xefa7,0xefaa on irq 11
ide2 at 0xef88-0xef8f,0xef86 on irq 11
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 72303840 sectors (37020 MB) w/8192KiB Cache, CHS=4500/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci-hcd 00:1d.7: PCI device 8086:24dd (Intel Corp.)
ehci-hcd 00:1d.7: irq 5, pci mem f8802c00
usb.c: new USB bus registered, assigned bus number 1
ehci-hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 128.
ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 8 ports detected
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
host/uhci.c: USB UHCI at I/O 0xeec0, IRQ 10
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
host/uhci.c: USB UHCI at I/O 0xef00, IRQ 15
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
host/uhci.c: USB UHCI at I/O 0xef20, IRQ 11
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
host/uhci.c: USB UHCI at I/O 0xef40, IRQ 10
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide2(33,1): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 539806
EXT3-fs: ide2(33,1): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
hub.c: new USB device 00:1d.7-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x4b8/0x11e) is not claimed by any active driver.
Adding Swap: 1172736k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
Real Time Clock Driver v1.10e
hub.c: new USB device 00:1d.0-1, assigned address 2
hub.c: USB hub found
hub.c: 7 ports detected
hub.c: new USB device 00:1d.0-1.3, assigned address 3
usb.c: USB device 3 (vend/prod 0x403/0xfa78) is not claimed by any active driver.
hub.c: new USB device 00:1d.0-1.7, assigned address 4
usb.c: USB device 4 (vend/prod 0x403/0xfa78) is not claimed by any active driver.
hub.c: new USB device 00:1d.1-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc024) is not claimed by any active driver.
Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Copyright (c) 1999-2003 Intel Corporation.
PCI: Setting latency timer of device 02:01.0 to 64
eth0: Intel(R) PRO/1000 Network Connection
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Trying generic Intel routines for device id: 2578
agpgart: AGP aperture is 64M @ 0xf8000000
Creative EMU10K1 PCI Audio Driver, version 0.20, 23:11:18 Aug  7 2003
emu10k1: EMU10K1 rev 10 model 0x8065 found, IO at 0xdf80-0xdf9f, IRQ 5
ac97_codec: AC97 Audio codec, id: EMC40 (Unknown)
emu10k1: SBLive! 5.1 card detected
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex


Thanks,  Erik
