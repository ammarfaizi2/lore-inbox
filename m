Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVGULOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVGULOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVGULOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:14:46 -0400
Received: from outmx011.isp.belgacom.be ([195.238.3.3]:11492 "EHLO
	outmx011.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261753AbVGULOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:14:45 -0400
Date: Wed, 20 Jul 2005 22:51:50 +0200
From: Peter De Wachter <pdewacht@vub.ac.be>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: PS/2 mouse trouble
Message-ID: <20050720205150.GA5654@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble with my new mouse and Linux 2.6. The most recent
kernel I tried was 2.6.13rc3. It's a plain optical, three buttons,
scroll wheel PS/2 mouse, model name "Trust Ami Mouse 250S", and it works
fine on 2.4 and Windows. I don't use a KVM switch.

The symptoms: When the psmouse module loads, the mouse's red sensor
light turns off. Reading from /dev/input/mice doesn't give data when you
wiggle it, only when you click a button or scroll the wheel. If you
reboot the computer at this point, the optical sensor stays disabled and
the mouse won't be detected anymore (not matter the OS). The proto=bare
option doesn't help.

I experimented a bit, and I could get it working by commenting out the
lines in drivers/input/mouse/psmouse-base.c where the
PSMOUSE_CMD_RESET_DIS command was sent (twice in psmouse_extensions, and
a third time in psmouse_probe). So it seems my mouse gets confused by
this command, but other mice probably need them. Perhaps they can be
replaced by a PSMOUSE_CMD_RESET_BAT/PSMOUSE_CMD_DISABLE combo? (Not that
I know what I'm talking about...)

Thanks,
Peter De Wachter


>From /proc/bus/input/devices (on a kernel with my fix):
I: Bus=0011 Vendor=0002 Product=0006 Version=0000
N: Name="ImExPS/2 Generic Explorer Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=event2 mouse0
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

dmesg output (again, on a kernel with my fix):
Linux version 2.6.13-rc3 (pdewacht@arrakis) (gcc versie 3.3.6 (Debian 1:3.3.6-7)) #2 Tue Jul 19 14:36:12 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa340
ACPI: RSDT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0000
ACPI: FADT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0030
ACPI: DSDT (v001    SiS      735 0x00000100 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro 
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1145.316 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511340k/524224k available (1644k kernel code, 12236k reserved, 757k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2291.86 BogoMIPS (lpj=4583729)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1c3f9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c38)
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 4508k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Uncovering SIS18 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: cee00000-cfefffff
  PREFETCH window: cac00000-cecfffff
inotify syscall
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 PS2M PS2K USB1 USB2  LAN  MDM  AUD SLPB 
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4508KiB [1 disk] into ram disk...
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 168k freed
unix: disagrees about version of symbol sock_register
unix: Unknown symbol sock_register
unix: disagrees about version of symbol sock_wake_async
unix: Unknown symbol sock_wake_async
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST320423A, ATA DISK drive
hdb: ST340824A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LG DVD-ROM DRD-8080B, ATAPI CD/DVD-ROM drive
hdd: TRAXDATA CDRW161040plus, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40011300 sectors (20485 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
NET: Registered protocol family 1
Adding 128476k swap on /dev/hdb1.  Priority:-1 extents:1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
input: PC Speaker
hdc: ATAPI 27X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
loop: loaded (max 8 devices)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[D] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
ohci_hcd 0000:00:02.2: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.2: irq 3, io mem 0xcfffe000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.3[A] -> Link [LNKH] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:02.3: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.3: irq 5, io mem 0xcffff000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usb 1-1: new full speed USB device using ohci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb 2-1: new full speed USB device using ohci_hcd and address 2
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected SiS 735 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
/home/pdewacht/wireless/at76c503a/at76_usbdfu.c: USB Device Firmware Upgrade (DFU) handler v0.12beta23-static loading
/home/pdewacht/wireless/at76c503a/at76c503.c: Generic Atmel at76c503/at76c505 routines v0.12beta23-static
/home/pdewacht/wireless/at76c503a/at76c503-fw_skel.c: Atmel at76c503 (RFMD) Wireless LAN Driver v0.12beta23-static loading
/home/pdewacht/wireless/at76c503a/at76c503-fw_skel.c: using compiled-in firmware
usbcore: registered new driver at76c503-rfmd
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sis630_smbus 0000:00:02.0: SIS630 comp. bus not detected, module not inserted.
usb 2-1: reset full speed USB device using ohci_hcd and address 2
usb 2-1: device firmware changed
usb 2-1: USB disconnect, address 2
/home/pdewacht/wireless/at76c503a/at76c503-fw_skel.c: wlan%d disconnecting
/home/pdewacht/wireless/at76c503a/at76c503-fw_skel.c: at76c503-rfmd disconnected
usb 2-1: new full speed USB device using ohci_hcd and address 3
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
/home/pdewacht/wireless/at76c503a/at76c503-fw_skel.c: using compiled-in firmware
/home/pdewacht/wireless/at76c503a/at76c503.c: $Id: at76c503.c,v 1.74 2005/03/08 01:33:14 jal2 Exp $ compiled Jul 19 2005 13:23:43
/home/pdewacht/wireless/at76c503a/at76c503.c: firmware version 1.101.2 #84 (fcs_len 4)
/home/pdewacht/wireless/at76c503a/at76c503.c: device's MAC 00:90:96:50:93:e4, regulatory domain MKK1 (Japan) (id 65)
/home/pdewacht/wireless/at76c503a/at76c503.c: registered wlan0
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
intel8x0_measure_ac97_clock: measured 44686 usecs
intel8x0: clocking to 48000
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
eth0: RealTek RTL8139 at 0xd400, 00:50:fc:ac:59:bb, IRQ 4
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Real Time Clock Driver v1.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
psmouse.c: Activating mouse
NET: Registered protocol family 10
Disabled Privacy Extensions on device c032b980(lo)
IPv6 over IPv4 tunneling driver
wlan0: no IPv6 routers present
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G400 AGP
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
mice: PS/2 mouse device common for all mice
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
