Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268050AbUHQAwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268050AbUHQAwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUHQAwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:52:49 -0400
Received: from tim.plush.org ([168.150.236.223]:28633 "EHLO tim.plush.org")
	by vger.kernel.org with ESMTP id S268050AbUHQAwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:52:22 -0400
Date: Mon, 16 Aug 2004 17:52:18 -0700
From: Gabriel Rosa <grosa@plush.org>
To: linux-kernel@vger.kernel.org
Subject: ich6r/ich6w and ata_piix, hidden drive
Message-ID: <20040817005218.GA22778@foo.plush.org>
Mail-Followup-To: Gabriel Rosa <grosa@plush.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I have an interesting situation with a Dell XPS system (actually 6 of them)
with Intel ICH6 SATA controllers running kernel 2.6.7.

the setup is as follows (as seen by the bios):

sata-0 250gb drive
sata-1 empty
sata-2 250gb drive
sata-3 empty
pata-0 cdrom
pata-1 empty

this particular bios has 4 settings:

AHCI, SATA, Raid (bios software raid), Combination (SATA/PATA)

in AHCI or Raid mode, no drives are detected. This is unusual, because I
thought the ata_piix driver was supposed to handle AHCI (ie, enhanced) mode
fully.

in SATA mode, only sata-0 is detected.

in SATA/PATA mode, both drives are handled by the ide subsystem, with abysmal
performance (~6.0 MB/sec with hdparm -t)

I am particularly interested in making AHCI mode work, but would be fairly
happy with SATA mode (excellent performance, now if only the second drive 
showed up). Any ideas?

here are some relevant lines:

lspci:
0000:00:1f.2 IDE interface: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03)

dmesg:
SCSI subsystem initialized
libata version 1.02 loaded.
ata_piix version 1.02
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 20
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 20
ata1: dev 0 cfg 49:2f00 82:3469 83:7f61 84:4003 85:3469 86:3e41 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 488281250 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
Using anticipatory io scheduler
  Vendor: ATA       Model: WDC WD2500JD-75H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3

I'd be happy to provide more details.

thanks,
-Gabe
