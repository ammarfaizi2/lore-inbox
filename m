Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTKOEjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 23:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTKOEjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 23:39:14 -0500
Received: from CPE-138-130-214-20.qld.bigpond.net.au ([138.130.214.20]:29353
	"EHLO jeeves.home.house") by vger.kernel.org with ESMTP
	id S261433AbTKOEjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 23:39:02 -0500
Message-ID: <43376.138.130.214.20.1068871325.squirrel@jeeves.home.house>
Date: Sat, 15 Nov 2003 14:42:05 +1000 (EST)
Subject: 2.6.0 yenta_socket eats kernel time on Toshiba Laptop
From: "Ben Hoskings" <ben@jeeves.bpa.nu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all. First post to the list after lurking for a while; berate me if I'm
doing something wrong. ;)
I searched the archives but didn't find anything on this topic.

I've got a Toshiba Satellite Pro 4300 (PIII-750 on an Intel 440BX
chipset). Modprobing yenta_socket under 2.6.0 (I've tried test6 to test9
inclusive) causes the system to appear to lock up.
Once I managed to change consoles and run top (each keystroke took a good
20 seconds to echo), which showed that the kernel was using 100% CPU time.

Attepting a modprobe on any of the other PCMCIA bus drivers gives a
'device not found' error.

Under 2.4, the PCMCIA bus uses the i82365 module, which works perfectly.
Under 2.6, it appears that the related driver has been moved to the
yenta_socket module (It's a ToPIC100 Controller; see dmesg below).

Has anyone else with a ToPIC controller seen this behaviour?

Thanks,
Ben Hoskings <ben@jeeves.bpa.nu>


dmesg output under 2.4.22
-------------------------
Linux version 2.4.22 (root@laptop) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r1, propolice)) #1 Thu Aug 28 22:57:45 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 00000000000e8640 (reserved)
 BIOS-e820: 00000000000e8640 - 00000000000e8840 (ACPI NVS)
 BIOS-e820: 00000000000e8840 - 00000000000ec000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013fe0000 (usable)
 BIOS-e820: 0000000013fe0000 - 0000000013ff0000 (ACPI data)
 BIOS-e820: 0000000013ff0000 - 0000000014000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
319MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 81888
zone(0): 4096 pages.
zone(1): 77792 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f0170
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x13fe0000
ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x13fe0054
ACPI: DSDT (v001 TOSHIB 4220     0x20000613 MSFT 0x0100000a) @ 0x00000000
ACPI: MADT not present
Kernel command line: root=/dev/hda2 video=vesa:mtrr vga=791 acpi=force
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 746.347 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1490.94 BogoMIPS
Memory: 321444k/327552k available (1349k kernel code, 5720k reserved, 305k
data, 288k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: Using configuration type 1
    ACPI-0109: *** Error: No object was returned from [\_SB_.LNKA._STA]
(Node c137c760), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from [\_SB_.LNKB._STA]
(Node c137c860), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from [\_SB_.LNKC._STA]
(Node c137c960), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from [\_SB_.LNKD._STA]
(Node c137ca60), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from
[\_SB_.PCI0.FNC0.FDD_._STA] (Node d3efeee0), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from
[\_SB_.PCI0.FNC0.COM_._STA] (Node d3efd200), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from
[\_SB_.PCI0.FNC0.PRT_._STA] (Node d3efd380), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from
[\_SB_.PCI0.FNC0.PRT1._STA] (Node d3efd460), AE_NOT_EXIST
    ACPI-0109: *** Error: No object was returned from
[\_SB_.PCI0.FNC0.PCC0._STA] (Node d3efd560), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
    ACPI-0109: *** Error: No object was returned from [\_SB_.LNKE._PRS]
(Node c137cb80), AE_NOT_EXIST
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [PIHD] (on)
ACPI: Power Resource [PMHD] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
PCI: Probing PCI hardware
PCI: No IRQ known for interrupt pin D of device 00:05.2
PCI: No IRQ known for interrupt pin A of device 00:07.0
PCI: No IRQ known for interrupt pin A of device 00:09.0
PCI: No IRQ known for interrupt pin A of device 00:0b.0 - using IRQ 255
PCI: No IRQ known for interrupt pin B of device 00:0b.1 - using IRQ 255
PCI: No IRQ known for interrupt pin A of device 00:0c.0
PCI: No IRQ known for interrupt pin A of device 01:00.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (31 C)
vesafb: framebuffer at 0xf0000000, mapped to 0xd4807000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:8751
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 256M @ 0xd0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:05.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATDA04-0, ATA DISK drive
blk: queue c0310000, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=3648/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,2)) ...
for (ide0(3,2))
ide0(3,2):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 288k freed
Adding Swap: 248968k swap-space (priority -1)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,6)) ...
for (ide0(3,6))
ide0(3,6):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,7)) ...
for (ide0(3,7))
ide0(3,7):Using r5 hash to sort names
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Linux PCMCIA Card Services 3.2.4
  kernel build: 2.4.22 #1 Thu Aug 28 22:57:45 EST 2003
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Enabling device 00:0b.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 00:0b.0 - using IRQ 255
PCI: Enabling device 00:0b.1 (0000 -> 0002)
PCI: No IRQ known for interrupt pin B of device 00:0b.1 - using IRQ 255
  Toshiba ToPIC100 rev 20 PCI-to-CardBus at slot 00:0b, mem 0x14000000
    host opts [0]: [slot 0xd0] [ccr 0x11] [cdr 0x86] [rcr 0xc000000] [no
pci irq] [lat 64/176] [bus 20/20]
    host opts [1]: [slot 0xd0] [ccr 0x21] [cdr 0x86] [rcr 0xc000000] [no
pci irq] [lat 64/176] [bus 21/21]
    ISA irqs (default) = 4,5,7,10,12 polling interval = 1000 ms
cs: memory probe 0x0d0000-0x0dffff: clean.
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x378-0x37f
0x4d0-0x4d7
cs: IO port probe 0x0300-0x0377: clean.
cs: IO port probe 0x0380-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
eth0: MII link partner: 0021
eth0: MII selected
eth0: media 10BaseT, silicon revision 5
eth0: Xircom: port 0x300, irq 5, hwaddr 00:10:A4:F3:D3:86
ttyS03 at port 0x02e8 (irq = 5) is a 16550A
eth0: MII link partner: 0021
eth0: MII selected
eth0: media 10BaseT, silicon revision 5
devfs_register(2): could not append to parent, err: -17
devfs_register(a2): could not append to parent, err: -17
devfs_register(3): could not append to parent, err: -17
devfs_register(a3): could not append to parent, err: -17
devfs_register(7): could not append to parent, err: -17
devfs_register(a7): could not append to parent, err: -17
mtrr: 0xf0000000,0x800000 overlaps existing 0xf0000000,0x200000
inserting floppy driver for 2.4.22
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: No IRQ known for interrupt pin A of device 00:0c.0
ymfpci: YMF744 at 0xefff8000 IRQ 11
ac97_codec: AC97 Audio codec, id: AKM2 (Asahi Kasei AK4543)
SCSI subsystem driver Revision: 1.00

