Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTIMWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbTIMWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:01:25 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:26635 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262227AbTIMWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:01:22 -0400
Date: Sun, 14 Sep 2003 00:01:21 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre4 ide-scsi irq timeout
Message-ID: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have been using 2.4.23-pre3 without any problems, but when I booted
2.4.23-pre4 ide-scsi (bound to hdc) could not initialize the cdrom
drive. 

Here is the relevant part of the boot.msg for the bad start:
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4021GAS, ATA DISK drive
blk: queue c039b260, I/O limit 4095Mb (mask 0xffffffff)
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=4864/255/63, UDMA(100)
hdc: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x12 00 00 00 ff 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
scsi : aborting command due to timeout : pid 1, scsi0, channel 0, id 0, lun 0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 1) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 1) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
scsi : aborting command due to timeout : pid 2, scsi0, channel 0, id 0, lun 0 0x12 00 00 00 ff 00 
SCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 2) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }


while for a good boot with 2.4.23-pre3 we have
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4021GAS, ATA DISK drive
blk: queue c039b280, I/O limit 4095Mb (mask 0xffffffff)
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=4864/255/63, UDMA(100)
hdc: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: QSI       Model: CDRW/DVD SBW-242  Rev: UX08
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 4x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12


I only have patched in cpufreq, nothing else, and I am running
debian/sid.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
QUABBS (pl.n.)
The substances which emerge when you squeeze a blackhead.
			--- Douglas Adams, The Meaning of Liff
