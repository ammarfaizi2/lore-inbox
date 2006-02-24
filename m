Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWBXW4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWBXW4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWBXW4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:56:54 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:4570 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932630AbWBXW4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:56:53 -0500
To: Dave Jones <davej@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suppress APIC errors on UP x86-64.
References: <20060224014228.GB16089@redhat.com>
	<200602240245.30161.ak@suse.de> <20060224015322.GG23471@redhat.com>
	<200602240318.12239.ak@suse.de> <20060224022701.GJ23471@redhat.com>
From: Chris Ball <cjb@mrao.cam.ac.uk>
Date: Fri, 24 Feb 2006 22:56:52 +0000
In-Reply-To: <20060224022701.GJ23471@redhat.com> (Dave Jones's message of
 "Thu, 23 Feb 2006 21:27:01 -0500")
Message-ID: <yd34q2ofjrf.fsf@islay.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>> On Thu, 23 Feb 2006 21:27:01, Dave Jones <davej@redhat.com> said:

   >> Some pattern analysis would be useful. All the same chipset,
   >> revision?

   > From first impression, it seems they're all (including mine) HP
   > laptops with ATI chipsets.

I have an HP _desktop_ with an ATI chipset and a dual-core 3800+ that
exhibits this.  If your patch just inhibits output for machines with
one logical CPU, it won't be inhibiting it on mine.  I'm seeing:

   powernow-k8: error - out of sync, fix 0xa 0x2, vid 0xa 0x12
   APIC error on CPU0: 00(40)       # once, at boot
   APIC error on CPU0: 40(40)       # repeated regularly after boot

   > I wonder if this is related at all to the 'time goes double speed'
   > bug that some folks see (incidentally, I don't on mine).

Yes, my machine exhibited this bug in earlier 2.6 releases.  Passing
enable_timer_pin_1 fixed it for me before the chipset detection was
brought into mainline.  Now that it's fixed, I still see the errors
above; while both problems are caused by ATI's bizarre chipset, the
error doesn't mean that double time is happening.

   >> Best you collect boot logs.

   > I'll try to gather some more data.

My dmesg and lspci are attached, let me know if you'd like anything
else.  The machine's an HP Pavilion A1250N.


--=-=-=
Content-Disposition: attachment; filename=dmesg
Content-Description: dmesg

Linux havoc 2.6.15-16-k7 #1 SMP PREEMPT Mon Feb 20 18:14:55 UTC 2006 i686 GNU/Linux
 (Top of boot is missing from dmesg and /var/log/dmesg.)
[4294670.669000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11)
[4294670.669000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 10 11)
[4294670.669000] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 *11), disabled.
[4294670.670000] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[4294670.670000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[4294670.672000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294670.672000] pnp: PnP ACPI init
[4294670.672000] pnp: PnPACPI: unknown resource type 7
[4294670.672000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
[4294670.673000] pnp: PnPACPI: unknown resource type 7
[4294670.673000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
[4294670.673000] pnp: PnPACPI: unknown resource type 7
[4294670.673000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0b00
[4294670.673000] pnp: PnPACPI: unknown resource type 7
[4294670.673000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0800
[4294670.673000] pnp: PnPACPI: unknown resource type 7
[4294670.673000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c04
[4294670.673000] pnp: PnPACPI: unknown resource type 7
[4294670.673000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
[4294670.674000] pnp: PnPACPI: unknown resource type 7
[4294670.674000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0401
[4294670.674000] pnp: PnPACPI: unknown resource type 7
[4294670.674000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0f13
[4294670.674000] pnp: PnPACPI: unknown resource type 7
[4294670.674000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0303
[4294670.674000] pnp: PnPACPI: unknown resource type 7
[4294670.674000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
[4294670.674000] pnp: PnPACPI: unknown resource type 7
[4294670.674000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[4294670.674000] pnp: PnP ACPI: found 0 devices
[4294670.674000] PnPBIOS: Disabled by ACPI PNP
[4294670.674000] PCI: Using ACPI for IRQ routing
[4294670.674000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294670.674000] PCI: Cannot allocate resource region 3 of device 0000:00:00.0
[4294670.732000] PCI: Bridge: 0000:00:02.0
[4294670.732000]   IO window: e000-efff
[4294670.732000]   MEM window: fa000000-fcffffff
[4294670.732000]   PREFETCH window: d0000000-dfffffff
[4294670.732000] PCI: Bridge: 0000:00:14.4
[4294670.732000]   IO window: d000-dfff
[4294670.732000]   MEM window: fde00000-fdefffff
[4294670.732000]   PREFETCH window: fdd00000-fddfffff
[4294670.732000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[4294670.732000] audit: initializing netlink socket (disabled)
[4294670.732000] audit(1140818198.730:1): initialized
[4294670.732000] VFS: Disk quotas dquot_6.5.1
[4294670.732000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294670.732000] Initializing Cryptographic API
[4294670.732000] io scheduler noop registered
[4294670.732000] io scheduler anticipatory registered
[4294670.732000] io scheduler deadline registered
[4294670.732000] io scheduler cfq registered
[4294670.782000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[4294670.782000] pcie_portdrv_probe->Dev[5a34:1002] has invalid IRQ. Check vendor BIOS
[4294670.782000] assign_interrupt_mode Found MSI capability
[4294670.782000] Allocate Port Service[pcie00]
[4294670.782000] Allocate Port Service[pcie01]
[4294670.782000] Allocate Port Service[pcie03]
[4294670.782000] isapnp: Scanning for PnP cards...
[4294671.139000] isapnp: No Plug & Play device found
[4294671.158000] PNP: No PS/2 controller found. Probing ports directly.
[4294671.161000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294671.161000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294671.161000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[4294671.162000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[4294671.162000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294671.162000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294671.162000] ACPI: bus type ide registered
[4294671.162000] mice: PS/2 mouse device common for all mice
[4294671.162000] EISA: Probing bus 0 at eisa.0
[4294671.162000] Cannot allocate resource for EISA slot 4
[4294671.162000] EISA: Detected 0 cards.
[4294671.162000] NET: Registered protocol family 2
[4294671.173000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294671.173000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[4294671.174000] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[4294671.174000] TCP: Hash tables configured (established 131072 bind 65536)
[4294671.174000] TCP reno registered
[4294671.175000] TCP bic registered
[4294671.175000] NET: Registered protocol family 1
[4294671.175000] NET: Registered protocol family 8
[4294671.175000] NET: Registered protocol family 20
[4294671.175000] Starting balanced_irq
[4294671.175000] Using IPI No-Shortcut mode
[4294671.175000] ACPI wakeup devices: 
[4294671.175000] PCI0 USB0 USB1 USB2 AUDO  P2P  MAC 
[4294671.175000] ACPI: (supports S0 S1 S3 S4 S5)
[4294671.175000] Freeing unused kernel memory: 300k freed
[4294671.196000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294671.231000] vesafb: framebuffer at 0xd0000000, mapped to 0xc0880000, using 10240k, total 262144k
[4294671.231000] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[4294671.231000] vesafb: protected mode interface info at c000:d4f0
[4294671.231000] vesafb: scrolling: redraw
[4294671.231000] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[4294671.231000] vesafb: Mode is VGA compatible
[4294671.510000] Console: switching to colour frame buffer device 160x64
[4294671.510000] fb0: VESA VGA frame buffer device
[4294672.528000] Capability LSM initialized
[4294672.573000] ACPI: Processor [CPU0] (supports 8 throttling states)
[4294672.573000] ACPI: Processor [CPU1] (supports 8 throttling states)
[4294672.871000] SCSI subsystem initialized
[4294672.872000] libata version 1.20 loaded.
[4294672.873000] sata_sil 0000:00:12.0: version 0.9
[4294672.873000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 193
[4294672.873000] ata1: SATA max UDMA/100 cmd 0xC0846080 ctl 0xC084608A bmdma 0xC0846000 irq 193
[4294672.873000] ata2: SATA max UDMA/100 cmd 0xC08460C0 ctl 0xC08460CA bmdma 0xC0846008 irq 193
[4294673.229000] ata1: dev 0 cfg 49:2f00 82:3069 83:7f69 84:4163 85:3069 86:3e01 87:4063 88:203f
[4294673.229000] ata1: dev 0 ATA-7, max UDMA/100, 488397168 sectors: LBA48
[4294673.229000] ata1: dev 0 configured for UDMA/100
[4294673.229000] scsi0 : sata_sil
[4294673.430000] ata2: no device found (phy stat 00000000)
[4294673.430000] scsi1 : sata_sil
[4294673.430000]   Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
[4294673.430000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294673.437000] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[4294673.437000] SCSI device sda: drive cache: write back
[4294673.437000] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[4294673.437000] SCSI device sda: drive cache: write back
[4294673.437000]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[4294673.474000] sd 0:0:0:0: Attached scsi disk sda
[4294673.760000] ATIIXP: IDE controller at PCI slot 0000:00:14.1
[4294673.760000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 201
[4294673.760000] ATIIXP: chipset revision 0
[4294673.760000] ATIIXP: not 100% native mode: will probe irqs later
[4294673.760000]     ide0: BM-DMA at 0xf800-0xf807, BIOS settings: hda:pio, hdb:pio
[4294673.760000]     ide1: BM-DMA at 0xf808-0xf80f, BIOS settings: hdc:pio, hdd:pio
[4294673.760000] Probing IDE interface ide0...
[4294674.279000] Probing IDE interface ide1...
[4294674.951000] hdc: HP DVD Writer 740b, ATAPI CD/DVD-ROM drive
[4294675.666000] hdd: IDE-DVD DROM6216, ATAPI CD/DVD-ROM drive
[4294675.719000] ide1 at 0x170-0x177,0x376 on irq 15
[4294675.728000] hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294675.728000] Uniform CD-ROM driver Revision: 3.20
[4294675.732000] hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
[4294675.738000] Probing IDE interface ide0...
[4294676.337000] usbcore: registered new driver usbfs
[4294676.337000] usbcore: registered new driver hub
[4294676.338000] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[4294676.338000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 209
[4294676.338000] ohci_hcd 0000:00:13.0: OHCI Host Controller
[4294676.338000] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
[4294676.338000] ohci_hcd 0000:00:13.0: irq 209, io mem 0xfe02e000
[4294676.393000] hub 1-0:1.0: USB hub found
[4294676.393000] hub 1-0:1.0: 4 ports detected
[4294676.494000] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 209
[4294676.494000] ohci_hcd 0000:00:13.1: OHCI Host Controller
[4294676.494000] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
[4294676.494000] ohci_hcd 0000:00:13.1: irq 209, io mem 0xfe02d000
[4294676.549000] hub 2-0:1.0: USB hub found
[4294676.549000] hub 2-0:1.0: 4 ports detected
[4294676.650000] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 209
[4294676.650000] ehci_hcd 0000:00:13.2: EHCI Host Controller
[4294676.651000] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
[4294676.651000] ehci_hcd 0000:00:13.2: irq 209, io mem 0xfe02c000
[4294676.651000] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4294676.651000] hub 3-0:1.0: USB hub found
[4294676.651000] hub 3-0:1.0: 8 ports detected
[4294676.839000] Attempting manual resume
[4294676.873000] EXT3-fs: mounted filesystem with ordered data mode.
[4294676.873000] kjournald starting.  Commit interval 5 seconds
[4294677.654000] usb 1-2: new full speed USB device using ohci_hcd and address 3
[4294678.011000] usb 2-2: new full speed USB device using ohci_hcd and address 2
[4294679.082000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[4294679.234000] usb 2-4: new full speed USB device using ohci_hcd and address 3
[4294679.730000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[4294679.733000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[4294679.841000] Linux agpgart interface v0.101 (c) Dave Jones
[4294679.922000] ieee1394: Initialized config rom entry `ip1394'
[4294679.932000] ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
[4294679.932000] ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 21 (level, low) -> IRQ 169
[4294679.932000] PCI: Via IRQ fixup for 0000:02:04.0, from 255 to 9
[4294679.964000] 8139too Fast Ethernet driver 0.9.27
[4294679.964000] ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 20 (level, low) -> IRQ 217
[4294679.965000] eth0: RealTek RTL8139 at 0xc1388000, 00:13:d3:4e:5c:b6, IRQ 217
[4294679.965000] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[4294680.032000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[169]  MMIO=[fdefd000-fdefd7ff]  Max Packet=[2048]
[4294680.051000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[4294680.217000] ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 225
[4294680.275000] logips2pp: Detected unknown logitech mouse model 0
[4294680.311000] Bluetooth: Core ver 2.8
[4294680.311000] NET: Registered protocol family 31
[4294680.311000] Bluetooth: HCI device and connection manager initialized
[4294680.311000] Bluetooth: HCI socket layer initialized
[4294680.348000] input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
[4294680.392000] ts: Compaq touchscreen protocol output
[4294680.417000] Bluetooth: HCI USB driver ver 2.9
[4294680.418000] usbcore: registered new driver hci_usb
[4294680.438000] usbcore: registered new driver hiddev
[4294680.467000] Initializing USB Mass Storage driver...
[4294680.492000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[4294680.517000] NET: Registered protocol family 17
[4294680.646000] input: FingerWorks TouchStream ST/LP  as /class/input/input2
[4294680.646000] input: USB HID v1.11 Keyboard [FingerWorks TouchStream ST/LP ] on usb-0000:00:13.1-2
[4294680.819000] input: FingerWorks TouchStream ST/LP  as /class/input/input3
[4294680.819000] input: USB HID v1.11 Mouse [FingerWorks TouchStream ST/LP ] on usb-0000:00:13.1-2
[4294681.032000] input: FingerWorks TouchStream ST/LP  as /class/input/input4
[4294681.032000] input: USB HID v1.11 Device [FingerWorks TouchStream ST/LP ] on usb-0000:00:13.1-2
[4294681.296000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc0000b3a0f0]
[4294681.338000] input: FingerWorks TouchStream ST/LP  as /class/input/input5
[4294681.338000] input: USB HID v1.11 Multi-Axis Controller [FingerWorks TouchStream ST/LP ] on usb-0000:00:13.1-2
[4294681.338000] usbcore: registered new driver usbhid
[4294681.338000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[4294681.338000] scsi2 : SCSI emulation for USB Mass Storage devices
[4294681.338000] usb-storage: device found at 3
[4294681.338000] usb-storage: waiting for device to settle before scanning
[4294681.338000] usbcore: registered new driver usb-storage
[4294681.338000] USB Mass Storage support registered.
[4294681.657000] parport0: PC-style at 0x378 [PCSPP,EPP]
[4294681.689000] parport0: Printer, HEWLETT-PACKARD DESKJET 950C
[4294681.692000] lp0: using parport0 (polling).
[4294681.713000] sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
[4294681.713000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[4294681.713000] ieee1394: sbp2: Try serialize_io=0 for better performance
[4294681.839000] Adding 2811332k swap on /dev/sda5.  Priority:-1 extents:1 across:2811332k
[4294681.950000] EXT3 FS on sda3, internal journal
[4294682.099000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294682.099000] md: bitmap version 4.39
[4294682.555000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[4294682.764000] cdrom: open failed.
[4294683.185000] cdrom: open failed.
[4294683.189000] cdrom: open failed.
[4294684.173000] NTFS driver 2.1.25 [Flags: R/O MODULE].
[4294684.215000] NTFS volume version 3.1.
[4294684.234000] kjournald starting.  Commit interval 5 seconds
[4294684.234000] EXT3 FS on sda6, internal journal
[4294684.234000] EXT3-fs: mounted filesystem with ordered data mode.
[4294686.344000]   Vendor: Generic   Model: USB SD Reader     Rev: 1.00
[4294686.344000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294686.374000] sd 2:0:0:0: Attached scsi removable disk sdb
[4294686.375000] sd 2:0:0:0: Attached scsi generic sg1 type 0
[4294686.380000]   Vendor: Generic   Model: USB CF Reader     Rev: 1.01
[4294686.380000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294686.411000] sd 2:0:0:1: Attached scsi removable disk sdc
[4294686.411000] sd 2:0:0:1: Attached scsi generic sg2 type 0
[4294686.416000]   Vendor: Generic   Model: USB SM Reader     Rev: 1.02
[4294686.416000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294686.447000] sd 2:0:0:2: Attached scsi removable disk sdd
[4294686.447000] sd 2:0:0:2: Attached scsi generic sg3 type 0
[4294686.453000]   Vendor: Generic   Model: USB MS Reader     Rev: 1.03
[4294686.453000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4294686.483000] sd 2:0:0:3: Attached scsi removable disk sde
[4294686.483000] sd 2:0:0:3: Attached scsi generic sg4 type 0
[4294686.483000] usb-storage: device scan complete
[4294687.553000] ACPI: Power Button (FF) [PWRF]
[4294687.553000] ACPI: Power Button (CM) [PWRB]
[4294687.601000] NET: Registered protocol family 10
[4294687.601000] lo: Disabled Privacy Extensions
[4294687.601000] IPv6 over IPv4 tunneling driver
[4294687.671000] ibm_acpi: ec object not found
[4294695.248000] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[4294695.248000] apm: disabled - APM is not SMP safe.
[4294697.350000] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[4294697.350000] hdc: drive_cmd: error=0x04 { AbortedCommand }
[4294697.350000] ide: failed opcode was: 0xec
[4294697.358000] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[4294697.358000] hdd: drive_cmd: error=0x04 { AbortedCommand }
[4294697.358000] ide: failed opcode was: 0xec
[4294697.926000] eth0: no IPv6 routers present
[4294697.975000] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[4294697.975000] hdc: drive_cmd: error=0x04 { AbortedCommand }
[4294697.975000] ide: failed opcode was: 0xec
[4294697.984000] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[4294697.984000] hdd: drive_cmd: error=0x04 { AbortedCommand }
[4294697.984000] ide: failed opcode was: 0xec
[4294699.110000] powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
[4294699.111000] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
[4294699.111000] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
[4294699.111000] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
[4294699.111000] cpu_init done, current fid 0xc, vid 0x8
[4294699.113000] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
[4294699.113000] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
[4294699.113000] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
[4294699.113000] cpu_init done, current fid 0xc, vid 0x8
[4294699.470000] Bluetooth: L2CAP ver 2.8
[4294699.470000] Bluetooth: L2CAP socket layer initialized
[4294699.472000] Bluetooth: RFCOMM socket layer initialized
[4294699.472000] Bluetooth: RFCOMM TTY layer initialized
[4294699.472000] Bluetooth: RFCOMM ver 1.6
[4294701.141000] powernow-k8: error - out of sync, fix 0xc 0xa, vid 0x8 0xa
[4294702.144000] powernow-k8: error - out of sync, fix 0xa 0x2, vid 0xa 0x12
[4294831.387000] APIC error on CPU0: 00(40)
[4294929.542000] APIC error on CPU0: 40(40)
[4294982.042000] APIC error on CPU0: 40(40)
[4295159.225000] APIC error on CPU0: 40(40)
[4295192.036000] APIC error on CPU0: 40(40)
[4295205.160000] APIC error on CPU0: 40(40)
[4295290.471000] APIC error on CPU0: 40(40)
[4295312.125000] APIC error on CPU0: 40(40)
[4295362.658000] APIC error on CPU0: 40(40)
[4295454.531000] APIC error on CPU0: 40(40)

--=-=-=
Content-Disposition: attachment; filename=lspci
Content-Description: lspci

0000:00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 64
	I/O ports at 4100 [disabled] [size=32]
	Memory at <ignored> (64-bit, non-prefetchable)

0000:00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-fcffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dff00000
	Capabilities: <available only to root>

0000:00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
	I/O ports at fe00 [size=8]
	I/O ports at fd00 [size=4]
	I/O ports at fc00 [size=8]
	I/O ports at fb00 [size=4]
	I/O ports at fa00 [size=16]
	Memory at fe02f000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 40000000 [disabled] [size=512K]
	Capabilities: <available only to root>

0000:00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 209
	Memory at fe02e000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 209
	Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 209
	Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: 66MHz, medium devsel
	I/O ports at 0400 [size=16]
	Memory at fe02b000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI (prog-if 8a [Master SecP PriP])
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 201
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f800 [size=16]
	Capabilities: <available only to root>

0000:00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fde00000-fdefffff
	Prefetchable memory behind bridge: fdd00000-fddfffff

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 2a25
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 225
	Memory at fe02a000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: <available only to root>

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0092 (rev a1) (prog-if 00 [VGA])
	Subsystem: eVga.com. Corp.: Unknown device c517
	Flags: bus master, fast devsel, latency 0, IRQ 5
	Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
	I/O ports at ef00 [size=128]
	Expansion ROM at fc000000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:01.0 Communication controller: Agere Systems V.92 56K WinModem (rev 03)
	Subsystem: Agere Systems: Unknown device 044c
	Flags: bus master, medium devsel, latency 64, IRQ 255
	Memory at fdeff000 (32-bit, non-prefetchable) [size=256]
	I/O ports at df00 [size=8]
	I/O ports at de00 [size=256]
	Capabilities: <available only to root>

0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, medium devsel, latency 64, IRQ 217
	I/O ports at dd00 [size=256]
	Memory at fdefe000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fdd00000 [disabled] [size=64K]
	Capabilities: <available only to root>

0000:02:04.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 2a24
	Flags: bus master, medium devsel, latency 64, IRQ 169
	Memory at fdefd000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at dc00 [size=128]
	Capabilities: <available only to root>


--=-=-=

- Chris.
-- 
Chris Ball   <cjb@mrao.cam.ac.uk>    <http://www.mrao.cam.ac.uk/~cjb/>

--=-=-=--

