Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTDZBcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 21:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264580AbTDZBcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 21:32:52 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:19853 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263750AbTDZBcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 21:32:50 -0400
From: Renaud =?iso-8859-1?q?Gu=E9rin?= <renaud@renaudguerin.net>
To: linux-kernel@vger.kernel.org
Subject: amd74xx+nForce2+DMA+CD writing = hang
Date: Sat, 26 Apr 2003 03:45:36 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304260345.36108.renaud@renaudguerin.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I reported this 2 weeks ago but it didn't seem to reach the right people, and 
I haven't seen a fix in recent kernels:
----------------------------------------------
I'm using 2.4.21pre7 on an Asus A7N8X board (nForce2).
It looks like DMA can't be enabled on this chipset using Generic PCI IDE 
support, so I went with the amd74xx driver.

What happens is the following, when attempting to write a CD on an ATA33  
burner with DMA enabled:
cdrecord advances way too quickly to the 7th Mbyte of data (it says 137x 
speed), and then it sits there.
Two ctrl-c's can interrupt it, but the machine freezes after a while anyway, 
or even instantly if I try "cdrecord -reset"

I've verified that this is linked to DMA being enabled or not (by unloading 
the scsi modules, loading the ide ones, hdparm'ing DMA away, and loading back 
scsi)

BTW, before this can be fixed, how does one disable DMA for a particular 
device on the kernel cmdline ?

Here are relevant kernel messages:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller 
on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: C/H/S=19710/16/255 from BIOS ignored
hdb: C/H/S=39236/16/255 from BIOS ignored
hda: IC35L040AVER07-0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
blk: queue c0319fc0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c031a0fc, I/O limit 4095Mb (mask 0xffffffff)
hdc: DVD-ROM DDU220E, ATAPI CD/DVD-ROM drive
hdd: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
 /dev/ide/host0/bus0/target1/lun0: p1 p2
[...]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: DVD-ROM DDU220E   Rev: 5.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2200E          Rev: 1.0C
  Type:   CD-ROM                             ANSI SCSI revision: 02
[...]
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
blk: queue c0319fc0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c031a0fc, I/O limit 4095Mb (mask 0xffffffff)

If anybody can have a look...
