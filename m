Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbUB0OrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUB0OrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:47:24 -0500
Received: from mail1.allneo.com ([216.185.99.210]:30944 "EHLO mail1.allneo.com")
	by vger.kernel.org with ESMTP id S262904AbUB0OrM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:47:12 -0500
From: "Brad Cramer" <bcramer@callahanfuneralhome.com>
To: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi-owner@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
Date: Fri, 27 Feb 2004 09:47:02 -0500
Message-ID: <008801c3fd40$933d2ca0$6501a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.44.0402182202150.5836-100000@poirot.grange>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, it took me some time, but here is what I did.
I installed a debian kernel image (kernel_image-2.4.24-1-k7) to tell if this
was just a problem with the driver or because of the upgrade to kernel 2.6.x
I the sym53c8xx and sym53c8xx_2 drivers are modules and this is what I got.

bigdaddy:~# modprobe sym53c8xx
PCI: Found IRQ 11 for device 00:0f.0
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 00:0d.1
sym53c8xx: at PCI bus 0, device 15, function 0
sym53c8xx: 53c895 detected with Tekram NVRAM
sym53c895-0: rev 0x1 on pci bus 0 device 15 function 0 irq 11
sym53c895-0: Tekram format NVRAM, ID 7, Fast-40, NO Parity
sym53c895-0: SCSI bus mode change from 80 to 80.
scsi0 : sym53c8xx-1.7.3c-20010512
blk: queue f6eed0d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: SEAGATE   Model: SX4234514         Rev: 9E21
Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f6eed2d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: PIONEER   Model: DVD-ROM DVD-303R  Rev: 2.00
Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f6eed3d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: IOMEGA    Model: ZIP 100           Rev: J.02
Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f6eed4d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: SONY      Model: SDT-5000          Rev: 3.26
Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue f6eedad4, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
sym53c895-0-<0,*>: asynchronous.
SCSI device sda: 45322644 512-byte hdwr sectors (23205 MB)
/dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
sym53c895-0-<5,*>: target did not report SYNC.
sym53c895-0-<5,*>: target did not report SYNC.
sym53c895-0-<5,*>: target did not report SYNC.
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sym53c895-0-<5,*>: target did not report SYNC.
sym53c895-0-<5,*>: target did not report SYNC.
sym53c895-0-<5,*>: target did not report SYNC.
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 28
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.
/dev/scsi/host0/bus0/target5/lun0: I/O error: dev 08:10, sector 0
I/O error: dev 08:10, sector 0
unable to read partition table

sdb is a zip drive without a disk in it and that is the reason for those
errors. Then when I mount a partition that is on /dev/sda I get this:

bigdaddy:~# mount /var
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device sd(8,2)) ...
for (sd(8,2))
sd(8,2):Using r5 hash to sort names

and everything works fine, then when I do :

bigdaddy:~# modprobe sym53c8xx_2
PCI: Found IRQ 11 for device 00:0f.0
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 00:0d.1
sym.0.15.0: setting PCI_COMMAND_INVALIDATE.
sym0: <895> rev 0x1 on pci bus 0 device 15 function 0 irq 11
sym0: Tekram NVRAM, ID 7, Fast-40, SE, NO parity
sym0: SCSI BUS has been reset.
sym0: SCSI BUS mode change from SE to SE.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
blk: queue f6eed4d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: SEAGATE   Model: SX4234514         Rev: 9E21
Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f6eed3d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: PIONEER   Model: DVD-ROM DVD-303R  Rev: 2.00
Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f6eed2d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: IOMEGA    Model: ZIP 100           Rev: J.02
Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f6eed0d4, I/O limit 4095Mb (mask 0xffffffff)
Vendor: SONY      Model: SDT-5000          Rev: 3.26
Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue f6eed9d4, I/O limit 4095Mb (mask 0xffffffff)
sym0:0:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
sym0:0: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: 45322644 512-byte hdwr sectors (23205 MB)
/dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
sym0:5:0:phase change 6-7 6@35a4cf84 resid=4.
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.
/dev/scsi/host0/bus0/target5/lun0: I/O error: dev 08:10, sector 0
I/O error: dev 08:10, sector 0
unable to read partition table
 and then when I try to mount a partition on /dev/sda I get this:

bigdaddy:~# mount /var
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device sd(8,2)) ...
for (sd(8,2))
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
Current sd08:02: sense key Aborted Command
Additional sense indicates Scsi parity error
I/O error: dev 08:02, sector 65680
sd(8,2):reiserfs: journal-837: IO error during journal replay
sd(8,2):Replay Failure, unable to mount
sd(8,2):sh-2022: reiserfs_read_super: unable to initialize journal space
mount: wrong fs type, bad option, bad superblock on /dev/sda2,
        or too many mounted file systems

So I don't understand what is wrong, my only guess is a problem with the
driver, but As I said I am not a programmer and I can not figure out where
the problem is.
Thanks 
Brad
-----Original Message-----
From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de] 
Sent: Wednesday, February 18, 2004 4:03 PM
To: Brad Cramer
Cc: linux-kernel@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x

On Wed, 18 Feb 2004, Brad Cramer wrote:

> Yes that is my drive, but after it scans the scsi bus and finds all the
> devices it will not mount any of the partitions. And I know it is not
> corrupted partitions because they mount fine under 2.4.18 using the
> sym53c8xx driver.
> I don't have the exact message in front of me, but when I try to manually
> mount the partitions under 2.6.2 I get errors something about parity
errors,
> again I could get the exact message when I get home tonight.

That might give a clue.

Guennadi
---
Guennadi Liakhovetski




