Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWBUWu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWBUWu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWBUWu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:50:57 -0500
Received: from HSI-KBW-082-212-034-022.hsi.kabelbw.de ([82.212.34.22]:43917
	"EHLO afrodita") by vger.kernel.org with ESMTP id S964886AbWBUWu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:50:56 -0500
From: Ariel Garcia <garcia@iwr.fzk.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
Date: Tue, 21 Feb 2006 23:50:33 +0100
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de> <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1684
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5k5+DNIOgu3WwKN"
Message-Id: <200602212350.33394.garcia@iwr.fzk.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5k5+DNIOgu3WwKN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Randy, Jens,

> > The first thing to try is to add the acpi addon from Randy and see if
> > that helps at all. Looking at the log, the first command we issue
> > after resume times out which smells a lot like an unlock command
> > missing (which is typically in the GTF list from acpi).
>
> Ariel-
> These patches (for 2.6.16-rc3) are at
>http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-2616-rc3.patch
> in case you didn't find them yet.

yes, thanks! i had found them, but i hadn't reported yet because it didn't 
work (exactly the same output as w/o the patch) and i wanted to enable 
your new debugging functionality to get some additional feedback.

So at least now (printk=255) i can see that there seems to be an error 
_before_ the suspend, just when loading the GTFs (whatever they are ;-)

do_drive_get_GTF: ERR: ata_dev_present: 0, PORT_DISABLED: 0
ata_acpi_exec_tfs: get_GTF error (-19)
ata_acpi_exec_tfs: ret=-19

but no extra debugging output after the suspend/restart. Does that help? 
dmesg output attached.

Thanks for your work!
Ariel

--Boundary-00=_5k5+DNIOgu3WwKN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

0]   IO window: 00002400-000024ff
[4294668.682000]   PREFETCH window: 50000000-51ffffff
[4294668.682000]   MEM window: 54000000-55ffffff
[4294668.682000] PCI: Bridge: 0000:00:1e.0
[4294668.682000]   IO window: 2000-2fff
[4294668.682000]   MEM window: b0200000-b02fffff
[4294668.682000]   PREFETCH window: 50000000-51ffffff
[4294668.682000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[4294668.682000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4294668.682000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[4294668.682000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4294668.682000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4294668.682000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294668.682000] Simple Boot Flag at 0x7f set to 0x1
[4294668.683000] audit: initializing netlink socket (disabled)
[4294668.683000] audit(1140555982.681:1): initialized
[4294668.683000] Initializing Cryptographic API
[4294668.683000] io scheduler noop registered
[4294668.683000] io scheduler anticipatory registered (default)
[4294668.683000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[4294668.684000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4294668.684000] assign_interrupt_mode Found MSI capability
[4294668.684000] Allocate Port Service[0000:00:1c.0:pcie00]
[4294668.684000] Allocate Port Service[0000:00:1c.0:pcie02]
[4294668.684000] Allocate Port Service[0000:00:1c.0:pcie03]
[4294668.684000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[4294668.684000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4294668.684000] assign_interrupt_mode Found MSI capability
[4294668.684000] Allocate Port Service[0000:00:1c.1:pcie00]
[4294668.684000] Allocate Port Service[0000:00:1c.1:pcie02]
[4294668.684000] Allocate Port Service[0000:00:1c.1:pcie03]
[4294668.686000] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[4294668.688000] i8042.c: Detected active multiplexing controller, rev 1.1.
[4294668.690000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[4294668.690000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[4294668.690000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[4294668.691000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[4294668.691000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294668.691000] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[4294668.691000] STRIP: Version 1.3A-STUART.CHESHIRE (unlimited channels)
[4294668.692000] MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb 19 2006
[4294668.692000] NET: Registered protocol family 2
[4294668.702000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294668.702000] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[4294668.702000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294668.703000] TCP: Hash tables configured (established 131072 bind 65536)
[4294668.703000] TCP reno registered
[4294668.703000] TCP bic registered
[4294668.703000] NET: Registered protocol family 1
[4294668.703000] NET: Registered protocol family 17
[4294668.703000] NET: Registered protocol family 8
[4294668.703000] NET: Registered protocol family 20
[4294668.703000] Using IPI Shortcut mode
[4294668.703000] ACPI wakeup devices: 
[4294668.703000] PCIB MODM AZAL EXP1 EXP2  LID 
[4294668.704000] ACPI: (supports S0 S3 S4 S5)
[4294668.704000] Freeing unused kernel memory: 164k freed
[4294668.764000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294668.852000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294668.930000] usbcore: registered new driver usbfs
[4294668.930000] usbcore: registered new driver hub
[4294668.931000] USB Universal Host Controller Interface driver v2.3
[4294668.931000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 209
[4294668.931000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4294668.931000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[4294668.931000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[4294668.931000] uhci_hcd 0000:00:1d.0: irq 209, io base 0x00001420
[4294668.931000] usb usb1: configuration #1 chosen from 1 choice
[4294668.932000] hub 1-0:1.0: USB hub found
[4294668.932000] hub 1-0:1.0: 2 ports detected
[4294669.033000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 217
[4294669.033000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4294669.033000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[4294669.033000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[4294669.033000] uhci_hcd 0000:00:1d.1: irq 217, io base 0x00001440
[4294669.033000] usb usb2: configuration #1 chosen from 1 choice
[4294669.033000] hub 2-0:1.0: USB hub found
[4294669.033000] hub 2-0:1.0: 2 ports detected
[4294669.134000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 225
[4294669.134000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4294669.134000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[4294669.134000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[4294669.134000] uhci_hcd 0000:00:1d.2: irq 225, io base 0x00001460
[4294669.135000] usb usb3: configuration #1 chosen from 1 choice
[4294669.135000] hub 3-0:1.0: USB hub found
[4294669.135000] hub 3-0:1.0: 2 ports detected
[4294669.236000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
[4294669.236000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4294669.236000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[4294669.236000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[4294669.236000] uhci_hcd 0000:00:1d.3: irq 177, io base 0x00001480
[4294669.236000] usb usb4: configuration #1 chosen from 1 choice
[4294669.236000] hub 4-0:1.0: USB hub found
[4294669.236000] hub 4-0:1.0: 2 ports detected
[4294669.337000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 209
[4294669.337000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4294669.337000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[4294669.337000] ehci_hcd 0000:00:1d.7: debug port 1
[4294669.337000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[4294669.337000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[4294669.338000] ehci_hcd 0000:00:1d.7: irq 209, io mem 0xb0004000
[4294669.342000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4294669.342000] usb usb5: configuration #1 chosen from 1 choice
[4294669.342000] hub 5-0:1.0: USB hub found
[4294669.342000] hub 5-0:1.0: 8 ports detected
[4294669.425000] SCSI subsystem initialized
[4294669.428000] libata version 1.20 loaded.
[4294669.439000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294669.439000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294669.443000] tg3.c:v3.49 (Feb 2, 2006)
[4294669.443000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294669.443000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[4294669.466000] eth0: Tigon3 [partno(BCM95751m) rev 4201 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0b:5d:c7:47:ef
[4294669.467000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[4294669.467000] eth0: dma_rwctrl[76180000]
[4294669.487000] ahci 0000:00:1f.2: version 1.2
[4294669.488000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
[4294673.800000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294673.800000] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl SATA mode
[4294673.800000] ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part 
[4294673.800000] ata1: SATA max UDMA/133 cmd 0xF882E500 ctl 0x0 bmdma 0x0 irq 217
[4294673.800000] ata2: SATA max UDMA/133 cmd 0xF882E580 ctl 0x0 bmdma 0x0 irq 217
[4294673.800000] ata3: SATA max UDMA/133 cmd 0xF882E600 ctl 0x0 bmdma 0x0 irq 217
[4294673.800000] ata4: SATA max UDMA/133 cmd 0xF882E680 ctl 0x0 bmdma 0x0 irq 217
[4294674.002000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[4294674.002000] ata1: dev 0 cfg 00:045a 49:2f00 82:346b 83:7f09 84:6063 85:346b 86:bf09 87:6063 88:203f 93:0000
[4294674.002000] ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
[4294674.002000] ata_acpi_push_id: ap->id: 1, ix = 0, port#: 0, hard_port#: 0
[4294674.002000] sata_get_dev_handle: SATA dev addr=0x1f0002, handle=0xc17d9f40
[4294674.006000] :\_SB_.PCI0.SATA: matches pcidevfn (0x1f0002)
[4294674.006000] GOT ONE: (\_SB_.PCI0.SATA.PRT0) root_port = 0x0, port_num = 0xffff
[4294674.006000] THIS ^^^^^ is the requested SATA drive (handle = 0xc17e44e0)
[4294674.006000] GOT ONE: (\_SB_.PCI0.SATA.PRT2) root_port = 0x2, port_num = 0xffff
[4294674.009000] ata1: dev 0 configured for UDMA/100
[4294674.009000] ata_acpi_exec_tfs: ENTER:
[4294674.009000] ata_acpi_exec_tfs: call get_GTF, ix=0
[4294674.009000] do_drive_get_GTF: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4294674.009000] sata_get_dev_handle: SATA dev addr=0x1f0002, handle=0xc17d9f40
[4294674.009000] do_drive_get_GTF: returning gtf_length=14, gtf_address=0xf743b3b0, obj_loc=0xf743b3a0
[4294674.009000] ata_acpi_exec_tfs: call set_taskfiles, ix=0
[4294674.009000] do_drive_set_taskfiles: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4294674.009000] do_drive_set_taskfiles: total GTF bytes=14 (0xe), gtf_count=2, addr=0xf743b3b0
[4294674.009000] taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 00 00 a0 ef
[4294674.009000] call ata_exec_internal:
[4294674.011000] taskfile_load_raw: (0x1f1-1f7): hex: 00 00 00 00 00 a0 f5
[4294674.011000] call ata_exec_internal:
[4294674.011000] ata_acpi_exec_tfs: call get_GTF, ix=1
[4294674.011000] do_drive_get_GTF: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4294674.011000] do_drive_get_GTF: ERR: ata_dev_present: 0, PORT_DISABLED: 0
[4294674.011000] ata_acpi_exec_tfs: get_GTF error (-19)
[4294674.011000] ata_acpi_exec_tfs: ret=-19
[4294674.011000] scsi0 : ahci
[4294674.213000] ata2: SATA link down (SStatus 0)
[4294674.213000] scsi1 : ahci
[4294674.415000] ata3: SATA link down (SStatus 0)
[4294674.415000] scsi2 : ahci
[4294674.617000] ata4: SATA link down (SStatus 0)
[4294674.617000] scsi3 : ahci
[4294674.617000]   Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 0000
[4294674.618000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294674.618000] ata_acpi_get_timing: ENTER:
[4294674.618000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.618000] ata_acpi_get_timing: ENTER:
[4294674.618000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.618000] ata_acpi_get_timing: ENTER:
[4294674.618000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.618000] ata_acpi_get_timing: ENTER:
[4294674.618000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.621000] ICH6: IDE controller at PCI slot 0000:00:1f.1
[4294674.621000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 225
[4294674.621000] ICH6: chipset revision 4
[4294674.621000] ICH6: not 100% native mode: will probe irqs later
[4294674.622000]     ide0: BM-DMA at 0x1410-0x1417, BIOS settings: hda:DMA, hdb:pio
[4294674.622000] Probing IDE interface ide0...
[4294674.655000] Driver 'sd' needs updating - please use bus_type methods
[4294674.656000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294674.656000] sda: Write Protect is off
[4294674.656000] sda: Mode Sense: 00 3a 00 10
[4294674.656000] SCSI device sda: drive cache: write back w/ FUA
[4294674.657000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294674.657000] sda: Write Protect is off
[4294674.657000] sda: Mode Sense: 00 3a 00 10
[4294674.657000] SCSI device sda: drive cache: write back w/ FUA
[4294674.657000]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[4294674.785000] sd 0:0:0:0: Attached scsi disk sda
[4294675.294000] hda: MATSHITAUJ-841Db, ATAPI CD/DVD-ROM drive
[4294675.600000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294675.610000] hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294675.611000] Uniform CD-ROM driver Revision: 3.20
[4294676.007000] Probing IDE interface ide1...
[4294676.613000] Attempting manual resume
[4294676.613000] swsusp: Resume From Partition 8:6
[4294676.613000] PM: Checking swsusp image.
[4294676.613000] PM: Resume from disk failed.
[4294676.627000] EXT3-fs: INFO: recovery required on readonly filesystem.
[4294676.627000] EXT3-fs: write access will be enabled during recovery.
[4294677.068000] EXT3-fs: recovery complete.
[4294677.069000] kjournald starting.  Commit interval 5 seconds
[4294677.069000] EXT3-fs: mounted filesystem with ordered data mode.
[4294679.050000] Real Time Clock Driver v1.12ac
[4294679.065000] Linux agpgart interface v0.101 (c) Dave Jones
[4294679.086000] agpgart: Detected an Intel 915GM Chipset.
[4294679.087000] agpgart: Detected 7932K stolen memory.
[4294679.104000] agpgart: AGP aperture is 256M @ 0xc0000000
[4294679.522000] hw_random: RNG not detected
[4294679.651000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294679.651000] Yenta: CardBus bridge found at 0000:06:03.0 [10cf:131e]
[4294679.775000] Yenta: ISA IRQ mask 0x0cb8, PCI irq 177
[4294679.775000] Socket status: 30000006
[4294679.775000] pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
[4294679.775000] pcmcia: parent PCI bridge Memory window: 0xb0200000 - 0xb02fffff
[4294679.775000] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
[4294679.819000] Synaptics Touchpad, model: 1, fw: 5.9, id: 0xf8eb1, caps: 0xa04793/0x102000
[4294679.819000] serio: Synaptics pass-through port at isa0060/serio4/input0
[4294679.860000] input: SynPS/2 Synaptics TouchPad as /class/input/input1
[4294679.864000] input: PC Speaker as /class/input/input2
[4294680.063000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294680.063000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[4294680.124000] ieee80211_crypt: registered algorithm 'NULL'
[4294680.125000] ieee80211: 802.11 data/management/control stack, git-1.1.7
[4294680.126000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[4294680.175000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[4294680.175000] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[4294680.285000] ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 18 (level, low) -> IRQ 225
[4294680.285000] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[4294680.615000] ipw2200: Radio Frequency Kill Switch is On:
[4294680.615000] Kill switch must be turned off for wireless networking to work.
[4294684.061000] input: PS/2 Generic Mouse as /class/input/input3
[4294684.390000] Adding 1012052k swap on /dev/sda6.  Priority:-1 extents:1 across:1012052k
[4294742.353000] EXT3 FS on sda2, internal journal
[4294745.406000] mice: PS/2 mouse device common for all mice
[4294866.967000] kjournald starting.  Commit interval 5 seconds
[4294866.967000] EXT3 FS on sda1, internal journal
[4294866.967000] EXT3-fs: mounted filesystem with ordered data mode.
[4294866.987000] kjournald starting.  Commit interval 5 seconds
[4294866.987000] EXT3 FS on sda5, internal journal
[4294866.987000] EXT3-fs: mounted filesystem with ordered data mode.
[4294867.021000] kjournald starting.  Commit interval 5 seconds
[4294867.021000] EXT3 FS on sda3, internal journal
[4294867.021000] EXT3-fs: mounted filesystem with ordered data mode.

[4295870.453000] PM: Preparing system for mem sleep
[4295870.454000] Stopping tasks: ==============|
[4295871.482000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[4295871.493000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[4295871.493000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[4295871.493000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[4295871.493000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[4295871.493000] PM: Entering mem sleep
[4295871.493000] Intel machine check architecture supported.
[4295871.493000] Intel machine check reporting enabled on CPU#0.
[4295871.493000] Back to C!
[4295888.493000] PM: Finishing wakeup.
[4295888.509000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[4295888.509000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4295888.509000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[4295888.509000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4295888.509000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 209
[4295888.510000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4295888.510000] usb usb1: root hub lost power or was reset
[4295888.510000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 217
[4295888.510000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4295888.510000] usb usb2: root hub lost power or was reset
[4295888.510000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 225
[4295888.510000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4295888.510000] usb usb3: root hub lost power or was reset
[4295888.510000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
[4295888.510000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4295888.510000] usb usb4: root hub lost power or was reset
[4295888.511000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4295888.511000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 225
[4295888.522000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
[4295888.522000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4295888.522000] pnp: Failed to activate device 00:07.
[4295888.522000] pnp: Failed to activate device 00:08.
[4295918.686000] ata1: qc timeout (cmd 0xef)
[4295918.686000] ata1: failed to set xfermode, disabled
[4295918.686000] ata1: dev 0 configured for UDMA/100
[4295918.688000] Restarting tasks... done
[4295918.689000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295918.689000] end_request: I/O error, dev sda, sector 172682
[4295918.689000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295918.689000] end_request: I/O error, dev sda, sector 172690
[4295918.689000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295918.689000] end_request: I/O error, dev sda, sector 172698
[4295918.690000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295918.690000] end_request: I/O error, dev sda, sector 172706
[4295918.690000] Buffer I/O error on device sda2, logical block 1507
[4295918.690000] lost page write due to I/O error on sda2
[4295918.690000] Aborting journal on device sda2.
[4295918.713000] ACPI Error (evevent-0312): No installed handler for fixed event [00000002] [20060127]
[4295918.715000] ext3_abort called.
[4295918.715000] EXT3-fs error (device sda2): ext3_journal_start_sb: Detected aborted journal
[4295918.715000] Remounting filesystem read-only
[4295919.112000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295919.112000] end_request: I/O error, dev sda, sector 14594970
[4295919.112000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295919.112000] end_request: I/O error, dev sda, sector 14594970
[4295919.112000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295919.112000] end_request: I/O error, dev sda, sector 14594970

--Boundary-00=_5k5+DNIOgu3WwKN--
