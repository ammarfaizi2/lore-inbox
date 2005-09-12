Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVILHvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVILHvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVILHvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:51:23 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:26317 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751207AbVILHvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:51:21 -0400
Message-ID: <6657267.1126511475921.JavaMail.ngmail@webmail-03.arcor-online.net>
Date: Mon, 12 Sep 2005 09:51:15 +0200 (CEST)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-g87fc767b: KERNEL: assertion in tcp_input.c and kernel BUG
 at mm/slab.c:2163
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 193.150.166.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel bug seem to come from one of the ntfs changes.

dmesg output:
"[17179569.184000] Linux version 2.6.13-g87fc767b (thomas@hotzenplotz) (gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #14 Sat Sep 10 16:39:05 CEST 2005
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[17179569.184000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000002bef0000 (usable)
[17179569.184000]  BIOS-e820: 000000002bef0000 - 000000002befb000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000002befb000 - 000000002bf00000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000002bf00000 - 0000000030000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
[17179569.184000] 702MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 179952
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:1
[17179569.184000]   Normal zone: 175856 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 0 pages, LIFO batch:1
[17179569.184000] DMI 2.3 present.
[17179569.184000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6890
[17179569.184000] ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x2bef5b5f
[17179569.184000] ACPI: FADT (v001 KN400  PTLTW    0x06040000 PTL_ 0x000f4240) @ 0x2befae95
[17179569.184000] ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x2befaf09
[17179569.184000] ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x4008
[17179569.184000] Allocating PCI resources starting at 40000000 (gap: 30000000:cffe0000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/hda3 resume=/dev/hda4 log_buf_len=4M kstack=300 
[17179569.184000] log_buf_len: 4194304
[17179569.184000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[17179569.184000] mapped APIC to ffffd000 (01987000)
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[17179569.184000] Detected 796.223 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179572.640000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179572.640000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179572.676000] Memory: 704144k/719808k available (3281k kernel code, 15168k reserved, 791k data, 216k init, 0k highmem)
[17179572.676000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179572.756000] Calibrating delay using timer specific routine.. 1594.26 BogoMIPS (lpj=3188523)
[17179572.756000] Mount-cache hash table entries: 512
[17179572.756000] CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
[17179572.756000] CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
[17179572.756000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[17179572.756000] CPU: L2 Cache: 512K (64 bytes/line)
[17179572.756000] CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
[17179572.756000] Intel machine check architecture supported.
[17179572.756000] Intel machine check reporting enabled on CPU#0.
[17179572.756000] mtrr: v2.0 (20020519)
[17179572.756000] CPU: AMD Mobile AMD Athlon(tm) XP 2400+ stepping 00
[17179572.756000] Enabling fast FPU save and restore... done.
[17179572.756000] Enabling unmasked SIMD FPU exception support... done.
[17179572.756000] Checking 'hlt' instruction... OK.
[17179572.792000] ACPI: setting ELCR to 0400 (from 0a30)
[17179572.796000] softlockup thread 0 started up.
[17179572.796000] NET: Registered protocol family 16
[17179572.796000] ACPI: bus type pci registered
[17179572.796000] PCI: PCI BIOS revision 2.10 entry at 0xfd65c, last bus=1
[17179572.796000] PCI: Using configuration type 1
[17179572.796000] ACPI: Subsystem revision 20050902
[17179572.804000] ACPI: Interpreter enabled
[17179572.804000] ACPI: Using PIC for interrupt routing
[17179572.808000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179572.808000] PCI: Probing PCI hardware (bus 00)
[17179572.816000] Boot video device is 0000:01:00.0
[17179572.816000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179572.828000] ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
[17179572.828000] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
[17179572.828000] ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
[17179572.832000] ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
[17179572.836000] ACPI: Embedded Controller [EC0] (gpe 1)
[17179572.840000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179572.840000] pnp: PnP ACPI init
[17179572.852000] pnp: PnP ACPI: found 11 devices
[17179572.852000] PnPBIOS: Disabled by ACPI PNP
[17179572.852000] SCSI subsystem initialized
[17179572.852000] usbcore: registered new driver usbfs
[17179572.852000] usbcore: registered new driver hub
[17179572.852000] PCI: Using ACPI for IRQ routing
[17179572.852000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179572.856000] pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
[17179572.856000] pnp: 00:05: ioport range 0xfe10-0xfe11 has been reserved
[17179572.856000] pnp: 00:05: ioport range 0x600-0x60f has been reserved
[17179572.856000] pnp: 00:05: ioport range 0xfe00-0xfe00 has been reserved
[17179572.856000] pnp: 00:05: ioport range 0x4000-0x407f could not be reserved
[17179572.856000] PCI: Failed to allocate mem resource #6:10000@f4000000 for 0000:01:00.0
[17179572.856000] PCI: Bridge: 0000:00:01.0
[17179572.856000]   IO window: disabled.
[17179572.856000]   MEM window: d1000000-d1ffffff
[17179572.856000]   PREFETCH window: f0000000-f3ffffff
[17179572.856000] PCI: Bus 2, cardbus bridge: 0000:00:07.0
[17179572.856000]   IO window: 00002000-00002fff
[17179572.856000]   IO window: 00003000-00003fff
[17179572.856000]   PREFETCH window: 40000000-41ffffff
[17179572.856000]   MEM window: 42000000-43ffffff
[17179572.856000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[17179572.856000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[17179572.856000] PCI: setting IRQ 5 as level-triggered
[17179572.856000] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[17179572.856000] PCI: Setting latency timer of device 0000:00:07.0 to 64
[17179572.856000] Machine check exception polling timer started.
[17179572.860000] VFS: Disk quotas dquot_6.5.1
[17179572.860000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179572.860000] fuse init (API version 7.2)
[17179572.860000] Initializing Cryptographic API
[17179572.860000] ACPI: AC Adapter [ACAD] (on-line)
[17179572.860000] ACPI: Battery Slot [BAT1] (battery absent)
[17179572.860000] ACPI: Power Button (FF) [PWRF]
[17179572.860000] ACPI: Power Button (CM) [PWRB]
[17179572.860000] ACPI: Sleep Button (CM) [SLPB]
[17179572.860000] ACPI: Lid Switch [LID]
[17179572.860000] Using specific hotkey driver
[17179572.860000] ACPI: CPU0 (power states: C1[C1] C2[C2])
[17179572.864000] ACPI: Thermal Zone [THRM] (52 C)
[17179572.864000] isapnp: Scanning for PnP cards...
[17179573.216000] isapnp: No Plug & Play device found
[17179573.220000] lp: driver loaded but no devices found
[17179573.220000] Real Time Clock Driver v1.12
[17179573.220000] Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
[17179573.220000] Linux agpgart interface v0.101 (c) Dave Jones
[17179573.220000] agpgart: Detected VIA KM400/KM400A chipset
[17179573.244000] agpgart: AGP aperture is 256M @ 0xe0000000
[17179573.244000] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[17179573.248000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179573.248000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179573.248000] parport: PnPBIOS parport detected.
[17179573.248000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[17179573.344000] lp0: using parport0 (interrupt-driven).
[17179573.344000] lp0: console ready
[17179573.344000] io scheduler noop registered
[17179573.344000] io scheduler anticipatory registered
[17179573.344000] io scheduler deadline registered
[17179573.344000] io scheduler cfq registered
[17179573.344000] RAMDISK driver initialized: 2 RAM disks of 8192K size 1024 blocksize
[17179573.344000] NET3 PLIP version 2.4-parport gniibe@mri.co.jp
[17179573.344000] plip0: Parallel port at 0x378, using IRQ 7.
[17179573.344000] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
[17179573.344000] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
[17179573.344000] PCI: setting IRQ 4 as level-triggered
[17179573.344000] ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 4 (level, low) -> IRQ 4
[17179573.348000] eth0: VIA Rhine II at 0x11800, 00:c0:9f:2b:79:76, IRQ 4.
[17179573.348000] eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
[17179573.348000] netconsole: not configured, aborting
[17179573.348000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179573.348000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179573.348000] VP_IDE: IDE controller at PCI slot 0000:00:11.1
[17179573.348000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 4 (level, low) -> IRQ 4
[17179573.348000] PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 4
[17179573.348000] VP_IDE: chipset revision 6
[17179573.348000] VP_IDE: not 100% native mode: will probe irqs later
[17179573.348000] VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
[17179573.348000]     ide0: BM-DMA at 0x1c60-0x1c67, BIOS settings: hda:DMA, hdb:pio
[17179573.348000]     ide1: BM-DMA at 0x1c68-0x1c6f, BIOS settings: hdc:DMA, hdd:pio
[17179573.348000] Probing IDE interface ide0...
[17179573.768000] hda: IC25N030ATMR04-0, ATA DISK drive
[17179574.440000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[17179574.440000] Probing IDE interface ide1...
[17179575.304000] hdc: Slimtype COMBO LSC-24082K, ATAPI CD/DVD-ROM drive
[17179575.976000] ide1 at 0x170-0x177,0x376 on irq 15
[17179575.976000] hda: max request size: 1024KiB
[17179575.996000] hda: 58605120 sectors (30005 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
[17179575.996000] hda: cache flushes supported
[17179575.996000]  hda: hda1 hda2 hda3 hda4
[17179576.016000] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[17179576.016000] Uniform CD-ROM driver Revision: 3.20
[17179576.016000] ieee1394: Initialized config rom entry `ip1394'
[17179576.016000] ieee1394: raw1394: /dev/raw1394 device initialized
[17179576.016000] usbmon: debugfs is not available
[17179576.016000] mice: PS/2 mouse device common for all mice
[17179576.016000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[17179576.016000] Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Tue Aug 30 05:31:08 2005 UTC).
[17179576.016000] ALSA device list:
[17179576.016000]   No soundcards found.
[17179576.016000] NET: Registered protocol family 2
[17179576.056000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179576.056000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[17179576.056000] TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
[17179576.064000] TCP: Hash tables configured (established 131072 bind 65536)
[17179576.064000] TCP reno registered
[17179576.064000] ip_conntrack version 2.3 (5623 buckets, 44984 max) - 216 bytes per conntrack
[17179576.064000] input: AT Translated Set 2 keyboard on isa0060/serio0
[17179576.160000] ip_tables: (C) 2000-2002 Netfilter core team
[17179576.328000] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
[17179576.328000] arp_tables: (C) 2002 David S. Miller
[17179576.364000] TCP bic registered
[17179576.364000] NET: Registered protocol family 1
[17179576.364000] NET: Registered protocol family 17
[17179576.364000] ieee80211_crypt: registered algorithm 'NULL'
[17179576.364000] ieee80211_crypt: registered algorithm 'WEP'
[17179576.364000] ieee80211_crypt: registered algorithm 'CCMP'
[17179576.364000] ieee80211_crypt: registered algorithm 'TKIP'
[17179576.364000] powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
[17179576.384000] Detected 796.224 MHz processor.
[17179576.388000] powernow: SGTC: 13333
[17179576.388000] powernow: Minimum speed 1260 MHz. Maximum speed 1791 MHz.
[17179576.388000] Using IPI Shortcut mode
[17179576.440000] ACPI wakeup devices: 
[17179576.440000] PCI0 USB1 USB2 USB3 USB4 Z002  LAN  LID 
[17179576.440000] ACPI: (supports S0 S3 S4 S5)
[17179576.508000] kjournald starting.  Commit interval 5 seconds
[17179576.508000] EXT3-fs: mounted filesystem with ordered data mode.
[17179576.508000] VFS: Mounted root (ext3 filesystem) readonly.
[17179576.508000] Freeing unused kernel memory: 216k freed
[17179576.652000] Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
[17179576.772000] input: SynPS/2 Synaptics TouchPad on isa0060/serio1
[17179580.836000] cdrom: open failed.
[17179581.868000] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[17179581.868000] EXT3 FS on hda3, internal journal
[17179582.640000] cdrom: open failed.
[17179583.772000] NTFS driver 2.1.24 [Flags: R/W MODULE].
[17179583.852000] NTFS volume version 3.1.
[17179583.968000] Adding 265064k swap on /dev/mapper/crypt-swap.  Priority:-1 extents:1 across:265064k
[17179590.864000] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[17179590.864000] Yenta: CardBus bridge found at 0000:00:07.0 [1025:0033]
[17179590.864000] Yenta: Enabling burst memory read transactions
[17179590.864000] Yenta: Using CSCINT to route CSC interrupts to PCI
[17179590.864000] Yenta: Routing CardBus interrupts to PCI
[17179590.864000] Yenta TI: socket 0000:00:07.0, mfunc 0x01201212, devctl 0x64
[17179591.096000] Yenta: ISA IRQ mask 0x0808, PCI irq 5
[17179591.096000] Socket status: 30000006
[17179591.252000] ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
[17179591.252000] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[17179591.304000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[d0004000-d00047ff]  Max Packet=[2048]
[17179591.460000] USB Universal Host Controller Interface driver v2.3
[17179591.472000] ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 4 (level, low) -> IRQ 4
[17179591.472000] PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 4
[17179591.472000] uhci_hcd 0000:00:10.0: UHCI Host Controller
[17179591.488000] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[17179591.488000] uhci_hcd 0000:00:10.0: irq 4, io base 0x00001c00
[17179591.488000] hub 1-0:1.0: USB hub found
[17179591.488000] hub 1-0:1.0: 2 ports detected
[17179591.500000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[17179591.500000] PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 5
[17179591.500000] uhci_hcd 0000:00:10.1: UHCI Host Controller
[17179591.512000] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[17179591.512000] uhci_hcd 0000:00:10.1: irq 5, io base 0x00001c20
[17179591.516000] hub 2-0:1.0: USB hub found
[17179591.516000] hub 2-0:1.0: 2 ports detected
[17179591.524000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[17179591.524000] PCI: setting IRQ 9 as level-triggered
[17179591.524000] ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
[17179591.524000] PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 9
[17179591.524000] uhci_hcd 0000:00:10.2: UHCI Host Controller
[17179591.532000] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[17179591.532000] uhci_hcd 0000:00:10.2: irq 9, io base 0x00001c40
[17179591.536000] hub 3-0:1.0: USB hub found
[17179591.536000] hub 3-0:1.0: 2 ports detected
[17179591.700000] usb 1-1: new low speed USB device using uhci_hcd and address 2
[17179592.576000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000ea585]
[17179592.796000] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:10.0-1
[17179592.796000] usbcore: registered new driver usbhid
[17179592.796000] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[17179593.032000] eth1394: $Rev: 1264 $ Ben Collins <bcollins@debian.org>
[17179593.032000] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[17179593.204000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[17179593.204000] PCI: setting IRQ 11 as level-triggered
[17179593.204000] ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[17179593.204000] PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 11
[17179593.204000] ehci_hcd 0000:00:10.3: EHCI Host Controller
[17179593.216000] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[17179593.216000] ehci_hcd 0000:00:10.3: irq 11, io mem 0xd0004800
[17179593.216000] ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[17179593.220000] hub 4-0:1.0: USB hub found
[17179593.220000] hub 4-0:1.0: 6 ports detected
[17179593.428000] usb 1-1: USB disconnect, address 2
[17179593.632000] usb 1-1: new low speed USB device using uhci_hcd and address 3
[17179593.800000] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:10.0-1
[17179594.560000] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
[17179594.560000] PCI: Setting latency timer of device 0000:00:11.5 to 64
[17179595.940000] input: PC Speaker
[17179596.388000] FDC 0 is a National Semiconductor PC87306
[17179606.808000] cdrom: open failed.
[17179608.892000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[17179646.080000] [drm] Initialized drm 1.0.0 20040925
[17179646.128000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 4 (level, low) -> IRQ 4
[17179646.128000] [drm] Initialized via 2.6.3 20050523 on minor 0: 
[17179646.248000] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
[17179646.248000] agpgart: Device is in legacy mode, falling back to 2.x
[17179646.248000] agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
[17179646.248000] agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode
[17188781.184000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17188781.184000] Leak l=4294967295 4
[17189444.364000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17189444.364000] Leak l=4294967295 4
[17189456.076000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17189456.252000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17189457.336000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17189457.336000] Leak l=4294967295 3
[17189649.960000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17189649.960000] Leak l=4294967295 4
[17202339.668000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17202339.668000] Leak l=4294967295 4
[17203098.892000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17203098.892000] Leak l=4294967295 4
[17203916.240000] KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
[17203916.240000] Leak l=4294967295 4
[17204956.632000] ------------[ cut here ]------------
[17204956.632000] kernel BUG at mm/slab.c:2163!
[17204956.632000] invalid operand: 0000 [#1]
[17204956.632000] Modules linked in: via drm floppy pcspkr snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_rawmidi i2c_viapro i2c_core ehci_hcd eth1394 usbhid uhci_hcd ohci1394 yenta_socket rsrc_nonstatic pcmcia_core joydev ntfs
[17204956.632000] CPU:    0
[17204956.632000] EIP:    0060:[<c015ebc7>]    Not tainted VLI
[17204956.632000] EFLAGS: 00010002   (2.6.13-g87fc767b) 
[17204956.632000] EIP is at cache_grow+0x17/0x360
[17204956.632000] eax: ebeeb160   ebx: 00000052   ecx: ebeef7a0   edx: 00000052
[17204956.632000] esi: ebeef7a0   edi: ebeed6b0   ebp: c0ec7c1c   esp: c0ec7be8
[17204956.632000] ds: 007b   es: 007b   ss: 0068
[17204956.632000] Process updatedb (pid: 13736, threadinfo=c0ec6000 task=ea934570)
[17204956.632000] Stack: ec8efb40 00000286 c0ec7c18 c01a4408 da8a43c0 c283bce0 c283bddc c0ec7c18 
[17204956.632000]        ec8c6571 ebc0c220 0000000c 00000052 ebeed6b0 c0ec7c60 c015f239 ebeef7a0 
[17204956.632000]        00000052 00000000 c283bf98 ec8efb40 ec8efb40 c0ec7c5c ec8e0273 ebeed6a8 
[17204956.632000]        ebeee460 ebeeb160 ebeed6a0 00000246 00000052 ebeef7a0 c0ec7c7c c015f5ca 
[17204956.632000]        ebeef7a0 00000052 ccb61550 00000000 dbd94140 c0ec7cec ec8d7fd8 ebeef7a0 
[17204956.632000]        00000052 ec854000 ebd32400 00000000 00000000 00000004 000000a0 00000000 
[17204956.632000]        00000000 00000000 c0ec7cec ec8c6396 000000a0 0000fb40 00001000 ccb615a0 
[17204956.632000]        ccb61598 00000000 00000000 00000000 00000000 00000000 00000001 00000000 
[17204956.632000]        dbd94140 c0ec7d38 ec8c502b ebd32400 ccb61550 00000000 00000000 00000000 
[17204956.632000]        00000000 00000000 00000000 da8a43c0 00000000 ccb61550 00000000 da8a43c0 
[17204956.632000]        dbd94140 dbd94140 dbd94174 00000000 c0ec7d58 ec8c5142 dbd94140 00000000 
[17204956.632000]        00000000 fffffffe ffffffff dbd94174 c0ec7e10 ec8c1851 dbd94140 00000000 
[17204956.632000]        00000000 ccb615b8 00000004 fffffff4 c8954e9c ccb615a0 c0ec7dd4 ec8c57bc 
[17204956.632000]        00000200 00000000 00000246 00000000 00000001 00000000 dbd94140 0915422c 
[17204956.632000]        00000000 00000000 00000200 00000008 00000000 00000008 00000000 00000000 
[17204956.632000]        00000000 c5c61b98 c5c61b98 00000000 ebd32400 00000000 00000000 c0ec7df8 
[17204956.632000]        c025980e ebee6840 00000020 00000001 c0ec7e18 c0259a87 dbd94328 c123edc0 
[17204956.632000]        dbd94140 c123edc0 c0ec7e58 ec8c1b7e c123edc0 c0153f89 dbd94328 00000000 
[17204956.632000]        c123edc0 00000000 c123edc0 c123edc0 c0ec7e58 00000000 c123edc0 dbd94324 
[17204956.632000]        00000000 c123edc0 00000000 c123edc0 c0ec7e7c c0155ba7 00000000 c123edc0 
[17204956.632000]        00000000 000000d0 dbd94324 fffff000 00000000 c0ec7f60 ec8caa88 dbd94324 
[17204956.632000]        00000000 ec8c1940 00000000 00000000 00000000 00000000 00000000 da8a43c0 
[17204956.632000]        00000000 bffbc150 c0ec7f44 c0ec7ed0 c025cd6a bffbc150 c0ec7ee4 00000060 
[17204956.632000]        c0ec7f60 c0ec7ee4 c0ec7f50 c018caef d419c000 c1283380 cea49800 00000000 
[17204956.632000]        e42f6898 00000000 00000000 c1283380 c283bec4 dbd94324 00000000 00000002 
[17204956.632000]        00000000 00000000 00000000 ebd32400 dbd94140 ebd14800 dbd9423c 00001000 
[17204956.632000]        00000000 00000400 00000000 00000000 00000000 00000000 00000000 00000000 
[17204956.632000]        00000000 c8954e9c c0ec7f7c dbd9423c c2886900 fffffffe c0ec7f80 c01985d6 
[17204956.632000]        c2886900 c0ec7f98 c0198700 00001000 fffffff7 08055de4 c0ec7fb4 c0198832 
[17204956.632000]        c2886900 c0198700 c0ec7f98 c2886900 08055e04 08055df4 00000fe0 ffffffea 
[17204956.632000]        00000005 08055de4 b7f7bff4 c0ec6000 c01039ff 00000005 08055de4 00001000 
[17204956.632000]        08055de4 b7f7bff4 bffbc1ac 0000008d 0000007b 0000007b 0000008d ffffe410 
[17204956.632000]        00000073 00000292 bffbc170 0000007b 6a935085 908a6086 
[17204956.632000] Call Trace:
[17204956.632000]  [<c010496f>] show_stack+0x7f/0xa0
[17204956.632000]  [<c0104b09>] show_registers+0x159/0x1d0
[17204956.632000]  [<c0104d46>] die+0x136/0x2c0
[17204956.632000]  [<c0433117>] do_trap+0x87/0xd0
[17204956.632000]  [<c01051f5>] do_invalid_op+0xb5/0xc0
[17204956.632000]  [<c010450b>] error_code+0x4f/0x54
[17204956.632000]  [<c015f239>] cache_alloc_refill+0x329/0x370
[17204956.632000]  [<c015f5ca>] kmem_cache_alloc+0x5a/0x60
[17204956.632000]  [<ec8d7fd8>] ntfs_mapping_pairs_decompress+0x88/0x710 [ntfs]
[17204956.632000]  [<ec8c502b>] ntfs_map_runlist_nolock+0x10b/0x1c0 [ntfs]
[17204956.632000]  [<ec8c5142>] ntfs_map_runlist+0x62/0x90 [ntfs]
[17204956.632000]  [<ec8c1851>] ntfs_read_block+0x5c1/0x6b0 [ntfs]
[17204956.632000]  [<ec8c1b7e>] ntfs_readpage+0x23e/0x2e0 [ntfs]
[17204956.632000]  [<c0155ba7>] read_cache_page+0xb7/0x270
[17204956.632000]  [<ec8caa88>] ntfs_readdir+0x578/0x1190 [ntfs]
[17204956.632000]  [<c01985d6>] vfs_readdir+0x86/0xa0
[17204956.632000]  [<c0198832>] sys_getdents+0x72/0xc0
[17204956.632000]  [<c01039ff>] sysenter_past_esp+0x54/0x75
[17204956.632000] Code: 00 00 00 00 89 58 18 89 70 1c 83 c0 20 4a 75 f4 5b 5e c9 c3 55 89 e5 57 56 53 83 ec 28 8b 5d 0c 8b 75 08 f7 c3 0e 80 f8 ff 74 08 <0f> 0b 73 08 ff 83 44 c0 31 c0 f6 c7 20 0f 85 12 02 00 00 89 d8 
[17204956.632000]  
"
