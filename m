Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUAIQFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUAIQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:05:39 -0500
Received: from boreas.telenet-ops.be ([195.130.132.48]:18368 "EHLO
	boreas.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262052AbUAIQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:05:03 -0500
Date: Fri, 9 Jan 2004 17:05:00 +0100
From: CBke <cb@linux.be>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: pc hangs after cdrdao read-toc icotl on ATAPI 2.6.1-rc3
Message-Id: <20040109170500.7203715e@localhost>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux CBke 2.6.1-rc3 #1 Fri Jan 9 04:46:10 CET 2004 i686 AMD Athlon(tm) processor AuthenticAMD GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre5
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         nvidia

pc hangs after cdrdao read-toc icotl on ATAPI 

after performing cdrdao read-toc --driver generic-mmc --device /dev/hdd test.toc (as root) the pc hangs (not the case with 2.4.22)

cat /proc/version
Linux version 2.6.1-rc3 (root@CBke) (gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 Fri Jan 9 04:46:10 CET 2004

I used a self written cd (16 tracks AUDIO) and tested it on  hdd: "ATAPI 48X CD-ROM drive, 128kB Cache, DMA"

the log from strace:

open("/dev/hdd", O_RDONLY|O_NOBLOCK) = 3
ioctl(3, 0x2202, 0) =0
close(3)
open("/dev/hdd", O_RDWR|O_NONBLOCK) = 3
fcntl64(3, F_GETFL) = 0x8802 (flags O_RDWR|O_NOBLOCK|O_LARGEFILE)
fcnt64(3, F_SETFL, O_RDWR|O_LARGEFILE) = 0
ioctl(3, 0x5382  0xbffff3d0)  = 0
ioctl(3, 0x5386  0xbffff3cc)  = 0
ioctl(3, 0x2282  0xbffff3d4)  = 0
ioctl(3, 0x5382  0xbffff370)  = 0
ioctl(3, 0x5386  0xbffff36c)  = 0
ioctl(3, 0x2201  0xbffff264)  = 0
fstat64(3, {st_mode=SIFBLK|0600,st_rdev=makedev(22,64,...})  = 0
ioctl(3, 0x2272, 0xbffff5c8 ) = 0
ioctl(3, 0x2275, 0xbffff5c4 ) = 0
ioctl(3, 0x2272, 0xbffff5c4 ) = 0
ioctl(3, 0x2272, 0xbffff5c8 ) = 0
ioctl(3, 0x2272, 0xbffff5c4 ) = 0
write(2 "Using libscg version shily_0.7) = 33
gettimeofday({1073656327, 811541}, NULL) = 0
ioctl(3, 0x2285

and there it stopped. I wrote this down on a peice of paper.

This happend everytime single time.
my dmesg :

Linux version 2.6.1-rc3 (root@CBke) (gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 Fri Jan 9 04:46:10 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 VT8371                                    ) @ 0x000f7900
ACPI: RSDT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 VT8371 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: hda=autotune  hdc=autotune hdd=autotune   root=/dev/hda2 vga=0x318 badram=0x0009269c,0xfffffffc video=vesa:mtrr,ypan:1280x1024-32@87 vga=0x318
ide_setup: hda=autotune
ide_setup: hdc=autotune
ide_setup: hdd=autotune
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1200.617 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 254424k/262080k available (2784k kernel code, 6936k reserved, 849k data, 356k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2359.29 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1199.0863 MHz.
..... host bus clock speed is 199.0977 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xe4000000, mapped to 0xd0806000, size 16384k
vesafb: mode is 1024x768x32, linelength=4096, pages=0
vesafb: protected mode interface info at c000:0393
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
Applying VIA southbridge workaround.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
ipmi: message handler initialized
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD DESKJET 600
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 5T040H4, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
hdd: CD-ROM 48X/AKU, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 66055248 sectors (33820 MB)
        native  capacity is 80043264 sectors (40982 MB)
hda: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
ide-floppy driver 0.99.newide
Console: switching to colour frame buffer device 128x48
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 5, io base 0000d400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: irq 5, io base 0000d800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xdc00, irq 12
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
found reiserfs format "3.6" with standard journal
hub 1-0:1.0: new USB device on port 2, assigned address 2
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:07.2-2
Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 356k freed
Adding 250164k swap on /dev/hda3.  Priority:-1 extents:1
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda6) for (hda6)
Using r5 hash to sort names
blk: queue c1378a00, I/O limit 4095Mb (mask 0xffffffff)
hdc: lost interrupt
hdc: CHECK for good STATUS
hdd: CHECK for good STATUS
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-5328  Wed Dec 17 13:54:51 PST 2003
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

PS: this is my first kernel bugreport, if there are rules i broke(or lack of info), please excuse me

--

"Computers are just a medium of expression."

 - Paul Graham (www.paulgraham.com)
