Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271367AbTHDDru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 23:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTHDDru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 23:47:50 -0400
Received: from mail.egps.com ([38.119.130.6]:777 "EHLO egps.com")
	by vger.kernel.org with ESMTP id S271367AbTHDDrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 23:47:48 -0400
Date: Sun, 3 Aug 2003 23:47:06 -0400
From: Nachman Yaakov Ziskind <awacs@egps.com>
To: linux-kernel@vger.kernel.org
Subject: DVD-RAM errors (was: DVD-RAM crashing system)
Message-ID: <20030803234706.A13048@egps.egps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was my original problem:

>    ... bought a Dell Poweredge 600 box with RH 7.3 (2.4.18-4 #1) pre-
>    installed, and SCSI hard disks. Added a Matsushita DVD-RAM LF-D311 atapi 
>    dvd->ram (that, along with a cd-rom, are the only IDE devices).

>    Now, when I do a full backup (as opposed to a differential; I'm using
>    Microlite's BackupEdge, a Super-Tar), the machine (sometimes) hangs with
>    the error message:

>    "Serverworks OSB4 in impossible state. Disable UDMA or if you are using 
>    Seagate then try switching disk types on this controller. Please report 
>    this event to osb4-bug@ide.cabal.tm OSB4: continuing might cause disk 
>    corruption."

This was Mr. Cox's solution:

>    Update to 2.4.20. That will put IDE disks into MWDMA2 on the Serverworks
>    OSB4 and avoid the mistrigger with CD-ROM errors. The later serverworks
>    (CSB5, CSB6) is fine btw but can hit the CD-ROM mistrigger too

So, now, I'm using kernel 2.4.20-19.7 #1, and my backups no longer work. :-(
(BackupEdge is essentially a pretty front end to tar, and) [w]hen I issue a
command like 'tar cvf /dev/scd0 my-files', the machine hangs for a couple of
seconds, writes nothing to DVD, and I get these errors:

Aug  3 13:40:08 gemach kernel: Current sd0b:00: sense key Data Protect
Aug  3 13:40:08 gemach kernel:  I/O error: dev 0b:00, sector 4
Aug  3 13:40:08 gemach kernel: SCSI cdrom error : host 2 channel 0 id 0 lun 0
return code = 28000000

Some interesting messages:

Kernel command line: ro root=/dev/sda9 hda=ide-scsi ide=nodma
ide_setup: hda=ide-scsi
ide_setup: ide=nodma : Prevented DMA
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB6: IDE controller at PCI slot 00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:pio
hda: MATSHITADVD-RAM LF-D311, ATAPI CD/DVD-ROM drive
hdc: GCR-8481B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-cdrom driver.
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hda: attached ide-scsi driver.
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: DVD-RAM LF-D311   Rev: A123
  Type:   CD-ROM                             ANSI SCSI revision: 02
hda: DMA disabled
hdc: DMA disabled
hdc: DMA disabled

I throw myself upon the mercy of the NG. :-)

-- 
_________________________________________
Nachman Yaakov Ziskind, EA, LLM         awacs@egps.com
Attorney and Counselor-at-Law           http://yankel.com
Economic Group Pension Services         http://egps.com
Actuaries and Employee Benefit Consultants
