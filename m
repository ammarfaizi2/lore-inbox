Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTG3KXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbTG3KXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:23:03 -0400
Received: from main.gmane.org ([80.91.224.249]:7399 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270009AbTG3KWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:22:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: DMA timeouts on SIS IDE
Date: Wed, 30 Jul 2003 12:19:06 +0200
Message-ID: <yw1xn0ewnwpx.fsf@users.sourceforge.net>
References: <yw1xr849pbj6.fsf@users.sourceforge.net> <20030730114338.A1556@bouton.inet6-interne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:T+jrJhZgROV3Vy/ZMk9q/ovlG08=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton <Lionel.Bouton@inet6.fr> writes:

>> I'm running Linux 2.6.0-test2 with Ingo's G7 and the SOFT_RR patches
>> on an Asus laptop with a SIS IDE controller.  When writing large
>> amounts of data to the disk, I get these messages in the kernel log
>> after a while:
>> 
>> hda: dma_timer_expiry: dma status == 0x21
>> hda: DMA timeout error
>> hda: dma timeout error: status=0xd0 { Busy }
>> 
>> hda: DMA disabled
>> ide0: reset: success
>
> Could you post the output of "lspci -vxxx -s2.5", "dmesg" and finally
> "hdparm -i" for each drive please ?

Here you go:

# lspci -vxxx -s2.5
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 1688
        Flags: bus master, fast devsel, latency 128
        I/O ports at b800 [size=16]
00: 39 10 13 55 07 00 00 00 d0 80 01 01 00 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 43 10 88 16
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 31 81 00 00 31 85 00 00 08 01 e6 51 00 02 00 02
50: 01 00 01 06 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# hdparm -i /dev/hda

/dev/hda:

 Model=IC25N040ATMR04-0, FwRev=MO2OAD0A, SerialNo=MRG201K2C1L38C
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1740kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  2 3 4 5 6

# dmesg
Linux version 2.6.0-test2 (mru@ford) (gcc version 3.3) #1 Mon Jul 28 12:26:02 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dffa000 (usable)
 BIOS-e820: 000000000dffa000 - 000000000dfff000 (ACPI data)
 BIOS-e820: 000000000dfff000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
223MB LOWMEM available.
On node 0 totalpages: 57338
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53242 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6460
ACPI: RSDT (v001 ASUS   M2000E   16944.11825) @ 0x0dffa000
ACPI: FADT (v001 ASUS   M2000E   16944.11825) @ 0x0dffa080
ACPI: BOOT (v001 ASUS   M2000E   16944.11825) @ 0x0dffa040
ACPI: DSDT (v001   ASUS M2000E   00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-test ro root=301 init=/sbin/lvm2/lvmroot video=sisfb:mode:1024x768x8
sisfb: Options mode:1024x768x8
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2070.423 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4087.80 BogoMIPS
Memory: 223748k/229352k available (1637k kernel code, 4908k reserved, 700k data, 112k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf17c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................
Table [DSDT](id F004) - 585 Objects with 52 Devices 200 Methods 21 Regions
ACPI Namespace successfully loaded at root c037521c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:..............................................  psargs-0352: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
search_node cdf72828 start_node cdf72828 return_node 00000000
 psparse-1121: *** Error: , AE_NOT_FOUND

  nsinit-0293 [06] ns_init_one_object    : Could not execute arguments for [_PSL] (Package), AE_NOT_FOUND
....................
Initialized 21/21 Regions 5/5 Fields 19/19 Buffers 21/21 Packages (593 nodes)
Executing all Device _STA and_INI methods:.....................................................
53 Devices found containing: 53 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (off)
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
sisfb: Video ROM found and mapped to c00c0000
sisfb: Framebuffer at 0xf0000000, mapped to 0xce80f000, size 32768k
sisfb: MMIO at 0xe7800000, mapped to 0xd0810000, size 128k
sisfb: Memory heap starting at 12288K
sisfb: Using MMIO queue mode
sisfb: LVDS transmitter detected
sisfb: Default mode is 1024x768x8 (60Hz)
sisfb: Added MTRRs
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: 2D acceleration is enabled, scrolling mode ypan
fb0: SIS 650/M650/651/740 VGA frame buffer device, Version 1.6.01
sisfb: Change mode to 1024x768x8-60Hz
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Enabling SEP on CPU 0
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU] (supports C1 C2, 4 throttling states)
ACPI: Thermal Zone [THRM] (44 C)
Asus Laptop ACPI Extras version 0.24a
  M2E model detected, supported
  Notify Handler installed successfully
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS SCB-2408, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1740KiB Cache, CHS=4864/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Console: switching to colour frame buffer device 128x48
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Unable to find swap-space signature
Adding 524280k swap on /dev/vg0/swap.  Priority:1 extents:1
EXT3 FS on dm-3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.11
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 11, 00:0c:6e:40:b0:22.
eth0: Media Link On 100mbps full-duplex 
ohci1394: $Rev: 1011 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[e5800000-e58007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800030a8605]
intel8x0: clocking to 48000
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:02.2: Silicon Integrated S 7001
ohci-hcd 0000:00:02.2: irq 11, pci mem d0906000
ohci-hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 3 ports detected
ohci-hcd 0000:00:02.3: Silicon Integrated S 7001 (#2)
ohci-hcd 0000:00:02.3: irq 11, pci mem d0908000
ohci-hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0xe8000000
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.2-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
SCSI subsystem initialized
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
spurious 8259A interrupt: IRQ7.
eth0: Media Link Off
eth0: Media Link On 100mbps full-duplex 
eth0: Media Link Off
eth0: Media Link On 100mbps full-duplex 
nfs warning: mount version older than kernel


-- 
Måns Rullgård
mru@users.sf.net

