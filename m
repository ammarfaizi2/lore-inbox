Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUIMVQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUIMVQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268964AbUIMVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:16:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:53237 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268950AbUIMVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:15:44 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.9-rc2 : oops
Date: Mon, 13 Sep 2004 23:15:36 +0200
User-Agent: KMail/1.7
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <200409132203.08286.linux-kernel@borntraeger.net> <Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_43gRBgZ7vl4dyxG"
Message-Id: <200409132315.36577.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_43gRBgZ7vl4dyxG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Linus Torvalds wrote:
> On Mon, 13 Sep 2004, Christian Borntraeger wrote:
> > I got an oops with 2.6.9-rc2 in free_block.
> Looks like somebody is trying to free an invalid address. Sadly, your
> traceback doesn't show _who_, because it's hidden in the buffering.
>
> The only changes to slab itself have been by Christoph lately, I don't
> think that matters. Can you enable slab debugging? That should catch it
> much earlier..

Got it. I can reproduce the problem by mounting one of my recently burned 
backup cds. 

reversing "[PATCH] Fix leaks in ISOFS."
http://linux.bkbits.net:8080/linux-2.6/cset%40413792bdlE_TiqzIHELio3xcG68QeQ
helps. Seems we need a fix for the fix. 

thanks for your help

Christian


slab error in cache_free_debugcheck(): cache `size-256': double free, or 
memory outside object was overwritten
 [<c0105e87>] dump_stack+0x17/0x20
 [<c013ef57>] cache_free_debugcheck+0x197/0x210
 [<c013fada>] kfree+0x4a/0x90
 [<f3be297f>] parse_rock_ridge_inode_internal+0x1af/0x610 [isofs]
 [<f3be2f88>] parse_rock_ridge_inode+0x18/0x50 [isofs]
 [<f3be1a9e>] isofs_read_inode+0x24e/0x3f0 [isofs]
 [<f3be1cf9>] isofs_iget+0x59/0x70 [isofs]
 [<f3be0f68>] isofs_fill_super+0x398/0x620 [isofs]
 [<c01595fa>] get_sb_bdev+0xea/0x120
 [<f3be1d2c>] isofs_get_sb+0x1c/0x30 [isofs]
 [<c015982e>] do_kern_mount+0x8e/0x150
 [<c016ea34>] do_new_mount+0x64/0xa0
 [<c016f123>] do_mount+0x163/0x1a0
 [<c016f4c8>] sys_mount+0x88/0xf0
 [<c010504f>] syscall_call+0x7/0xb
....
there is more, see attachement 


Christian

--Boundary-00=_43gRBgZ7vl4dyxG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.9-rc2 (root@cubus) (gcc-Version 3.3.4 (Debian 1:3.3.4-11)=
) #2 Mon Sep 13 22:43:26 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196588
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192492 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6a70
ACPI: RSDT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x2ffec000
ACPI: FADT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x2ffec080
ACPI: BOOT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x2ffec040
ACPI: DSDT (v001   ASUS A7V-133  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: BOOT_IMAGE=3DLinux269rc2 root=3D901 video=3Drivafb:102=
4x768@85
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1311.697 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 774488k/786352k available (2607k kernel code, 11316k reserved, 1113=
k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2596.86 BogoMIPS (lpj=3D1298432)
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................=
=2E...................................................................
Table [DSDT](id F004) - 356 Objects with 38 Devices 115 Methods 24 Regions
ACPI Namespace successfully loaded at root c050773c
ACPI: IRQ9 SCI: Level Trigger.
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successf=
ul
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs at 00=
0000000000E420 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 4 Wake, Enabled 0 Runtime =
GPEs in this block
Completing Region/Field/Buffer/Package initialization:.....................=
=2E.................................
Initialized 23/24 Regions 2/2 Fields 19/19 Buffers 11/14 Packages (365 node=
s)
Executing all Device _STA and_INI methods:.................................=
=2E.......
41 Devices found containing: 41 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc4f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc520, dseg 0xf0000
pnp: 00:12: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:12: ioport range 0xe800-0xe83f could not be reserved
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:04.2[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:04.3[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
spurious 8259A interrupt: IRQ7.
irda_init()
NET: Registered protocol family 23
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
rivafb: nVidia device/chipset 10DE0110
rivafb: nVidia Corporation NV11 [GeForce2 MX/MX 400]
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: Found EDID Block from BUS 1
rivafb: setting virtual Y resolution to 32768
rivafb: setting virtual Y resolution to 32768
rivafb: Detected CRTC controller 0 being used
rivafb: Detected CRTC controller 0 being used
Console: switching to colour frame buffer device 128x48
rivafb: PCI nVidia NV11 framebuffer ver 0.9.5b (32MB @ 0xC8000000)
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
vesafb: probe of vesafb0 failed with error -6
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0 soft_margin=3D60=
 sec (nowayout=3D 0)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 256M @ 0xd0000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 6=
0 seconds).
irda_register_dongle : registering dongle "MA600" (11).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
hdd: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD1200BB-00CAA1, ATA DISK drive
ide2 at 0x9800-0x9807,0x9402 on irq 10
Probing IDE interface ide3...
Probing IDE interface ide3...
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19457/255/63, UDM=
A(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hde: max request size: 128KiB
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA=
(100)
hde: cache flushes not supported
 hde: hde1 hde2
hdc: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3648.000 MB/sec
raid5: using function: pIII_sse (3648.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53=
 2004 UTC).
PCI: Enabling device 0000:00:0a.0 (0004 -> 0005)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
ALSA device list:
  #0: Ensoniq AudioPCI ENS1370 at 0xa000, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 15
IrCOMM protocol (Dag Brattli)
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices:=20
PWRB PCI0 UAR1 UAR2 USB0 USB1=20
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hde2 ...
md:  adding hde2 ...
md: hde1 has different UUID to hde2
md:  adding hda3 ...
md: hda2 has different UUID to hde2
md: created md1
md: bind<hda3>
md: bind<hde2>
md: running: <hde2><hda3>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hde2
raid0:   comparing hde2(107454720) with hde2(107454720)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 1 zones
raid0: looking at hda3
raid0:   comparing hda3(107426560) with hde2(107454720)
raid0:   NOT EQUAL
raid0:   comparing hda3(107426560) with hda3(107426560)
raid0:   END
raid0:   =3D=3D> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking hda3 ... nope.
raid0: checking hde2 ... contained as device 0
  (107454720) is smallest!.
raid0: zone->nb_dev: 1, size: 28160
raid0: current zone offset: 107454720
raid0: done.
raid0 : md_size is 214881280 blocks.
raid0 : conf->hash_spacing is 214853120 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: considering hde1 ...
md:  adding hde1 ...
md:  adding hda2 ...
md: created md0
md: bind<hda2>
md: bind<hde1>
md: running: <hde1><hda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 1=
8, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 192k freed
Adding 931728k swap on /dev/hda7.  Priority:-1 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:04.2[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller
uhci_hcd 0000:00:04.2: irq 9, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:04.3[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller (#2)
uhci_hcd 0000:00:04.3: irq 9, io base 0000d000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
usb 2-1: new low speed USB device using address 2
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical=AE] on =
usb-0000:00:04.3-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
PCI: Enabling device 0000:00:09.0 (0014 -> 0017)
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, low) -> IRQ 9
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xa400. Vers LK1.1.19
NET: Registered protocol family 17
i2c /dev entries driver
loop: loaded (max 8 devices)
lp0: using parport0 (interrupt-driven).
cdrom: open failed.
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 1=
8, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
NTFS driver 2.1.17 [Flags: R/O MODULE].
NTFS volume version 3.1.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 332 bytes per conntrack
inserting floppy driver for 2.6.9-rc2
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
input: PC Speaker
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
rivafb: Detected CRTC controller 0 being used
rivafb: Detected CRTC controller 0 being used
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
slab error in cache_free_debugcheck(): cache `size-256': double free, or me=
mory outside object was overwritten
 [<c0105e87>] dump_stack+0x17/0x20
 [<c013ef57>] cache_free_debugcheck+0x197/0x210
 [<c013fada>] kfree+0x4a/0x90
 [<f3be297f>] parse_rock_ridge_inode_internal+0x1af/0x610 [isofs]
 [<f3be2f88>] parse_rock_ridge_inode+0x18/0x50 [isofs]
 [<f3be1a9e>] isofs_read_inode+0x24e/0x3f0 [isofs]
 [<f3be1cf9>] isofs_iget+0x59/0x70 [isofs]
 [<f3be0f68>] isofs_fill_super+0x398/0x620 [isofs]
 [<c01595fa>] get_sb_bdev+0xea/0x120
 [<f3be1d2c>] isofs_get_sb+0x1c/0x30 [isofs]
 [<c015982e>] do_kern_mount+0x8e/0x150
 [<c016ea34>] do_new_mount+0x64/0xa0
 [<c016f123>] do_mount+0x163/0x1a0
 [<c016f4c8>] sys_mount+0x88/0xf0
 [<c010504f>] syscall_call+0x7/0xb
d2feb144: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 3c 37 3e 53 65 70 20 31 33 20 32 32 3a 35 30 3a
010: 35 34 20 6b 65 72 6e 65 6c 3a 20 49 53 4f 20 39
020: 36 36 30 20 45 78 74 65 6e 73 69 6f 6e 73 3a 20
030: 52 52 49 50 5f 31 39 39 31 41 00 5a 5a 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 3c 33 3e 53 65 70 20 31 33 20 32 32 3a 35 30 3a
010: 35 34 20 6b 65 72 6e 65 6c 3a 20 50 72 65 76 20
020: 6f 62 6a 3a 20 73 74 61 72 74 3d 64 32 66 65 62
030: 30 33 63 2c 20 6c 65 6e 3d 32 35 36 00 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 3c 33 3e 53 65 70 20 31 33 20 32 32 3a 35 30 3a
010: 35 34 20 6b 65 72 6e 65 6c 3a 20 52 65 64 7a 6f
020: 6e 65 3a 20 30 78 31 37 30 66 63 32 61 35 2f 30
030: 78 31 37 30 66 63 32 61 35 2e 00 5a 5a 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 3c 33 3e 53 65 70 20 31 33 20 32 32 3a 35 30 3a
010: 35 34 20 6b 65 72 6e 65 6c 3a 20 50 72 65 76 20
020: 6f 62 6a 3a 20 73 74 61 72 74 3d 64 32 66 65 62
030: 30 33 63 2c 20 6c 65 6e 3d 32 35 36 00 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 3c 33 3e 53 65 70 20 31 33 20 32 32 3a 35 30 3a
010: 35 34 20 6b 65 72 6e 65 6c 3a 20 52 65 64 7a 6f
020: 6e 65 3a 20 30 78 31 37 30 66 63 32 61 35 2f 30
030: 78 31 37 30 66 63 32 61 35 2e 00 5a 5a 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=3Dd2feb148, len=3D256
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02e0659>](alloc_skb+0x39/0xd0)
000: 3c 33 3e 53 65 70 20 31 33 20 32 32 3a 35 30 3a
010: 35 34 20 6b 65 72 6e 65 6c 3a 20 52 65 64 7a 6f
020: 6e 65 3a 20 30 78 31 37 30 66 63 32 61 35 2f 30
030: 78 31 37 30 66 63 32 61 35 2e 00 5a 5a 5a 5a 5a
040: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Prev obj: start=3Dd2feb03c, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=3Dd2feb254, len=3D256
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02e07fb>](kfree_skbmem+0xb/0x20)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
slab error in cache_alloc_debugcheck_after(): cache `size-256': double free=
, or memory outside object was overwritten
 [<c0105e87>] dump_stack+0x17/0x20
 [<c013f3bc>] cache_alloc_debugcheck_after+0x8c/0x130
 [<c013f97f>] <1>Unable to handle kernel paging request at virtual address =
5a5a5a5a
 printing eip:
c02e0785
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
Modules linked in: isofs usb_storage scsi_mod pcspkr floppy 8250_pnp ipt_st=
ate ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter ip_tables vfat f=
at nls_iso8859_15 ntfs lp loop w83781d i2c_viapro i2c_dev i2c_sensor af_pac=
ket nls_cp437 nls_iso8859_1 3c59x joydev parport_pc evdev parport usbhid 82=
50 serial_core uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c02e0785>]    Not tainted VLI
EFLAGS: 00010297   (2.6.9-rc2)=20
EIP is at skb_release_data+0x35/0xa0
eax: d2feb188   ebx: 00000000   ecx: d2feb188   edx: 5a5a5a5a
esi: e4839b68   edi: ee89dd7c   ebp: ee89dd30   esp: ee89dd28
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 3016, threadinfo=3Dee89c000 task=3Dee833020)
Stack: e4839b68 e4839b68 ee89dd3c c02e07fb 00000000 ee89dd5c c02e0890 ee89d=
ea0=20
       00000000 e4839b68 ee89df2c e4839b68 ee89df2c ee89dda8 c033361a 00000=
000=20
       00000000 eee30340 ee89ddb8 eed94584 0000003b 00000bcc 00000000 00000=
000=20
Call Trace:
 [<c0105e5a>] show_stack+0x7a/0x90
 [<c0105fdd>] show_registers+0x14d/0x1b0
 [<c01061c4>] die+0xe4/0x170
 [<c0116635>] do_page_fault+0x225/0x5ac
 [<c0105a59>] error_code+0x2d/0x38
 [<c02e07fb>] kfree_skbmem+0xb/0x20
 [<c02e0890>] __kfree_skb+0x80/0x100
 [<c033361a>] unix_dgram_recvmsg+0x12a/0x1d0
 [<c02dce2d>] sock_recvmsg+0xbd/0xe0
 [<c02de275>] sys_recvfrom+0x85/0xe0
 [<c02de306>] sys_recv+0x36/0x40
 [<c02de932>] sys_socketcall+0x142/0x230
 [<c010504f>] syscall_call+0x7/0xb
Code: 00 74 0f 8b 80 a0 00 00 00 ff 08 0f 94 c2 84 d2 74 75 8b 8e a0 00 00 =
00 8b 51 04 89 c8 85 d2 74 35 31 db 39 d3 73 2f 8b 54 d8 10 <8b> 02 f6 c4 0=
8 75 17 8b 42 04 40 74 45 83 42 04 ff 0f 98 c0 84=20
 __kmalloc+0x8f/0xc0
 [<c02e0659>] alloc_skb+0x39/0xd0
 [<c02df991>] sock_alloc_send_pskb+0xb1/0x1c0
 [<c02dfaba>] sock_alloc_send_skb+0x1a/0x20
 [<c0333266>] unix_stream_sendmsg+0x156/0x370
 [<c02dd081>] sock_aio_write+0xe1/0x100
 [<c0152bb1>] do_sync_write+0x91/0xd0
 [<c0152cda>] vfs_write+0xea/0x120
 [<c0152dc1>] sys_write+0x41/0x70
 [<c010504f>] syscall_call+0x7/0xb
d2feb144: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.

--Boundary-00=_43gRBgZ7vl4dyxG--
