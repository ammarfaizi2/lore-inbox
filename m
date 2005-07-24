Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVGXNWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVGXNWD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 09:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGXNWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 09:22:02 -0400
Received: from [85.8.12.41] ([85.8.12.41]:55430 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261948AbVGXNWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 09:22:00 -0400
Message-ID: <42E395F6.8070301@drzeus.cx>
Date: Sun, 24 Jul 2005 15:21:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-1842-1122211318-0001-2"
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg Kroah-Hartman <greg@kroah.com>
Subject: IRQ routing problem in 2.6.10-rc2
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-1842-1122211318-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Sorry about reporting this error so late but the machine in question had
gone some time without upgrades.

The problem I'm seeing is that IRQs stop working for one of the IRQ
slots on the machine. It's only that slot, not the entire IRQ, since the
two slots (it's a small machine) both get routed to IRQ 10.

I've included dmesg from 2.6.10-rc1 (which works) and 2.6.10-rc2 (which
doesn't).

I've also tried reverting the patches that modifies
arch/i386/kernel/irq.c and arch/i386/pci/irq.c but it didn't solve the
problem. So now I need some more input on which patches to try.

Rgds
Pierre

--=_hermes.drzeus.cx-1842-1122211318-0001-2
Content-Type: text/plain; name="dmesg-2.6.10-rc1"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.10-rc1"

Linux version 2.6.10-rc1 (root@natasha.craffe.se) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #3 Sun Jul 17 03:03:28 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffe000 (usable)
 BIOS-e820: 000000000fffe000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65534
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61438 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf50
ACPI: RSDT (v001 DELL    GX1     0x00000002 ASL  0x00000061) @ 0x000fdf64
ACPI: FADT (v001 DELL    GX1     0x00000002 ASL  0x00000061) @ 0x000fdf8c
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 rhgb acpi=force
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 598.602 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255268k/262136k available (2408k kernel code, 6204k reserved, 620k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1187.84 BogoMIPS (lpj=593920)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 202k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcaee, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1121904612.812:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: 1 Plug & Play card detected total
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf4000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST36811A, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA CD-ROM XM-1902B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/512KiB Cache, CHS=13328/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI0 USB0 PCI1 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 160k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: Power Button (FF) [PWRF]
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 0xdce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
EXT3 FS on hda3, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
cdrom: open failed.
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 already at revision 0xe (current=0xe)
microcode: No suitable data for CPU0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 324 bytes per conntrack
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
divert: allocating divert_blk for eth0
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd880. Vers LK1.1.19
divert: allocating divert_blk for eth1
NET: Registered protocol family 8
NET: Registered protocol family 20
Bridge firewalling registered
divert: allocating divert_blk for pan0
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03bed80(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.4
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
eth0: no IPv6 routers present
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
pan0: no IPv6 routers present

--=_hermes.drzeus.cx-1842-1122211318-0001-2
Content-Type: text/plain; name="dmesg-2.6.10-rc2"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.10-rc2"

Linux version 2.6.10-rc2 (root@natasha.craffe.se) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #8 Wed Jul 20 02:57:15 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffe000 (usable)
 BIOS-e820: 000000000fffe000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65534
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61438 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf50
ACPI: RSDT (v001 DELL    GX1     0x00000002 ASL  0x00000061) @ 0x000fdf64
ACPI: FADT (v001 DELL    GX1     0x00000002 ASL  0x00000061) @ 0x000fdf8c
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 rhgb acpi=force
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 598.469 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255272k/262136k available (2389k kernel code, 6208k reserved, 623k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1187.84 BogoMIPS (lpj=593920)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 208k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcaee, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1121904806.853:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236B'
isapnp: 1 Plug & Play card detected total
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf4000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST36811A, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA CD-ROM XM-1902B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/512KiB Cache, CHS=13328/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI0 USB0 PCI1 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 176k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 0xdce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
EXT3 FS on hda3, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
cdrom: open failed.
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 already at revision 0xe (current=0xe)
microcode: No suitable data for CPU0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 324 bytes per conntrack
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
divert: allocating divert_blk for eth0
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 11 (level, low) -> IRQ 11
0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd880. Vers LK1.1.19
divert: allocating divert_blk for eth1
NET: Registered protocol family 8
NET: Registered protocol family 20
Bridge firewalling registered
divert: allocating divert_blk for pan0
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03ba220(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.5
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
eth0: no IPv6 routers present
pan0: no IPv6 routers present
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 16(0) current 16(0)
  Transmit list 00000000 vs. cc419200.
  0: @cc419200  length 8000002a status 0001002a
  1: @cc4192a0  length 8000002a status 0001002a
  2: @cc419340  length 8000002a status 0001002a
  3: @cc4193e0  length 8000005a status 0001005a
  4: @cc419480  length 8000002a status 0001002a
  5: @cc419520  length 8000004e status 0001004e
  6: @cc4195c0  length 80000046 status 00010046
  7: @cc419660  length 80000046 status 00010046
  8: @cc419700  length 8000002a status 0001002a
  9: @cc4197a0  length 8000002a status 0001002a
  10: @cc419840  length 80000046 status 00010046
  11: @cc4198e0  length 8000002a status 0001002a
  12: @cc419980  length 8000002a status 0001002a
  13: @cc419a20  length 8000002a status 0001002a
  14: @cc419ac0  length 8000002a status 8001002a
  15: @cc419b60  length 8000002a status 8001002a
eth0: Resetting the Tx ring pointer.

--=_hermes.drzeus.cx-1842-1122211318-0001-2--
