Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946230AbWBDAub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946230AbWBDAub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946229AbWBDAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:50:31 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:47117 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1946230AbWBDAua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:50:30 -0500
Date: Sat, 4 Feb 2006 00:50:14 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: stern@rowland.harvard.edu, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Bad interaction between uhci_hcd and de2104x
Message-ID: <20060204005014.GA13351@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a machine on which the de2104x driver doesn't work when
uhci_hcd is loaded.  It used to work fine with 2.4 and the tulip
driver (and usb-uhci).  Basically, when I boot I get the following
traceback and then eth0 doesn't work.  When I unload de2104x and
uhci_hcd and load only de2104x again then Ethernet works.  Similarly,
when I completely blacklist the uhci_hcd module the de2104x driver
works without any problems.


eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
irq 10: nobody cared (try booting with the "irqpoll" option)
 [<c012f89e>] __report_bad_irq+0x31/0x73
 [<c012f96d>] note_interrupt+0x75/0x98
 [<c012f46a>] __do_IRQ+0x67/0x91
 [<c0104fc1>] do_IRQ+0x19/0x24
 [<c0103afa>] common_interrupt+0x1a/0x20
 [<c0119a1c>] __do_softirq+0x2c/0x7d
 [<c0119a8f>] do_softirq+0x22/0x26
 [<c0104fc6>] do_IRQ+0x1e/0x24
 [<c0103afa>] common_interrupt+0x1a/0x20
 [<c481da07>] de_set_rx_mode+0xf/0x12 [de2104x]
 [<c481e2c1>] de_init_hw+0x6d/0x76 [de2104x]
 [<c481e59e>] de_open+0x64/0xe4 [de2104x]
 [<c0225a5f>] dev_open+0x30/0x66
 [<c0226a9a>] dev_change_flags+0x4d/0xf0
 [<c025d301>] devinet_ioctl+0x224/0x4bd
 [<c0155541>] do_ioctl+0x21/0x50
 [<c0155774>] vfs_ioctl+0x152/0x161
 [<c01557cb>] sys_ioctl+0x48/0x65
 [<c0102a99>] syscall_call+0x7/0xb
handlers:
[<c4890d97>] (usb_hcd_irq+0x0/0x56 [usbcore])
Disabling IRQ #10

lspci information:

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 02) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at e400 [size=32]

0000:00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 11)
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at e800 [size=128]
	Memory at e8000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at e7000000 [disabled] [size=256K]

Attached are two boot logs:
 1. Booting, loading both drivers, unloading both, loading de2104x
    again.
 2. Booting with the uhci_hcd module being blacklisted.

-- 
Martin Michlmayr
http://www.cyrius.com/

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.15-dereg-hcd-reload-de"

Linux version 2.6.15-1-486 (Debian 2.6.15-3) (horms@verge.net.au) (gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #1 Wed Jan 18 14:56:12 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
 BIOS-e820: 0000000003ff0000 - 0000000003ff3000 (ACPI NVS)
 BIOS-e820: 0000000003ff3000 - 0000000004000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
63MB LOWMEM available.
On node 0 totalpages: 16368
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 12272 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.1 present.
ACPI: RSDP (v000 VIAVP3                                ) @ 0x000f7180
ACPI: RSDT (v001 VIAVP3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x03ff3000
ACPI: FADT (v001 VIAVP3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x03ff3040
ACPI: DSDT (v001 VIAVP3 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x5008
Allocating PCI resources starting at 10000000 (gap: 04000000:fbff0000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro 
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01081000)
Initializing CPU#0
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 400.955 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 57540k/65472k available (1516k kernel code, 7528k reserved, 574k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 802.36 BogoMIPS (lpj=401184)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 008021bf 808029bf 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 008021bf 808029bf 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After all inits, caps: 008021bf 808029bf 00000000 00000002 00000000 00000000 00000000
mtrr: v2.0 (20020519)
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e00)
checking if image is initramfs... it is
Freeing initrd memory: 4327k freed
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 5000-50ff claimed by vt82c586 ACPI
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: e4000000-e5ffffff
  PREFETCH window: e6000000-e6ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
audit: initializing netlink socket (disabled)
audit(1139015562.912:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 5
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
ACPI wakeup devices: 
USB0 USB1 
ACPI: (supports S0 S1 S5)
Freeing unused kernel memory: 228k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
de2104x PCI Ethernet driver v0.7 (Mar 17, 2004)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
hda: Maxtor 90871U2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
eth0: 21041 at 0xc4834000, 00:80:c8:33:4f:96, IRQ 10
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
PCI: Via IRQ fixup for 0000:00:07.2, from 11 to 10
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 10, io base 0x0000e400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 16992864 sectors (8700 MB) w/512KiB Cache, CHS=16858/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 >
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Real Time Clock Driver v1.12
input: PC Speaker as /class/input/input1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
mice: PS/2 mouse device common for all mice
Adding 305192k swap on /dev/hda5.  Priority:-1 extents:1 across:305192k
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
irq 10: nobody cared (try booting with the "irqpoll" option)
 [<c012f89e>] __report_bad_irq+0x31/0x73
 [<c012f96d>] note_interrupt+0x75/0x98
 [<c012f46a>] __do_IRQ+0x67/0x91
 [<c0104fc1>] do_IRQ+0x19/0x24
 [<c0103afa>] common_interrupt+0x1a/0x20
 [<c0119a1c>] __do_softirq+0x2c/0x7d
 [<c0119a8f>] do_softirq+0x22/0x26
 [<c0104fc6>] do_IRQ+0x1e/0x24
 [<c0103afa>] common_interrupt+0x1a/0x20
 [<c481da07>] de_set_rx_mode+0xf/0x12 [de2104x]
 [<c481e2c1>] de_init_hw+0x6d/0x76 [de2104x]
 [<c481e59e>] de_open+0x64/0xe4 [de2104x]
 [<c0225a5f>] dev_open+0x30/0x66
 [<c0226a9a>] dev_change_flags+0x4d/0xf0
 [<c025d301>] devinet_ioctl+0x224/0x4bd
 [<c0155541>] do_ioctl+0x21/0x50
 [<c0155774>] vfs_ioctl+0x152/0x161
 [<c01557cb>] sys_ioctl+0x48/0x65
 [<c0102a99>] syscall_call+0x7/0xb
handlers:
[<c4890d97>] (usb_hcd_irq+0x0/0x56 [usbcore])
Disabling IRQ #10
eth0: link up, media 10baseT auto
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
uhci_hcd 0000:00:07.2: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:07.2: USB bus 1 deregistered
ACPI: PCI interrupt for device 0000:00:07.2 disabled
eth0: disabling interface
ACPI: PCI interrupt for device 0000:00:0b.0 disabled
ACPI: PCI interrupt for device 0000:00:0b.0 disabled
de2104x PCI Ethernet driver v0.7 (Mar 17, 2004)
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
eth0: 21041 at 0xc4834000, 00:80:c8:33:4f:96, IRQ 10
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth0: link up, media 10baseT auto
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.15-no-hcd"

Linux version 2.6.15-1-486 (Debian 2.6.15-3) (horms@verge.net.au) (gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #1 Wed Jan 18 14:56:12 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
 BIOS-e820: 0000000003ff0000 - 0000000003ff3000 (ACPI NVS)
 BIOS-e820: 0000000003ff3000 - 0000000004000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
63MB LOWMEM available.
On node 0 totalpages: 16368
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 12272 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.1 present.
ACPI: RSDP (v000 VIAVP3                                ) @ 0x000f7180
ACPI: RSDT (v001 VIAVP3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x03ff3000
ACPI: FADT (v001 VIAVP3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x03ff3040
ACPI: DSDT (v001 VIAVP3 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x5008
Allocating PCI resources starting at 10000000 (gap: 04000000:fbff0000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro 
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01081000)
Initializing CPU#0
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 401.032 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59488k/65472k available (1516k kernel code, 5580k reserved, 574k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 802.33 BogoMIPS (lpj=401167)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 008021bf 808029bf 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 008021bf 808029bf 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After all inits, caps: 008021bf 808029bf 00000000 00000002 00000000 00000000 00000000
mtrr: v2.0 (20020519)
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e00)
checking if image is initramfs... it is
Freeing initrd memory: 2379k freed
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 5000-50ff claimed by vt82c586 ACPI
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: e4000000-e5ffffff
  PREFETCH window: e6000000-e6ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
audit: initializing netlink socket (disabled)
audit(1139016545.868:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 5
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
ACPI wakeup devices: 
USB0 USB1 
ACPI: (supports S0 S1 S5)
Freeing unused kernel memory: 228k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
de2104x PCI Ethernet driver v0.7 (Mar 17, 2004)
hda: Maxtor 90871U2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
eth0: 21041 at 0xc4802000, 00:80:c8:33:4f:96, IRQ 10
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 16992864 sectors (8700 MB) w/512KiB Cache, CHS=16858/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 >
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Floppy drive(s): fd0 is 1.44M
input: PC Speaker as /class/input/input1
FDC 0 is a post-1991 82077
mice: PS/2 mouse device common for all mice
Adding 305192k swap on /dev/hda5.  Priority:-1 extents:1 across:305192k
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

--zhXaljGHf11kAtnf--
