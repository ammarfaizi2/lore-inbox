Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313078AbSDJN5n>; Wed, 10 Apr 2002 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313075AbSDJN5m>; Wed, 10 Apr 2002 09:57:42 -0400
Received: from wb1-a.mail.utexas.edu ([128.83.126.134]:1798 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S313070AbSDJN5j> convert rfc822-to-8bit;
	Wed, 10 Apr 2002 09:57:39 -0400
Date: Wed, 10 Apr 2002 09:02:05 -0500 (CDT)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: linux-kernel@vger.kernel.org
Subject: Mouse interrupts: the death knell of a VP6
In-Reply-To: <20020206191108.A11277@suse.de>
Message-ID: <20020410083504.Y60587-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Troubleshooters,

I have an ABIT VP6 motherboard, using the VIA Apollo chipset and 2 700Mhz
PIII's, but please don't hold that against me. The system is running
2.4.19-pre6. I believe that I either have a system that has trouble
handling a sudden bursts of interrupts, or have found a fault in mouse
handling.

When using a PS/2 mouse, the system tends to hang completely whenever
there is sudden mouse movement after a brief period of inactivity when
using X11 or gpm (this usually occurs within an hour). If I run the system
with one processor, this hang occurs less frequently. Also, if I disable
ACPI in the bios, the hang also occurs less frequently, but in all cases,
the system is stuck within a few hours of normal use (sometimes a few
minutes.)

When I run the system using a USB mouse (using the regular usb-uhci driver
with the hci or usbmouse drivers), within a couple of hours with both
processors installed, the mouse hangs, but does not hang the entire
system. Luckily, I was able to get dmesg to run, which is posted at the
bottom of this message. This chronicles up to the the first USB mouse
hang. The system had run overnight, but when I touched the mouse in the
morning, it stopped within ten minutes.

What appears to happen in both mouse cases is that an cascade of
interrupts occur, triggered by the mouse, which does not leave the
interrupt handler properly. If I could get my system console to redirect
to a serial terminal, I would bet that an interrupt problem is reported by
the kernel shortly before the hang with the PS/2 mouse. Is it true that
Linux allows hardware interrupts to interrupt other hardware interrupts?
Would a mouse be able to cause so many interrupts that some sort of stack
for recursing back through interrupt handlers will overflow? Or, do I just
have bad hardware?

I have already tried removing memory, adding memory, changing processors,
video cards. The only thing that has remained constant is the VP6
motherboard and the hard drive.

Thanks for any help. I'm going to see if hardware interrupts are disabled
while handling the mouse for now.

 - Brent

Linux version 2.4.19-pre6 (busterb@stampy) (gcc version 2.95.3 20010315 (release)) #6 SMP Tue Apr 9 20:40:36 CDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
found SMP MP-table at 000f5700
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux2419p6 ro root=307
Initializing CPU#0
Detected 703.183 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1402.47 BogoMIPS
Memory: 905028k/917504k available (1152k kernel code, 12092k reserved, 387k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.87 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1405.74 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (2808.21 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-12, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
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
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 703.1004 MHz.
..... host bus clock speed is 100.4427 MHz.
cpu: 0, clocks: 1004427, slice: 334809
CPU0<T0:1004416,T1:669600,D:7,S:334809,C:1004427>
cpu: 1, clocks: 1004427, slice: 334809
CPU1<T0:1004416,T1:334784,D:14,S:334809,C:1004427>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 5 to 3
PCI: Via IRQ fixup for 00:07.3, from 5 to 3
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12 (20020219) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 90845D4, ATA DISK drive
hdb: Pioneer CD-ROM ATAPI Model DR-A02S 0108, ATAPI CD/DVD-ROM drive
hdc: Maxtor 90845D4, ATA DISK drive
hdd: CREATIVE DVD-ROM DVD6240E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/256KiB Cache, CHS=16383/16/63, UDMA(33)
hdc: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
hdb: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 >
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [1027/255/63] p1 p2 p3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd0000000
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 232k freed
Adding Swap: 262512k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Linux Tulip driver version 0.9.15-pre10 (Mar 8, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xf8886000, 02:00:09:E3:27:36, IRQ 17.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
usb.c: deregistering driver hiddev
usb.c: deregistering driver hid
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: deregistering driver usb_mouse
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 20:14:35 Apr  9 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x9400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x9800, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x45e/0x39) is not claimed by any active driver.
usb.c: registered new driver usb_mouse
usb-uhci.c: interrupt, status 3, frame# 717
input0: Microsoft Microsoft IntelliMouse® Optical on usb1:2.0
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
usb.c: USB disconnect on device 2
hub.c: USB new device connect on bus1/1, assigned device number 3
usb-uhci.c: interrupt, status 3, frame# 62
input0: Microsoft Microsoft IntelliMouse® Optical on usb1:3.0
usb.c: USB disconnect on device 3
hub.c: USB new device connect on bus1/1, assigned device number 4
usb-uhci.c: interrupt, status 3, frame# 1668
input0: Microsoft Microsoft IntelliMouse® Optical on usb1:4.0
usb.c: USB disconnect on device 4
hub.c: USB new device connect on bus1/1, assigned device number 5
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=5 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 6
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=6 (error=-110)

