Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266980AbUAXSNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266983AbUAXSNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:13:38 -0500
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:62376 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266980AbUAXSM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:12:58 -0500
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Badness in interruptible_sleep_on at kernel/sched.c [2.6.2-rc1-mm2]
Date: Sat, 24 Jan 2004 13:12:56 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401241312.56874.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to Andrew's new debug patch I've got a couple of nice stack traces where 
sleep_on() is called without lock_kernel(). Please CC me with any replies as 
I'm not subscribed
 ---CLIP----
Linux version 2.6.2-rc1-mm2 (root@staticwave) (gcc version 3.3.2 20031218 
(Gento 
o Linux 3.3.2-r5, propolice-3.3-7)) #1 Sat Jan 24 12:58:36 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 SOYO                                      ) @ 0x000f6850
ACPI: RSDT (v001 SOYO   AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 SOYO   AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: DSDT (v001 SOYO   AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
current: c03dfa60
current->thread_info: c0432000
Initializing CPU#0
Kernel command line: root=/dev/hda3 vga=794 video=vesafb:ywrap,pmipal,mtrr 
parpo 
rt=0x378,7,3
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1406.944 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 1033388k/1048512k available (2604k kernel code, 14220k reserved, 665k 
da 
ta, 344k init, 131008k highmem)
Calibrating delay loop... 2768.89 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1406.0512 MHz.
..... host bus clock speed is 267.0907 MHz.
NET: Registered protocol family 16
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfb550, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031203
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off 
'
vesafb: framebuffer at 0xd8000000, mapped to 0xf8806000, size 16384k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:b5b0
vesafb: pmi: set display start = c00cb5f5, set palette = c00cb67a
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 
3d0 
 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=6553
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
highmem bounce pool size: 64 pages
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
SGI XFS with no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS4 at I/O 0xc400 (irq = 10) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA 
]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

parport0: cpp_mux: aa55f00f52ad51(3f)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (interrupt-driven).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe0010000, 00:50:2c:01:b5:56, IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L040J2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

hda: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3
cdrom: : unknown mrw mode page
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
cdrom: : unknown mrw mode page
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Console: switching to colour frame buffer device 160x64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 10, io base 0000d400
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 10, io base 0000d800
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: irq 10, io base 0000dc00
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.1 (Tue Dec 30 10:04:14 
2003 
 UTC).
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xcc00, irq 11
  #1: Ensoniq AudioPCI ENS1371 at 0xc800, irq 11
NET: Registered protocol family 2
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not 
su 
pported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 byte 
sector 
s)
UDF-fs: No VRS found
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 344k freed
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:11.2-1
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011c2c3>] interruptible_sleep_on+0x103/0x110
 [<c011be60>] default_wake_function+0x0/0x20
 [<c0217c9e>] pagebuf_daemon+0x23e/0x260
 [<c038ac92>] ret_from_fork+0x6/0x14
 [<c0217a30>] pagebuf_daemon_wakeup+0x0/0x30
 [<c0217a60>] pagebuf_daemon+0x0/0x260
 [<c01092a9>] kernel_thread_helper+0x5/0xc

eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
blk: queue c1b23a00, I/O limit 4095Mb (mask 0xffffffff)
hdd: DMA disabled
mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x1000000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
---CLIP---

-- 
Gabriel Devenyi
devenyga@mcmaster.ca

