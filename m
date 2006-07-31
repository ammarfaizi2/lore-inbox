Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWGaPY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWGaPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGaPY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:24:58 -0400
Received: from smtp.ono.com ([62.42.230.12]:13486 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932421AbWGaPY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:24:57 -0400
Date: Mon, 31 Jul 2006 17:24:52 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Tejun Heo <htejun@gmail.com>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Message-ID: <20060731172452.76a1b6bd@werewolf.auna.net>
In-Reply-To: <44CD0E55.4020206@gmail.com>
References: <20060728134550.030a0eb8@werewolf.auna.net>
	<44CD0E55.4020206@gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 04:53:57 +0900, Tejun Heo <htejun@gmail.com> wrote:

> J.A. Magallón wrote:
> > Hi...
> > 
> > I've been out for more than a week. Just went to try -rc2-mm1 and
> > it ate one ide channel...
> > 
> > This was -rc1-mm2:
> > libata version 2.00 loaded.
> > ata_piix 0000:00:1f.1: version 2.00ac6
> > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1f.1 to 64
> > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> > scsi0 : ata_piix
> > ata1.00: ATAPI, max UDMA/33
> > ata1.01: ATAPI, max MWDMA0, CDB intr
> > ata1.00: configured for PIO3
> > ata1.01: configured for PIO3
> >   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
> >   Type:   CD-ROM                             ANSI SCSI revision: 05
> >   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> > scsi1 : ata_piix
> > ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
> > ata2.00: ata2: dev 0 multi count 16
> > ata2.01: ATAPI, max UDMA/33
> > ata2.00: configured for UDMA/33
> > ata2.01: configured for UDMA/33
> >   Vendor: ATA       Model: ST3120022A        Rev: 3.06
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> >   Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
> >   Type:   CD-ROM                             ANSI SCSI revision: 05
> > ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> > ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1f.2 to 64
> > ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > 
> > 
> > This is -rc2-mm1, a PATA channel is missing...
> > 
> > libata version 2.00 loaded.
> > ata_piix 0000:00:1f.1: version 2.00ac6
> > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1f.1 to 64
> > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> > scsi0 : ata_piix
> > ata1.00: ATAPI, max UDMA/33 
> > ata1.01: ATAPI, max MWDMA0, CDB intr
> > ata1.00: configured for UDMA/33
> > ata1.01: configured for PIO3
> >   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111 
> >   Type:   CD-ROM                             ANSI SCSI revision: 05
> >   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G 
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ] 
> > ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1f.2 to 64
> > ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > ata3: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > 
> > Any idea ?
> > Any more info needed ?
> 
> lspci -n please

werewolf:~> lspci
00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller (rev 02)
00:03.0 PCI bridge: Intel Corporation 82875P/E7210 Processor to PCI to CSA Bridge (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600/GeForce 6600 GT] (rev a2)
02:01.0 Ethernet controller: Intel Corporation 82547EI Gigabit Ethernet Controller (LOM)
03:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 378/SATA 378) (rev 02)
03:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
03:0a.1 Input device controller: Creative Labs SB Live! Game Port (rev 06)
03:0b.0 Ethernet controller: 3Com Corporation 3c980-C 10/100baseTX NIC [Python-T] (rev 78)
03:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
03:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
werewolf:~> lspci -n
00:00.0 0600: 8086:2578 (rev 02)
00:01.0 0604: 8086:2579 (rev 02)
00:03.0 0604: 8086:257b (rev 02)
00:1d.0 0c03: 8086:24d2 (rev 02)
00:1d.1 0c03: 8086:24d4 (rev 02)
00:1d.2 0c03: 8086:24d7 (rev 02)
00:1d.3 0c03: 8086:24de (rev 02)
00:1d.7 0c03: 8086:24dd (rev 02)
00:1e.0 0604: 8086:244e (rev c2)
00:1f.0 0601: 8086:24d0 (rev 02)
00:1f.1 0101: 8086:24db (rev 02)
00:1f.2 0101: 8086:24d1 (rev 02)
00:1f.3 0c05: 8086:24d3 (rev 02)
00:1f.5 0401: 8086:24d5 (rev 02)
01:00.0 0300: 10de:00f1 (rev a2)
02:01.0 0200: 8086:1019
03:03.0 0c00: 104c:8023
03:04.0 0104: 105a:3373 (rev 02)
03:0a.0 0401: 1102:0002 (rev 06)
03:0a.1 0980: 1102:7002 (rev 06)
03:0b.0 0200: 10b7:9805 (rev 78)
03:0c.0 0400: 109e:036e (rev 11)
03:0c.1 0480: 109e:0878 (rev 11)

> Also, can you report what the kernel says with the 
> attached patch applied?
> 

I reworked it to look like this:

    if (legacy_mode) {
        probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
        dev_printk(KERN_INFO, &pdev->dev,
           "XXX: legacy_mode probe_ent=%p\n", probe_ent);
    } else {
        if (n_ports == 2)
            probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
        else
            probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
        dev_printk(KERN_INFO, &pdev->dev,
           "XXX: non_legacy_mode n_ports=%d probe_ent=%p\n",n_ports,probe_ent);
    }

and got:

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
ata_piix 0000:00:1f.1: XXX: legacy_mode probe_ent=f7935c00     <=====================
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for UDMA/33
ata1.01: configured for PIO3
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
ata_piix 0000:00:1f.2: XXX: non_legacy_mode n_ports=2 probe_ent=f7935c00 <====================
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata3: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi1 : ata_piix
ata2.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : ata_piix
ata3: SATA port has no device.
ATA: abnormal status 0x7F on port 0xC807
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_promise 0000:03:04.0: version 1.04
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 17
sata_promise PATA port found
ata4: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 17
ata5: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 17
ata6: PATA max UDMA/133 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 17

I checked the BIOS and ICH is in 'Enhanced' mode, so both pata and both sata
channels are usable for a max of 6 drives.

Any ideas ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam04 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
