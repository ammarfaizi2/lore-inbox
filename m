Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWCCSjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWCCSjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWCCSjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:39:43 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:3270 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161019AbWCCSjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:39:42 -0500
Date: Fri, 3 Mar 2006 18:39:37 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATA failure with piix, works with libata
Message-ID: <20060303183937.GA30840@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm playing with an Intel Mac. Pretty much everything works to some 
extent (though it seems very unhappy with MSI), but I'm having some 
trouble with the built-in PATA controller. Using ata_piix (with PATA 
mode enabled), I get the following:

[4294851.590000] ata_piix 0000:00:1f.1: version 1.05
[4294851.590000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
[4294851.590000] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[4294851.590000] ata7: PATA max UDMA/100 cmd 0x30E8 ctl 0x30FE bmdma 0x30C0 irq 201
[4294851.590000] ata8: PATA max UDMA/100 cmd 0x30E0 ctl 0x30FA bmdma 0x30C8 irq 201
[4294851.898000] ata7: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
[4294851.898000] ata7: dev 0 ATAPI, max UDMA/66
[4294851.898000] ata7: dev 0 configured for UDMA/66
[4294851.898000] scsi7 : ata_piix
[4294852.057000] ATA: abnormal status 0x7F on port 0x30E7
[4294852.057000] ata8: disabling port
[4294852.058000] scsi8 : ata_piix
[4294852.062000]   Vendor: MATSHITA  Model: DVD-R   UJ-846    Rev: FB2U
[4294852.062000]   Type:   CD-ROM                             ANSI SCSI revision: 05
[4294852.094000] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[4294852.094000] sr 7:0:0:0: Attached scsi CD-ROM sr0
[4294852.094000] sr 7:0:0:0: Attached scsi generic sg2 type 5

and everything is fine, including CD access. Loading piix gives me the 
following:

[4294929.054000] ICH7: IDE controller at PCI slot 0000:00:1f.1
[4294929.054000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
[4294929.054000] ICH7: chipset revision 2
[4294929.054000] ICH7: 100% native mode on irq 201
[4294929.054000] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[4294929.054000]     ide0: BM-DMA at 0x30c0-0x30c7, BIOS settings: hda:DMA, hdb:pio
[4294929.054000]     ide1: BM-DMA at 0x30c8-0x30cf, BIOS settings: hdc:pio, hdd:pio
[4294929.054000] Probing IDE interface ide0...
[4294929.722000] hda: MATSHITADVD-R UJ-846, ATAPI CD/DVD-ROM drive
[4294930.057000] ide0 at 0x30e8-0x30ef,0x30fe on irq 201
[4294930.057000] Probing IDE interface ide1...

which seems ok. However, loading ide-cd gives:

[4294983.732000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.732000] ide: failed opcode was: unknown
[4294983.732000] hda: drive not ready for command
[4294983.735000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.735000] ide: failed opcode was: unknown
[4294983.735000] hda: drive not ready for command
[4294983.738000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.738000] ide: failed opcode was: unknown
[4294983.738000] hda: drive not ready for command
[4294983.741000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.741000] ide: failed opcode was: unknown
[4294983.741000] hda: DMA disabled
[4294983.741000] hda: drive not ready for command
[4294983.791000] hda: ATAPI reset complete
[4294983.793000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.793000] ide: failed opcode was: unknown
[4294983.793000] hda: drive not ready for command
[4294983.796000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.796000] ide: failed opcode was: unknown
[4294983.796000] hda: drive not ready for command
[4294983.799000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.799000] ide: failed opcode was: unknown
[4294983.799000] hda: drive not ready for command
[4294983.802000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.802000] ide: failed opcode was: unknown
[4294983.802000] hda: drive not ready for command
[4294983.852000] hda: ATAPI reset complete
[4294983.852000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.852000] ide: failed opcode was: unknown
[4294983.852000] hda: drive not ready for command
[4294983.852000] hda: ATAPI CD-ROM drive, 0kB Cache
[4294983.853000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
[4294983.853000] ide: failed opcode was: unknown
[4294983.853000] hda: drive not ready for command

and insmod never returns. After this, the IDE interrupt is firing about 
80000 times a second. This is 2.6.15 - nothing jumps out at me in the 
changes since then. Anyone have any ideas? I'm not entirely convinced 
that interrupts are being set up correctly on this hardware, but it 
works fine with ata_piix...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
