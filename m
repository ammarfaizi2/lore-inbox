Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWBVAfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWBVAfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWBVAfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:35:05 -0500
Received: from HSI-KBW-082-212-034-022.hsi.kabelbw.de ([82.212.34.22]:27033
	"EHLO afrodita") by vger.kernel.org with ESMTP id S1422635AbWBVAfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:35:03 -0500
From: Ariel Garcia <garcia@iwr.fzk.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
Date: Wed, 22 Feb 2006 01:34:29 +0100
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200602191958.38219.garcia@iwr.fzk.de> <200602212350.33394.garcia@iwr.fzk.de> <Pine.LNX.4.58.0602211457430.8603@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602211457430.8603@shark.he.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VG7+DPRKb3riIt3"
Message-Id: <200602220134.29543.garcia@iwr.fzk.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_VG7+DPRKb3riIt3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again Randy,

wow, thanks for your ultra fast-patch ;-)

> > do_drive_get_GTF: ERR: ata_dev_present: 0, PORT_DISABLED: 0
> > ata_acpi_exec_tfs: get_GTF error (-19)
> > ata_acpi_exec_tfs: ret=-19
> >
> > but no extra debugging output after the suspend/restart. Does that
> > help? dmesg output attached.
>
> The "error" is only for the second drive (ix=1, which you don't have,
> right?).  I guess I need to disable that message.

oh, right, only one sata HD (pure SATA, not pata as far as i understand)

> Please add this additional patch (attached) (credit: SUSE) and
> let us know if it helps.  Meanwhile I will check the resume
> path to see if I notice anything that is missing.

done, attached the dmesg. All your new debugging lines appear.
This time i didn't care of unloading all unneded modules (like ipw2200, 
etc) and as you can notice there is a kind of funtion call backtrace 
regarding an unhandled interrupt just after call ata_exec_internal, that 
is interrupt 177 which is associated to vga+audio+usb+cardbus

This reminded me that once every 10 boots (approx, just to put a number), 
my laptop fails to initialize the HD when booting, the drive is detected 
but it doesn't respond and therefore the partition table cannot be read... 
(i find only sda in /proc/partitions)
When this happens, the root fs cannot be mounted (obviously), but i land in 
the initramfs: from there I can reproduce the error messages by removing 
and reloading either the ahci  or the ata_piix modules. I have to reboot 
to get the drive working again.
I saved the dmesg output when reloading the ahci module, it is attached 
(bootfail-log-ahci.txt)

Good night! Ariel

--Boundary-00=_VG7+DPRKb3riIt3
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

MEM window: disabled.
[4294668.180000]   PREFETCH window: disabled.
[4294668.180000] PCI: Bus 7, cardbus bridge: 0000:06:03.0
[4294668.180000]   IO window: 00002000-000020ff
[4294668.180000]   IO window: 00002400-000024ff
[4294668.181000]   PREFETCH window: 50000000-51ffffff
[4294668.181000]   MEM window: 54000000-55ffffff
[4294668.181000] PCI: Bridge: 0000:00:1e.0
[4294668.181000]   IO window: 2000-2fff
[4294668.181000]   MEM window: b0200000-b02fffff
[4294668.181000]   PREFETCH window: 50000000-51ffffff
[4294668.181000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[4294668.181000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4294668.181000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[4294668.181000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4294668.181000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4294668.181000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294668.181000] Simple Boot Flag at 0x7f set to 0x1
[4294668.182000] audit: initializing netlink socket (disabled)
[4294668.182000] audit(1140565679.180:1): initialized
[4294668.182000] Initializing Cryptographic API
[4294668.182000] io scheduler noop registered
[4294668.182000] io scheduler anticipatory registered (default)
[4294668.183000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[4294668.183000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4294668.183000] assign_interrupt_mode Found MSI capability
[4294668.183000] Allocate Port Service[0000:00:1c.0:pcie00]
[4294668.183000] Allocate Port Service[0000:00:1c.0:pcie02]
[4294668.183000] Allocate Port Service[0000:00:1c.0:pcie03]
[4294668.183000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[4294668.183000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4294668.183000] assign_interrupt_mode Found MSI capability
[4294668.183000] Allocate Port Service[0000:00:1c.1:pcie00]
[4294668.183000] Allocate Port Service[0000:00:1c.1:pcie02]
[4294668.183000] Allocate Port Service[0000:00:1c.1:pcie03]
[4294668.185000] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[4294668.187000] i8042.c: Detected active multiplexing controller, rev 1.1.
[4294668.190000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[4294668.190000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[4294668.190000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[4294668.191000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[4294668.191000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294668.191000] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[4294668.191000] STRIP: Version 1.3A-STUART.CHESHIRE (unlimited channels)
[4294668.192000] MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb 19 2006
[4294668.192000] NET: Registered protocol family 2
[4294668.202000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294668.202000] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[4294668.202000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294668.203000] TCP: Hash tables configured (established 131072 bind 65536)
[4294668.203000] TCP reno registered
[4294668.203000] TCP bic registered
[4294668.203000] NET: Registered protocol family 1
[4294668.203000] NET: Registered protocol family 17
[4294668.203000] NET: Registered protocol family 8
[4294668.203000] NET: Registered protocol family 20
[4294668.203000] Using IPI Shortcut mode
[4294668.203000] ACPI wakeup devices: 
[4294668.203000] PCIB MODM AZAL EXP1 EXP2  LID 
[4294668.204000] ACPI: (supports S0 S3 S4 S5)
[4294668.204000] Freeing unused kernel memory: 164k freed
[4294668.263000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294668.351000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294668.430000] usbcore: registered new driver usbfs
[4294668.430000] usbcore: registered new driver hub
[4294668.431000] USB Universal Host Controller Interface driver v2.3
[4294668.431000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 209
[4294668.431000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4294668.431000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[4294668.431000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[4294668.431000] uhci_hcd 0000:00:1d.0: irq 209, io base 0x00001420
[4294668.431000] usb usb1: configuration #1 chosen from 1 choice
[4294668.431000] hub 1-0:1.0: USB hub found
[4294668.431000] hub 1-0:1.0: 2 ports detected
[4294668.532000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 217
[4294668.532000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4294668.532000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[4294668.532000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[4294668.532000] uhci_hcd 0000:00:1d.1: irq 217, io base 0x00001440
[4294668.532000] usb usb2: configuration #1 chosen from 1 choice
[4294668.532000] hub 2-0:1.0: USB hub found
[4294668.532000] hub 2-0:1.0: 2 ports detected
[4294668.633000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 225
[4294668.633000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4294668.633000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[4294668.633000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[4294668.633000] uhci_hcd 0000:00:1d.2: irq 225, io base 0x00001460
[4294668.634000] usb usb3: configuration #1 chosen from 1 choice
[4294668.634000] hub 3-0:1.0: USB hub found
[4294668.634000] hub 3-0:1.0: 2 ports detected
[4294668.735000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
[4294668.735000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4294668.735000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[4294668.735000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[4294668.735000] uhci_hcd 0000:00:1d.3: irq 177, io base 0x00001480
[4294668.735000] usb usb4: configuration #1 chosen from 1 choice
[4294668.735000] hub 4-0:1.0: USB hub found
[4294668.735000] hub 4-0:1.0: 2 ports detected
[4294668.836000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 209
[4294668.836000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4294668.836000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[4294668.836000] ehci_hcd 0000:00:1d.7: debug port 1
[4294668.836000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[4294668.836000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[4294668.837000] ehci_hcd 0000:00:1d.7: irq 209, io mem 0xb0004000
[4294668.841000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4294668.841000] usb usb5: configuration #1 chosen from 1 choice
[4294668.841000] hub 5-0:1.0: USB hub found
[4294668.841000] hub 5-0:1.0: 8 ports detected
[4294668.925000] SCSI subsystem initialized
[4294668.928000] libata version 1.20 loaded.
[4294668.938000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294668.939000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294668.942000] tg3.c:v3.49 (Feb 2, 2006)
[4294668.942000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294668.942000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[4294668.965000] eth0: Tigon3 [partno(BCM95751m) rev 4201 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0b:5d:c7:47:ef
[4294668.966000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[4294668.966000] eth0: dma_rwctrl[76180000]
[4294668.986000] ahci 0000:00:1f.2: version 1.2
[4294668.986000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
[4294673.299000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294673.299000] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl SATA mode
[4294673.299000] ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part 
[4294673.299000] ata1: SATA max UDMA/133 cmd 0xF882E500 ctl 0x0 bmdma 0x0 irq 217
[4294673.299000] ata2: SATA max UDMA/133 cmd 0xF882E580 ctl 0x0 bmdma 0x0 irq 217
[4294673.299000] ata3: SATA max UDMA/133 cmd 0xF882E600 ctl 0x0 bmdma 0x0 irq 217
[4294673.299000] ata4: SATA max UDMA/133 cmd 0xF882E680 ctl 0x0 bmdma 0x0 irq 217
[4294673.501000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[4294673.501000] ata1: dev 0 cfg 00:045a 49:2f00 82:346b 83:7f09 84:6063 85:346b 86:bf09 87:6063 88:203f 93:0000
[4294673.501000] ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
[4294673.501000] ata_acpi_push_id: ap->id: 1, ix = 0, port#: 0, hard_port#: 0
[4294673.501000] sata_get_dev_handle: SATA dev addr=0x1f0002, handle=0xc17dff40
[4294673.505000] :\_SB_.PCI0.SATA: matches pcidevfn (0x1f0002)
[4294673.505000] GOT ONE: (\_SB_.PCI0.SATA.PRT0) root_port = 0x0, port_num = 0xffff
[4294673.505000] THIS ^^^^^ is the requested SATA drive (handle = 0xc17d64e0)
[4294673.505000] GOT ONE: (\_SB_.PCI0.SATA.PRT2) root_port = 0x2, port_num = 0xffff
[4294673.508000] ata1: dev 0 configured for UDMA/100
[4294673.508000] ata_acpi_exec_tfs: ENTER:
[4294673.508000] ata_acpi_exec_tfs: call get_GTF, ix=0
[4294673.508000] do_drive_get_GTF: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4294673.508000] sata_get_dev_handle: SATA dev addr=0x1f0002, handle=0xc17dff40
[4294673.508000] do_drive_get_GTF: returning gtf_length=14, gtf_address=0xf7437330, obj_loc=0xf7437320
[4294673.508000] ata_acpi_exec_tfs: call set_taskfiles, ix=0
[4294673.508000] do_drive_set_taskfiles: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4294673.508000] do_drive_set_taskfiles: total GTF bytes=14 (0xe), gtf_count=2, addr=0xf7437330
[4294673.508000] taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 00 00 a0 ef
[4294673.508000] call ata_exec_internal:
[4294673.510000] taskfile_load_raw: (0x1f1-1f7): hex: 00 00 00 00 00 a0 f5
[4294673.510000] call ata_exec_internal:
[4294673.510000] ata_acpi_exec_tfs: call get_GTF, ix=1
[4294673.510000] do_drive_get_GTF: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4294673.510000] do_drive_get_GTF: ERR: ata_dev_present: 0, PORT_DISABLED: 0
[4294673.510000] ata_acpi_exec_tfs: get_GTF error (-19)
[4294673.510000] ata_acpi_exec_tfs: ret=-19
[4294673.510000] scsi0 : ahci
[4294673.712000] ata2: SATA link down (SStatus 0)
[4294673.712000] scsi1 : ahci
[4294673.914000] ata3: SATA link down (SStatus 0)
[4294673.914000] scsi2 : ahci
[4294674.116000] ata4: SATA link down (SStatus 0)
[4294674.116000] scsi3 : ahci
[4294674.116000]   Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 0000
[4294674.117000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294674.117000] ata_acpi_get_timing: ENTER:
[4294674.117000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.117000] ata_acpi_get_timing: ENTER:
[4294674.117000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.117000] ata_acpi_get_timing: ENTER:
[4294674.117000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.117000] ata_acpi_get_timing: ENTER:
[4294674.117000] ata_acpi_get_timing: channel/controller not in legacy mode (0000:00:1f.2)
[4294674.120000] ICH6: IDE controller at PCI slot 0000:00:1f.1
[4294674.120000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 225
[4294674.120000] ICH6: chipset revision 4
[4294674.120000] ICH6: not 100% native mode: will probe irqs later
[4294674.121000]     ide0: BM-DMA at 0x1410-0x1417, BIOS settings: hda:DMA, hdb:pio
[4294674.121000] Probing IDE interface ide0...
[4294674.154000] Driver 'sd' needs updating - please use bus_type methods
[4294674.155000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294674.155000] sda: Write Protect is off
[4294674.155000] sda: Mode Sense: 00 3a 00 10
[4294674.156000] SCSI device sda: drive cache: write back w/ FUA
[4294674.156000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294674.156000] sda: Write Protect is off
[4294674.156000] sda: Mode Sense: 00 3a 00 10
[4294674.157000] SCSI device sda: drive cache: write back w/ FUA
[4294674.157000]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[4294674.277000] sd 0:0:0:0: Attached scsi disk sda
[4294674.793000] hda: MATSHITAUJ-841Db, ATAPI CD/DVD-ROM drive
[4294675.099000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294675.109000] hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294675.110000] Uniform CD-ROM driver Revision: 3.20
[4294675.726000] Probing IDE interface ide1...
[4294676.327000] Attempting manual resume
[4294676.328000] swsusp: Resume From Partition 8:6
[4294676.328000] PM: Checking swsusp image.
[4294676.328000] PM: Resume from disk failed.
[4294676.353000] EXT3-fs: mounted filesystem with ordered data mode.
[4294676.387000] kjournald starting.  Commit interval 5 seconds
[4294678.352000] hw_random: RNG not detected
[4294678.354000] Linux agpgart interface v0.101 (c) Dave Jones
[4294678.355000] agpgart: Detected an Intel 915GM Chipset.
[4294678.356000] agpgart: Detected 7932K stolen memory.
[4294678.373000] agpgart: AGP aperture is 256M @ 0xc0000000
[4294678.441000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294678.441000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[4294678.615000] Real Time Clock Driver v1.12ac
[4294678.881000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 177
[4294678.881000] Yenta: CardBus bridge found at 0000:06:03.0 [10cf:131e]
[4294679.009000] Yenta: ISA IRQ mask 0x0cb8, PCI irq 177
[4294679.009000] Socket status: 30000006
[4294679.009000] pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
[4294679.009000] pcmcia: parent PCI bridge Memory window: 0xb0200000 - 0xb02fffff
[4294679.009000] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
[4294679.040000] ieee80211_crypt: registered algorithm 'NULL'
[4294679.051000] ieee80211: 802.11 data/management/control stack, git-1.1.7
[4294679.051000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[4294679.093000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
[4294679.093000] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[4294679.093000] ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 18 (level, low) -> IRQ 225
[4294679.094000] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[4294679.600000] Synaptics Touchpad, model: 1, fw: 5.9, id: 0xf8eb1, caps: 0xa04793/0x102000
[4294679.600000] serio: Synaptics pass-through port at isa0060/serio4/input0
[4294679.642000] input: SynPS/2 Synaptics TouchPad as /class/input/input1
[4294679.662000] input: PC Speaker as /class/input/input2
[4294679.676000] ipw2200: Radio Frequency Kill Switch is On:
[4294679.676000] Kill switch must be turned off for wireless networking to work.
[4294683.782000] Adding 1012052k swap on /dev/sda6.  Priority:-1 extents:1 across:1012052k
[4294683.806000] input: PS/2 Generic Mouse as /class/input/input3
[4294683.919000] EXT3 FS on sda2, internal journal
[4294687.325000] mice: PS/2 mouse device common for all mice
[4294688.118000] kjournald starting.  Commit interval 5 seconds
[4294688.119000] EXT3 FS on sda1, internal journal
[4294688.119000] EXT3-fs: mounted filesystem with ordered data mode.
[4294688.120000] kjournald starting.  Commit interval 5 seconds
[4294688.120000] EXT3 FS on sda5, internal journal
[4294688.121000] EXT3-fs: mounted filesystem with ordered data mode.
[4294688.122000] kjournald starting.  Commit interval 5 seconds
[4294688.122000] EXT3 FS on sda3, internal journal
[4294688.123000] EXT3-fs: mounted filesystem with ordered data mode.


[4295277.877000] PM: Preparing system for mem sleep
[4295277.878000] Stopping tasks: ================|
[4295277.880000] ata1: suspend device
[4295278.897000] eth1: Going into suspend...
[4295278.897000] ACPI: PCI interrupt for device 0000:06:05.0 disabled
[4295278.908000] ACPI: PCI interrupt for device 0000:06:03.0 disabled
[4295279.233000] ahci 0000:00:1f.2: suspend PCI device
[4295279.233000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[4295279.244000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[4295279.255000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[4295279.255000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[4295279.255000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[4295279.255000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[4295279.255000] PM: Entering mem sleep
[4295279.255000] Intel machine check architecture supported.
[4295279.255000] Intel machine check reporting enabled on CPU#0.
[4295279.255000] Back to C!
[4295299.255000] irqrouter_resume: ENTER
[4295299.255000] irqrouter_resume: EXIT
[4295299.255000] PM: Finishing wakeup.
[4295299.295000] ipw2200: Unable to load ucode: -22
[4295299.296000] ipw2200: Unable to load firmware: -22
[4295299.296000] ipw2200: Failed to up device
[4295299.311000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[4295299.312000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4295299.312000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 177
[4295299.312000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4295299.312000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 209
[4295299.312000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4295299.312000] usb usb1: root hub lost power or was reset
[4295299.312000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 217
[4295299.312000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4295299.312000] usb usb2: root hub lost power or was reset
[4295299.312000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 225
[4295299.313000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4295299.313000] usb usb3: root hub lost power or was reset
[4295299.313000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
[4295299.313000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4295299.313000] usb usb4: root hub lost power or was reset
[4295299.324000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 209
[4295299.324000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4295299.324000] usb usb5: root hub lost power or was reset
[4295299.328000] ehci_hcd 0000:00:1d.7: debug port 1
[4295299.328000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[4295299.332000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4295299.332000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4295299.332000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 225
[4295299.332000] ahci 0000:00:1f.2: resume PCI device
[4295299.343000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
[4295299.343000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4295299.523000] tg3: eth0: Link is down.
[4295299.524000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 177
[4295299.556000] eth1: Coming out of suspend...
[4295299.567000] PCI: Enabling device 0000:06:05.0 (0000 -> 0002)
[4295299.567000] ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 18 (level, low) -> IRQ 225
[4295299.567000] pnp: Failed to activate device 00:07.
[4295299.567000] pnp: Failed to activate device 00:08.
[4295300.327000] ata1: resume device
[4295300.327000] ata_acpi_exec_tfs: ENTER:
[4295300.327000] ata_acpi_exec_tfs: call get_GTF, ix=0
[4295300.327000] do_drive_get_GTF: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4295300.327000] sata_get_dev_handle: SATA dev addr=0x1f0002, handle=0xc17dff40
[4295300.327000] do_drive_get_GTF: returning gtf_length=14, gtf_address=0xf7edd1f0, obj_loc=0xf7edd1e0
[4295300.327000] ata_acpi_exec_tfs: call set_taskfiles, ix=0
[4295300.327000] do_drive_set_taskfiles: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4295300.327000] do_drive_set_taskfiles: total GTF bytes=14 (0xe), gtf_count=2, addr=0xf7edd1f0
[4295300.327000] taskfile_load_raw: (0x1f1-1f7): hex: 10 03 00 00 00 a0 ef
[4295300.327000] call ata_exec_internal:
[4295306.235000] irq 177: nobody cared (try booting with the "irqpoll" option)
[4295306.235000]  [<c013fbc4>] __report_bad_irq+0x24/0x90
[4295306.235000]  [<c013fcaf>] note_interrupt+0x7f/0x290
[4295306.235000]  [<c013f503>] handle_IRQ_event+0x33/0x70
[4295306.235000]  [<c013f622>] __do_IRQ+0xe2/0x110
[4295306.235000]  [<c0105893>] do_IRQ+0x23/0x40
[4295306.235000]  [<c0103a5a>] common_interrupt+0x1a/0x20
[4295306.235000]  [<f883621a>] acpi_processor_idle+0x1e1/0x31f [processor]
[4295306.235000]  [<c0101d14>] cpu_idle+0x44/0x70
[4295306.235000]  [<c0320493>] start_kernel+0x263/0x300
[4295306.235000]  [<c0320530>] unknown_bootoption+0x0/0x270
[4295306.235000] handlers:
[4295306.235000] [<f886d170>] (usb_hcd_irq+0x0/0x60 [usbcore])
[4295306.235000] [<f89bd7e0>] (yenta_interrupt+0x0/0xc0 [yenta_socket])
[4295306.235000] Disabling IRQ #177
[4295309.567000] ipw2200: ipw-2.4-boot.fw load failed: Reason -2
[4295309.567000] ipw2200: Unable to load firmware: -2
[4295330.327000] ata1: qc timeout (cmd 0xef)
[4295330.327000] taskfile_load_raw: ata_exec_internal failed: 1
[4295330.327000] taskfile_load_raw: (0x1f1-1f7): hex: 00 00 00 00 00 a0 f5
[4295330.327000] call ata_exec_internal:
[4295360.327000] ata1: qc timeout (cmd 0xf5)
[4295360.327000] taskfile_load_raw: ata_exec_internal failed: 1
[4295360.327000] ata_acpi_exec_tfs: call get_GTF, ix=1
[4295360.327000] do_drive_get_GTF: ENTER: ap->id: 1, port#: 0, hard_port#: 0
[4295360.327000] do_drive_get_GTF: ERR: ata_dev_present: 0, PORT_DISABLED: 0
[4295360.327000] ata_acpi_exec_tfs: get_GTF error (-19)
[4295360.327000] ata_acpi_exec_tfs: ret=-19
[4295390.327000] ata1: qc timeout (cmd 0xef)
[4295390.327000] ata1: failed to set xfermode, disabled
[4295390.327000] ata1: dev 0 configured for UDMA/100
[4295394.560000] Restarting tasks... done
[4295394.562000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.562000] end_request: I/O error, dev sda, sector 170082
[4295394.562000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.562000] end_request: I/O error, dev sda, sector 170090
[4295394.562000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.562000] end_request: I/O error, dev sda, sector 170098
[4295394.563000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.563000] end_request: I/O error, dev sda, sector 170106
[4295394.563000] Buffer I/O error on device sda2, logical block 1182
[4295394.563000] lost page write due to I/O error on sda2
[4295394.563000] Aborting journal on device sda2.
[4295394.583000] ACPI Error (evevent-0312): No installed handler for fixed event [00000002] [20060127]
[4295394.586000] ext3_abort called.
[4295394.586000] EXT3-fs error (device sda2): ext3_journal_start_sb: Detected aborted journal
[4295394.586000] Remounting filesystem read-only
[4295394.982000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.982000] end_request: I/O error, dev sda, sector 14594970
[4295394.983000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.983000] end_request: I/O error, dev sda, sector 14594970
[4295394.983000] sd 0:0:0:0: SCSI error: return code = 0x40000
[4295394.983000] end_request: I/O error, dev sda, sector 14594970

--Boundary-00=_VG7+DPRKb3riIt3
Content-Type: text/plain;
  charset="utf-8";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12d7
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04) (prog-if 00 [VGA])
	Subsystem: Fujitsu Limited.: Unknown device 12de
	Flags: bus master, fast devsel, latency 0, IRQ 177
	Memory at b0080000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1400 [size=8]
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Memory at b0040000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [d0] Power Management version 2

0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12de
	Flags: fast devsel
	Memory at 52000000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: [d0] Power Management version 2

0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 1326
	Flags: bus master, fast devsel, latency 0, IRQ 177
	Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: b0100000-b01fffff
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Flags: bus master, medium devsel, latency 0, IRQ 209
	I/O ports at 1420 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Flags: bus master, medium devsel, latency 0, IRQ 217
	I/O ports at 1440 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Flags: bus master, medium devsel, latency 0, IRQ 225
	I/O ports at 1460 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at 1480 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e9
	Flags: bus master, medium devsel, latency 0, IRQ 209
	Memory at b0004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b0200000-b02fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12e4
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Fujitsu Limited.: Unknown device 12e5
	Flags: bus master, medium devsel, latency 0, IRQ 225
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1410 [size=16]

0000:00:1f.2 0106: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04) (prog-if 01)
	Subsystem: Fujitsu Limited.: Unknown device 12e6
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 217
	I/O ports at 14b8 [size=8]
	I/O ports at 140c [size=4]
	I/O ports at 14b0 [size=8]
	I/O ports at 1408 [size=4]
	I/O ports at 14a0 [size=16]
	Memory at b0004400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12e7
	Flags: medium devsel, IRQ 11
	I/O ports at 14c0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 21)
	Subsystem: Fujitsu Limited.: Unknown device 1300
	Flags: bus master, fast devsel, latency 0, IRQ 233
	Memory at b0100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable+
	Capabilities: [d0] #10 [0001]

0000:06:03.0 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller (rev 20)
	Subsystem: Fujitsu Limited.: Unknown device 131e
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 177
	Memory at b0206000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 54000000-55fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	16-bit legacy interface ports at 0001

0000:06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2702
	Flags: bus master, medium devsel, latency 32, IRQ 225
	Memory at b0204000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

0000:06:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Fujitsu Limited.: Unknown device 1162
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at b0205000 (32-bit, non-prefetchable) [size=2K]
	Memory at b0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2


--Boundary-00=_VG7+DPRKb3riIt3
Content-Type: text/plain;
  charset="utf-8";
  name="bootfail-log-ahci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bootfail-log-ahci.txt"

[4295868.027000] ahci 0000:00:1f.2: version 1.2
[4295868.027000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
[4295872.339000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4295872.339000] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl SATA mode
[4295872.339000] ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part 
[4295872.339000] ata11: SATA max UDMA/133 cmd 0xF8860500 ctl 0x0 bmdma 0x0 irq 217
[4295872.339000] ata12: SATA max UDMA/133 cmd 0xF8860580 ctl 0x0 bmdma 0x0 irq 217
[4295872.339000] ata13: SATA max UDMA/133 cmd 0xF8860600 ctl 0x0 bmdma 0x0 irq 217
[4295872.339000] ata14: SATA max UDMA/133 cmd 0xF8860680 ctl 0x0 bmdma 0x0 irq 217
[4295872.541000] ata11: SATA link up 1.5 Gbps (SStatus 113)
[4295872.541000] ata11: dev 0 cfg 49:2f00 82:346b 83:7f09 84:6063 85:346b 86:bf09 87:6063 88:203f
[4295872.541000] ata11: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
[4295872.543000] ata11: dev 0 configured for UDMA/100
[4295872.543000] scsi16 : ahci
[4295872.746000] ata12: SATA link down (SStatus 0)
[4295872.746000] scsi17 : ahci
[4295872.948000] ata13: SATA link down (SStatus 0)
[4295872.948000] scsi18 : ahci
[4295873.150000] ata14: SATA link down (SStatus 0)
[4295873.150000] scsi19 : ahci
[4295873.161000]   Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 0000
[4295873.162000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4295873.163000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4295873.163000] sda: Write Protect is off
[4295873.163000] sda: Mode Sense: 00 3a 00 10
[4295873.163000] SCSI device sda: drive cache: write back w/ FUA
[4295873.163000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4295873.163000] sda: Write Protect is off
[4295873.163000] sda: Mode Sense: 00 3a 00 10
[4295873.163000] SCSI device sda: drive cache: write back w/ FUA
[4295873.163000]  sda:<4>ata11: port reset, p_is 40000001 is 1 pis 0 cmd 4017 tf 451 ss 113 se 0
[4295873.164000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.164000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.164000] ata11: error=0x04 { DriveStatusError }
[4295873.164000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.164000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.164000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.164000] ata11: error=0x04 { DriveStatusError }
[4295873.165000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.165000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.165000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.165000] ata11: error=0x04 { DriveStatusError }
[4295873.166000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.166000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.166000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.166000] ata11: error=0x04 { DriveStatusError }
[4295873.167000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.167000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.167000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.167000] ata11: error=0x04 { DriveStatusError }
[4295873.168000] sd 16:0:0:0: SCSI error: return code = 0x8000002
[4295873.168000] sda: Current: sense key: Aborted Command
[4295873.168000]     Additional sense: No additional sense information
[4295873.168000] end_request: I/O error, dev sda, sector 0
[4295873.168000] Buffer I/O error on device sda, logical block 0
[4295873.168000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.168000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.168000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.168000] ata11: error=0x04 { DriveStatusError }
[4295873.169000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.169000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.169000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.169000] ata11: error=0x04 { DriveStatusError }
[4295873.170000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.170000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.170000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.170000] ata11: error=0x04 { DriveStatusError }
[4295873.171000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.171000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.171000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.171000] ata11: error=0x04 { DriveStatusError }
[4295873.172000] ata11: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 451 ss 113 se 0
[4295873.172000] ata11: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
[4295873.172000] ata11: status=0x51 { DriveReady SeekComplete Error }
[4295873.172000] ata11: error=0x04 { DriveStatusError }
[4295873.173000] sd 16:0:0:0: SCSI error: return code = 0x8000002
[4295873.173000] sda: Current: sense key: Aborted Command
[4295873.173000]     Additional sense: No additional sense information
[4295873.174000] end_request: I/O error, dev sda, sector 0
[4295873.174000] Buffer I/O error on device sda, logical block 0
[4295873.174000]  unable to read partition table
[4295873.174000] sd 16:0:0:0: Attached scsi disk sda

--Boundary-00=_VG7+DPRKb3riIt3--
