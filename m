Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUHYAJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUHYAJO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268694AbUHYAJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:09:14 -0400
Received: from gelf.bodgit-n-scarper.com ([81.5.167.74]:36310 "EHLO
	mail.bodgit-n-scarper.com") by vger.kernel.org with ESMTP
	id S268719AbUHYAFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:05:53 -0400
Subject: GA-7DPXDW-P USB Problem
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-knLq5mszsfMtEDZkNYhI"
Message-Id: <1093392348.13720.44.camel@lister.bodgit-n-scarper.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 25 Aug 2004 01:05:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-knLq5mszsfMtEDZkNYhI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to get a Mitsumi 6-in-1 card reader to work on a Gigabyte
GA-7DPXDW-P 760MPX motherboard. It's an internal device that plugs onto
the USB headers on a motherboard in place of the extra 'front' ports.

When the machine boots up, I just get these kernel messages related to
the device:

hub.c: new USB device 02:00.0-3, assigned address 3
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: new USB device 02:00.0-3, assigned address 4
usb.c: USB device not accepting new address=4 (error=-110)

The device remains unseen to the kernel. I've had it working fine on an
Abit KT7 motherboard. I've also tried attaching some USB ports to the
header and anything plugged into them also produces the same error
above, but plugging them into different USB ports works fine.

When the motherboard USB controller driver is loaded (OHCI), it seems to
detect all 4 ports (two on the back, two on this motherboard header):

usb-ohci.c: USB OHCI at membase 0xf88e7000, IRQ 19
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 4 ports detected

The two ports on the back work fine, I have a Zaurus cradle and the hub
built into my monitor plugged into those, and the devices work. I've
tried unplugging them and that makes no difference.

I've found other people with similar issues, (same -110 error code), but
with no real solution, IRQ routing seems to be hinted at, but the rear
ports, which look to be part of the same device, work okay. The
controller also appears to get its own IRQ #19 with nothing else sharing
it, and its interrupt count goes up.

I've also tried booting with noapic, no difference, pci=noacpi, that
stops my Adaptec SCSI controller from working, SCSI errors start
appearing as soon as the buses are scanned for devices and the machine
won't boot. I've also tried removing all 'unnecessary' PCI cards,
(leaving just the AGP graphics card and PCI SCSI controller) and that
makes no difference either.

This is all with the latest FC1 2.4.22-1-2199 (stock apart from me
adding the saa7134 v4l2 driver) kernel, although I did try booting the
latest FC2 2.6.8-1.521 kernel, but that produced the same -110 error
code.

Anyone else got the 'front' USB ports working on this motherboard? I'm
fairly sure this motherboard is recent enough to not have the broken MPX
chipset, I certainly didn't get a PCI USB card with it.

I've attached full dmesg if that's useful. Anything else I can try?

Cheers

Matt

--=-knLq5mszsfMtEDZkNYhI
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=
Content-Transfer-Encoding: 7bit

Linux version 2.4.22-1.2199.nptl.bodgitsmp (matt@lister.bodgit-n-scarper.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 SMP Fri Aug 20 14:27:36 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000f4df0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
ACPI: RSDP (v000 AMD2P                                     ) @ 0x000f6830
ACPI: RSDT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
ACPI: FADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
ACPI: MADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff6300
ACPI: DSDT (v001 AMD2P  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: ro root=/dev/md0 rhgb acpi=on
Initializing CPU#0
Detected 2133.430 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4259.84 BogoMIPS
Memory: 1031664k/1048512k available (1581k kernel code, 16460k reserved, 1178k data, 168k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 2800+ stepping 00
per-CPU timeslice cutoff: 1462.85 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4259.84 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) MP stepping 00
Total of 2 processors activated (8519.68 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
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
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
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
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2133.4421 MHz.
..... host bus clock speed is 266.6800 MHz.
cpu: 0, clocks: 2666800, slice: 888933
CPU0<T0:2666800,T1:1777856,D:11,S:888933,C:2666800>
cpu: 1, clocks: 2666800, slice: 888933
CPU1<T0:2666800,T1:888928,D:6,S:888933,C:2666800>
Starting migration thread for cpu 0
smp_num_cpus: 2.
Starting migration thread for cpu 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfa320, last bus=2
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPP._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:08[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:08[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:08[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:08[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Setting AMD recommended values for PCI bus. It isn't fully PCI standards compliant
PCI: Via IRQ fixup for 02:04.0, from 11 to 0
PCI: Via IRQ fixup for 02:04.1, from 12 to 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
PDC20276: IDE controller at PCI slot 02:08.0
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-floppy driver.
hda: No disk in drive
hda: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 325k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue f7fc6018, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:5): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:8): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: UMAX      Model: Astra 1220S       Rev: V1.3
  Type:   Scanner                            ANSI SCSI revision: 02
blk: queue f7fa0e18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST318452LC        Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7fc7618, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST318452LC        Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7fc6418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST336752LC        Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7fc6a18, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:5:0: Tagged Queuing enabled.  Depth 32
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
scsi0:A:8:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 8, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
SCSI device sdc: 71687369 512-byte hdwr sectors (36704 MB)
 sdc: sdc1
LVM version 1.0.5+(22/07/2002) module loaded
md: raid0 personality registered as nr 2
Journalled Block Device driver loaded
md: Autodetecting RAID arrays.
 [events: 0000014d]
 [events: 00000155]
 [events: 0000014d]
 [events: 00000155]
md: autorun ...
md: considering sdb4 ...
md:  adding sdb4 ...
md:  adding sda4 ...
md: created md1
md: bind<sda4,1>
md: bind<sdb4,2>
md: running: <sdb4><sda4>
md: sdb4's event counter: 00000155
md: sda4's event counter: 00000155
md1: max total readahead window set to 512k
md1: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at sda4
raid0:   comparing sda4(16554880) with sda4(16554880)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb4
raid0:   comparing sdb4(16554880) with sda4(16554880)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda4 ... contained as device 0
  (16554880) is smallest!.
raid0: checking sdb4 ... contained as device 1
raid0: zone->nb_dev: 2, size: 33109760
raid0: current zone offset: 16554880
raid0: done.
raid0 : md_size is 33109760 blocks.
raid0 : conf->smallest->size is 33109760 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md1 RAID superblock on device
md: sdb4 [events: 00000156]<6>(write) sdb4's sb offset: 16554880
md: sda4 [events: 00000156]<6>(write) sda4's sb offset: 16554880
md: considering sdb3 ...
md:  adding sdb3 ...
md:  adding sda3 ...
md: created md0
md: bind<sda3,1>
md: bind<sdb3,2>
md: running: <sdb3><sda3>
md: sdb3's event counter: 0000014d
md: sda3's event counter: 0000014d
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at sda3
raid0:   comparing sda3(505920) with sda3(505920)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb3
raid0:   comparing sdb3(505920) with sda3(505920)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda3 ... contained as device 0
  (505920) is smallest!.
raid0: checking sdb3 ... contained as device 1
raid0: zone->nb_dev: 2, size: 1011840
raid0: current zone offset: 505920
raid0: done.
raid0 : md_size is 1011840 blocks.
raid0 : conf->smallest->size is 1011840 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: sdb3 [events: 0000014e]<6>(write) sdb3's sb offset: 505920
md: sda3 [events: 0000014e]<6>(write) sda3's sb offset: 505920
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 168k freed
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 14:47:06 Aug 20 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xa000, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xa400, IRQ 17
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
ehci_hcd 02:04.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 02:04.2: irq 18, pci mem f88de000
usb.c: new USB bus registered, assigned bus number 3
ehci_hcd 02:04.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 4 ports detected
usb-ohci.c: USB OHCI at membase 0xf88e7000, IRQ 19
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
loop: loaded (max 8 devices)
Adding Swap: 755044k swap-space (priority 1)
Adding Swap: 755044k swap-space (priority 1)
hub.c: connect-debounce failed, port 1 disabled
gameport0: Emu10k1 Gameport at 0xb000 size 8 speed 932 kHz
input0: Analog 2-axis 4-button joystick at gameport0.0 [TSC timer, 2132 MHz clock, 1110 ns res]
hub.c: new USB device 02:00.0-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hub.c: new USB device 02:00.0-3, assigned address 3
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: new USB device 02:00.0-3, assigned address 4
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: new USB device 02:00.0-2.1, assigned address 5
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb4:5.0
hub.c: new USB device 02:00.0-2.3, assigned address 6
usb.c: USB device 6 (vend/prod 0xa12/0x1) is not claimed by any active driver.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 07:55:38 PDT 2004
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 256M @ 0xd0000000
hub.c: new USB device 02:00.0-2.4, assigned address 7
usb.c: USB device 7 (vend/prod 0x6cd/0x121) is not claimed by any active driver.
Linux video capture interface: v1.00
i2c-core.o: i2c core module
saa7130/34: v4l2 driver version 0.2.12 loaded
saa7134[0]: found at 02:06.0, rev: 1, irq: 18, latency: 32, mmio: 0xf4024000
saa7134[0]: subsystem: 5168:0138, board: LifeView FlyVIDEO3000 [card=2,insmod option]
saa7134[0]: board init: gpio is 39000
saa7134[0]: registered input device for IR
i2c-core.o: adapter saa7134[0] registered as adapter 0.
saa7134[0]: i2c eeprom 00: 68 51 38 01 10 28 ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found at addr 0xc2 i2c-bus saa7134[0]
tuner: type set to 1 (Philips PAL_I (FI1246 and compatibles)) by saa7134[0]
i2c-core.o: client [Philips PAL_I (FI1246 and compa] registered to adapter [saa7134[0]](pos. 0).
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
hub.c: new USB device 02:04.2-1, assigned address 2
hub.c: USB hub found
hub.c: 7 ports detected
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
usbdfu.c: USB Device Firmware Upgrade (DFU) handler v0.11beta4-ac1
usb.c: registered new driver usbdfu
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Keyspan - (without firmware)
usbserial.c: USB Serial support registered for Keyspan 1 port adapter
usbserial.c: Keyspan 1 port adapter converter detected
usbserial.c: Keyspan 1 port adapter converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: USB Serial support registered for Keyspan 2 port adapter
usbserial.c: USB Serial support registered for Keyspan 4 port adapter
keyspan.c: v1.1.4:Keyspan USB to Serial Converter Driver
ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[f4028000-f40287ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0894000000000bee]

--=-knLq5mszsfMtEDZkNYhI--

