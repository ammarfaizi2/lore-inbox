Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUBOTj1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUBOTj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:39:27 -0500
Received: from rrcs-midsouth-24-172-39-10.biz.rr.com ([24.172.39.10]:33990
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id S265177AbUBOTjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:39:03 -0500
From: Mark Rutherford <mark@justirc.net>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.6.3-rc3 IO-APIC badness (IRQ xx: nobody cared!)
Date: Sun, 15 Feb 2004 14:41:53 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402151441.53286.mark@justirc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, 
motherboard is a Gigabyte GA-7NNXP, nforce2 chipset.
system ran ok, but with shared interrupts with just APIC selected, and without 
APIC selected.
decided to get bold and daring and compiled with IO-APIC to get rid of the 
many problems im having with IRQ sharing (stuff isnt working properly due to 
it, they dont want to share...)
but...due to the IRQ's being disabled I lose usb, ect.
otherwise the system seemed to function properly.

here is the output of /proc/interrupts:
           CPU0       
  0:     297097    IO-APIC-edge  timer
  1:        838    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0          XT-PIC  ehci_hcd
 10:          0          XT-PIC  ohci_hcd
 11:          0          XT-PIC  ohci_hcd, NVidia nForce2
 14:        865    IO-APIC-edge  ide0
 15:         36    IO-APIC-edge  ide1
 16:     162945   IO-APIC-level  eth0
 17:     118375   IO-APIC-level  bttv0, Bt87x audio
 19:     162963   IO-APIC-level  EMU10K1
NMI:          0 
LOC:     297017 
ERR:          0
MIS:          0

and..here is the dmesg output:

Linux version 2.6.3-rc3 (root@DarkStar) (gcc version 3.3.2 20040119 (Gentoo 
Linux 3.3.2-r7, propolice-3.3-7)) #5 Sun Feb 15 13:34:29 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5330
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:10 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/hda1 psmouse.proto=imps
Unknown boot option `psmouse.proto=imps': ignoring
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2079.902 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1033036k/1048512k available (2750k kernel code, 14568k reserved, 1023k 
data, 148k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4112.38 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-18, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 19.
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
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2079.0248 MHz.
..... host bus clock speed is 332.0679 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaf10, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
PCI->APIC IRQ transform: (B1,I7,P0) -> 19
PCI->APIC IRQ transform: (B1,I9,P0) -> 17
PCI->APIC IRQ transform: (B1,I9,P0) -> 17
PCI->APIC IRQ transform: (B1,I11,P0) -> 16
PCI->APIC IRQ transform: (B1,I12,P0) -> 17
PCI->APIC IRQ transform: (B3,I0,P0) -> 19
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver 2.1.6 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xb0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
Copyright (c) 1999-2004 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.23.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:04.0
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:01:09.0, irq: 17, latency: 32, mmio: 0xd0000000
bttv0: detected: AVerMedia TVPhone98 [card=41], PCI subsystem ID is 1461:0003
bttv0: using: AVerMedia TVPhone 98 [card=41,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=0066f7c3 [init]
bttv0: Avermedia eeprom[0x4803]: tuner=2 radio:yes remote control:yes
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: add subdevice "remote0"
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
ir-kbd-gpio: bttv IR (card=41) detected at pci-0000:01:09.0/ir0
tuner: chip found @ 0xc2
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
irq 17: nobody cared!
Call Trace:
 [<c010b2aa>] __report_bad_irq+0x2a/0x90
 [<c010b3a0>] note_interrupt+0x70/0xb0
 [<c010b680>] do_IRQ+0x120/0x130
 [<c0109938>] common_interrupt+0x18/0x20
 [<c0114364>] delay_tsc+0x14/0x20
 [<c021cfb2>] __delay+0x12/0x20
 [<c029bc4d>] ide_delay_50ms+0x1d/0x30
 [<c02a09b7>] actual_try_to_identify+0x27/0x5a0
 [<c010b9b6>] probe_irq_on+0x126/0x1c0
 [<c02a0fa6>] try_to_identify+0x76/0x130
 [<c02a1151>] do_probe+0xf1/0x260
 [<c02a1789>] probe_hwif+0x319/0x440
 [<c02a608a>] do_ide_setup_pci_device+0x9a/0x170
 [<c02a18cc>] probe_hwif_init+0x1c/0x70
 [<c02a61b8>] ide_setup_pci_device+0x58/0x90
 [<c029988f>] amd74xx_probe+0x6f/0x80
 [<c04c679d>] ide_scan_pcidev+0x5d/0x70
 [<c04c67f7>] ide_scan_pcibus+0x47/0xd0
 [<c04c66d0>] probe_for_hwifs+0x10/0x20
 [<c04c6725>] ide_init+0x45/0x60
 [<c04b27ab>] do_initcalls+0x2b/0xa0
 [<c012c53f>] init_workqueues+0xf/0x30
 [<c01050d2>] init+0x32/0x140
 [<c01050a0>] init+0x0/0x140
 [<c0106f25>] kernel_thread_helper+0x5/0x10

handlers:
[<c0285db0>] (bttv_irq+0x0/0x350)
Disabling IRQ #17
hda: Maxtor 52049U4, ATA DISK drive
hdb: WDC WD136AA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOpen Inc. DVD-ROM DVD-1040 PRO 0114, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48125W, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40020624 sectors (20490 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
hdb: max request size: 128KiB
hdb: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=26354/16/63, UDMA(66)
 /dev/ide/host0/bus0/target1/lun0: p1
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 12X CD-ROM CD-R/RW CD-MRW drive, 1984kB Cache, UDMA(33)
libata version 1.00 loaded.
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 9, pci mem f8893000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 10, pci mem f8895000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem f8897000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49 
2004 UTC).
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49413 usecs
intel8x0: clocking to 47436
ALSA device list:
  #0: Brooktree Bt878 at 0xd0001000, irq 17
  #1: NVidia nForce2 at 0xd7087000, irq 11
  #2: Sound Blaster Live! (rev.8) at 0x8000, irq 19
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
usb 2-1: new full speed USB device using address 2
irq 19: nobody cared!
Call Trace:
 [<c010b2aa>] __report_bad_irq+0x2a/0x90
 [<c010b3a0>] note_interrupt+0x70/0xb0
 [<c010b680>] do_IRQ+0x120/0x130
 [<c0105000>] _stext+0x0/0x60
 [<c0109938>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x60
 [<c0106cd3>] default_idle+0x23/0x40
 [<c0106d64>] cpu_idle+0x34/0x40
 [<c04b2762>] start_kernel+0x152/0x160
 [<c04b24b0>] unknown_bootoption+0x0/0x120

handlers:
[<c033d3d0>] (snd_emu10k1_interrupt+0x0/0x420)
Disabling IRQ #19
Reiserfs journal params: device hda1, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Adding 473908k swap on /dev/hda2.  Priority:-1 extents:1
usb 2-1: control timeout on ep0out
ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Different ACPI or APIC settings 
may help.
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
irq 16: nobody cared!
Call Trace:
 [<c010b2aa>] __report_bad_irq+0x2a/0x90
 [<c010b3a0>] note_interrupt+0x70/0xb0
 [<c010b680>] do_IRQ+0x120/0x130
 [<c0105000>] _stext+0x0/0x60
 [<c0109938>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x60
 [<c0106cd3>] default_idle+0x23/0x40
 [<c0106d64>] cpu_idle+0x34/0x40
 [<c04b2762>] start_kernel+0x152/0x160
 [<c04b24b0>] unknown_bootoption+0x0/0x120

handlers:
[<c026ff70>] (e1000_intr+0x0/0xc0)
Disabling IRQ #16

