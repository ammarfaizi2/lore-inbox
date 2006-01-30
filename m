Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWA3Ui2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWA3Ui2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWA3Ui2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:38:28 -0500
Received: from isilmar.linta.de ([213.239.214.66]:64456 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932383AbWA3Ui1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:38:27 -0500
Date: Mon, 30 Jan 2006 21:38:09 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: davej@redhat.com, dri-devel@lists.sourceforge.net
Subject: IRQ disabled (i915?) when switchig between gnome themes (gnome-theme-manager)
Message-ID: <20060130203809.GA8098@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org, davej@redhat.com,
	dri-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Something strange goes on when I try to switch more than two times between
gnome themes using gnome-theme-manager: the X server is killed -- that also
happens with 2.6.15, and that is surely an userspace bug, and the login
manager restarts. With current git and also with 2.6.16-rc1-mm3 and -mm4
sometimes the screen, and _only_ the screen is "frozen", and all the time
IRQ 10 is disabled:

 10:      34430          XT-PIC  Intel 82801DB-ICH4, Intel 82801DB-ICH4
Modem, yenta, yenta, ehci_hcd:usb1, uhci_hcd:usb2, i915@pci:0000:00:02.0

What's a bit strange about this is that the IRQ handler for i915 seems to be
gone right at the moment the "nobody cared" check triggers -- maybe the IRQ
handler is unregistered (a bit) too early?

CONFIG_AGP_INTEL=y
CONFIG_DRM_I915=y

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)

Thanks,
	Dominik

 Linux version 2.6.16-rc1 (brodo@sternenlicht) (gcc-Version 3.4.4 (Gentoo Hardened 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #2 PREEMPT Fri Jan 27 22:31:53 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
  BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000002f6e0000 (usable)
  BIOS-e820: 000000002f6e0000 - 000000002f6ec000 (ACPI data)
  BIOS-e820: 000000002f6ec000 - 000000002f700000 (ACPI NVS)
  BIOS-e820: 000000002f700000 - 0000000030000000 (reserved)
  BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
 758MB LOWMEM available.
 On node 0 totalpages: 194272
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 190176 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
 DMI present.
 ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7e80
 ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x2f6e7bc3
 ACPI: FADT (v001 INTEL  MONTARA  0x06040000 PTL  0x00000050) @ 0x2f6ebed2
 ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x2f6ebfd8
 ACPI: SSDT (v001 INTEL  CPU0CST  0x00000001 INTL 0x20020725) @ 0x2f6e800c
 ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x02012044) @ 0x2f6e7bf7
 ACPI: DSDT (v001 INTEL  MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
 ACPI: PM-Timer IO Port: 0x1008
 Allocating PCI resources starting at 40000000 (gap: 30000000:cec10000)
 Built 1 zonelists
 Kernel command line: root=/dev/hda5 acpi_sleep=s3_mode psmouse.proto=imps resume=/dev/hda8
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
 CPU 0 irqstacks, hard=c0444000 soft=c0443000
 PID hash table entries: 4096 (order: 12, 65536 bytes)
 Detected 1396.066 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Memory: 766088k/777088k available (2297k kernel code, 10512k reserved, 870k data, 144k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
 Calibrating delay using timer specific routine.. 2793.78 BogoMIPS (lpj=1396892)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
 CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
 CPU: L1 I cache: 32K, L1 D cache: 32K
 CPU: L2 cache: 1024K
 CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 mtrr: v2.0 (20020519)
 CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
 Checking 'hlt' instruction... OK.
    tbget-0284: *** Info: Table [DSDT] replaced by host OS
  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
 Parsing all Control Methods:..........................................................................................................................................................
 Table [DSDT](id 0007) - 520 Objects with 56 Devices 154 Methods 20 Regions
 Parsing all Control Methods:.
 Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
 Parsing all Control Methods:....
 Table [SSDT](id 0005) - 7 Objects with 0 Devices 4 Methods 0 Regions
 ACPI Namespace successfully loaded at root c0466dfc
 ACPI: setting ELCR to 0200 (from 0c20)
 evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=2
 PCI: Using configuration type 1
 ACPI: Subsystem revision 20050902
 evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
 evgpeblk-0996 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 0 Runtime GPEs in this block
 Completing Region/Field/Buffer/Package initialization:.....................................................
 Initialized 20/20 Regions 0/0 Fields 21/21 Buffers 12/15 Packages (537 nodes)
 Executing all Device _STA and_INI methods:............................................................
 60 Devices found containing: 60 _STA, 4 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
 Boot video device is 0000:00:02.0
 PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
 PCI quirk: region 1180-11bf claimed by ICH4 GPIO
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 PCI: Transparent bridge - 0000:00:1e.0
 PCI: Bus #03 (-#06) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
 PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
 ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
 ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
 ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
 ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
 ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
 ACPI: PCI Interrupt Link [LNKF] (IRQs 5) *0, disabled.
 ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
 ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
 ACPI: Embedded Controller [H_EC] (gpe 28)
 ACPI: Power Resource [PFAN] (on)
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
 PCI: Bus 3, cardbus bridge: 0000:02:03.0
   IO window: 00003400-000034ff
   IO window: 00003800-000038ff
   PREFETCH window: 40000000-41ffffff
   MEM window: 46000000-47ffffff
 PCI: Bus 7, cardbus bridge: 0000:02:03.1
   IO window: 00003c00-00003cff
   IO window: 00001400-000014ff
   PREFETCH window: 42000000-43ffffff
   MEM window: 48000000-49ffffff
 PCI: Bridge: 0000:00:1e.0
   IO window: 3000-3fff
   MEM window: e0200000-e02fffff
   PREFETCH window: 40000000-43ffffff
 PCI: Setting latency timer of device 0000:00:1e.0 to 64
 acpi_bus-0201 [02] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
 PCI: setting IRQ 10 as level-triggered
 ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:02:03.0 to 64
 acpi_bus-0201 [02] bus_set_power         : Device is not power manageable
 PCI: Enabling device 0000:02:03.1 (0000 -> 0003)
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
 ACPI: PCI Interrupt 0000:02:03.1[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:02:03.1 to 64
 Simple Boot Flag at 0x36 set to 0x1
 Machine check exception polling timer started.
 IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
 audit: initializing netlink socket (disabled)
 audit(1138648548.310:1): initialized
 fuse init (API version 7.5)
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered
 ACPI: AC Adapter [ADP1] (on-line)
 ACPI: Battery Slot [BAT1] (battery absent)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Lid Switch [LID0]
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: Power Button (CM) [PWRB]
 ACPI: Fan [FAN0] (on)
 Real Time Clock Driver v1.12ac
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected an Intel 855 Chipset.
 agpgart: Detected 8060K stolen memory.
 agpgart: AGP aperture is 128M @ 0xe8000000
 [drm] Initialized drm 1.0.1 20051102
 acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 [drm] Initialized i915 1.3.0 20051209 on minor 0
 [drm] Initialized i915 1.3.0 20051209 on minor 1
 intelfb: intelfb_init
 intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM chipsets
 intelfb: Version 0.9.2
 intelfb: intelfb_setup
 intelfb: no options
 intelfb: intelfb_pci_register
 ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 intelfb: fb aperture: 0xe8000000/0x8000000, MMIO region: 0xe0000000/0x80000
 intelfb: 00:02.0: Intel(R) 855GM, aperture size 128MB, stolen memory 8060kB
 intelfb: fb: 0xe8000000(+ 0x0)/0x7df000 (0xf0180000)
 intelfb: MMIO: 0xe0000000/0x80000 (0xf3980000)
 intelfb: ring buffer: 0xeb001000/0x10000 (0xf3181000)
 intelfb: HW cursor: 0x0/0x0 (0x0) (offset 0x0) (phys 0x0)
 intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0, noinit = 0
 intelfb: options: mode = ""
 intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
 intelfb: Video mode must be programmed at boot time.
 intelfb: cleanup
 i8042.c: Detected active multiplexing controller, rev 1.1.
 serio: i8042 AUX0 port at 0x60,0x64 irq 12
 serio: i8042 AUX1 port at 0x60,0x64 irq 12
 serio: i8042 AUX2 port at 0x60,0x64 irq 12
 serio: i8042 AUX3 port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 loop: loaded (max 8 devices)
 e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
 e100: Copyright(c) 1999-2005 Intel Corporation
 acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
 PCI: setting IRQ 5 as level-triggered
 ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 5 (level, low) -> IRQ 5
 e100: eth0: e100_probe: addr 0xe0201000, irq 5, MAC addr 00:00:F0:87:48:8F
 PPP generic driver version 2.4.2
 PPP Deflate Compression module registered
 PPP BSD Compression module registered
 PPP MPPE Compression module registered
 tun: Universal TUN/TAP device driver, 1.6
 tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 ICH4: IDE controller at PCI slot 0000:00:1f.1
 PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
 PCI: setting IRQ 11 as level-triggered
 ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
 ICH4: chipset revision 1
 ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
 Probing IDE interface ide0...
 hda: IC25N040ATMR04-0, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
 hdc: SAMSUNG CDRW/DVD SN-324F, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: max request size: 512KiB
 hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 mice: PS/2 mouse device common for all mice
 input: AT Translated Set 2 keyboard as /class/input/input0
 input: ImPS/2 Synaptics TouchPad as /class/input/input1
 input: PC Speaker as /class/input/input2
 i2c /dev entries driver
 Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
 acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
 intel8x0_measure_ac97_clock: measured 50219 usecs
 intel8x0: clocking to 48000
 acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:00:1f.6 to 64
 ALSA device list:
   #0: Intel 82801DB-ICH4 with STAC9752,53 at 0xe0100c00, irq 10
   #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 10
 Netfilter messages via NETLINK v0.30.
 NET: Registered protocol family 2
 IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
 TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
 TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
 TCP: Hash tables configured (established 131072 bind 65536)
 TCP reno registered
 ip_conntrack version 2.4 (6071 buckets, 48568 max) - 232 bytes per conntrack
 ctnetlink v0.90: registering with nfnetlink.
 ip_conntrack_pptp version 3.1 loaded
 ip_nat_pptp version 3.0 loaded
 ip_tables: (C) 2000-2006 Netfilter Core Team
 ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
 TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 Using IPI Shortcut mode
 ACPI wakeup devices: 
 PWRB LANC MODM 
 ACPI: (supports S0 S3 S4 S5)
 EXT3-fs: INFO: recovery required on readonly filesystem.
 EXT3-fs: write access will be enabled during recovery.
 (fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0, recovered transactions 553930 to 553936
 (fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 102 and revoked 6/6 blocks
 EXT3-fs: recovery complete.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 144k freed
 Write protecting the kernel read-only data: 428k
 Adding 1004020k swap on /dev/hda8.  Priority:-1 extents:1 across:1004020k
 EXT3 FS on hda5, internal journal
 ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 Yenta: CardBus bridge found at 0000:02:03.0 [144d:c009]
 Yenta: ISA IRQ mask 0x0098, PCI irq 10
 Socket status: 30000006
 pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
 cs: IO port probe 0x3000-0x3fff: clean.
 pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
 pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x43ffffff
 ACPI: PCI Interrupt 0000:02:03.1[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
 Yenta: CardBus bridge found at 0000:02:03.1 [144d:c009]
 Yenta: ISA IRQ mask 0x0098, PCI irq 10
 Socket status: 30000006
 pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
 cs: IO port probe 0x3000-0x3fff: clean.
 pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
 pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x43ffffff
 cs: IO port probe 0x100-0x3af: clean.
 cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
 cs: IO port probe 0x820-0x8ff: clean.
 cs: IO port probe 0xc00-0xcf7: clean.
 cs: IO port probe 0xa00-0xaff: clean.
 cs: IO port probe 0x100-0x3af: clean.
 cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
 cs: IO port probe 0x820-0x8ff: clean.
 cs: IO port probe 0xc00-0xcf7: clean.
 cs: IO port probe 0xa00-0xaff: clean.
 ieee80211_crypt: registered algorithm 'NULL'
 ieee80211: 802.11 data/management/control stack, git-1.1.7
 ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
 ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.1.3
 ipw2100: Copyright(c) 2003-2005 Intel Corporation
 acpi_bus-0201 [05] bus_set_power         : Device is not power manageable
 ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKE] -> GSI 5 (level, low) -> IRQ 5
 ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
 ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
 ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:00:1d.7 to 64
 ehci_hcd 0000:00:1d.7: EHCI Host Controller
 ehci_hcd 0000:00:1d.7: debug port 1
 PCI: cache line size of 32 is not supported by device 0000:00:1d.7
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
 ehci_hcd 0000:00:1d.7: irq 10, io mem 0xe0100000
 ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
 usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 6 ports detected
 USB Universal Host Controller Interface driver v2.3
 ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001820
 usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.1 to 64
 uhci_hcd 0000:00:1d.1: UHCI Host Controller
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
 uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001840
 usb usb3: configuration #1 chosen from 1 choice
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
 ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.2 to 64
 uhci_hcd 0000:00:1d.2: UHCI Host Controller
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
 uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001860
 usb usb4: configuration #1 chosen from 1 choice
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hda6, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hda3, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 microcode: CPU0 updated from revision 0x5 to 0x7, date = 11092004 
 irq 10: nobody cared (try booting with the "irqpoll" option)
  [<c01030bb>] show_trace+0xd/0xf
  [<c0103191>] dump_stack+0x15/0x17
  [<c01333fc>] __report_bad_irq+0x2e/0x6e
  [<c01334d0>] note_interrupt+0x75/0x9d
  [<c0132f3c>] __do_IRQ+0x9b/0xcf
  [<c010442c>] do_IRQ+0x70/0x8f
  =======================
  [<c0102db6>] common_interrupt+0x1a/0x20
  [<c0104527>] do_softirq+0x47/0x50
  =======================
  [<c01197c4>] irq_exit+0x30/0x3c
  [<c010443e>] do_IRQ+0x82/0x8f
  [<c0102db6>] common_interrupt+0x1a/0x20
  [<c0102e13>] error_code+0x4f/0x54
 handlers:
 [<c02cbb94>] (snd_intel8x0_interrupt+0x0/0x1d2)
 [<c02ce158>] (snd_intel8x0_interrupt+0x0/0x1a7)
 [<f0035797>] (yenta_interrupt+0x0/0x9f [yenta_socket])
 [<f0035797>] (yenta_interrupt+0x0/0x9f [yenta_socket])
 [<c028bbec>] (usb_hcd_irq+0x0/0x52)
 [<c028bbec>] (usb_hcd_irq+0x0/0x52)
 Disabling IRQ #10
