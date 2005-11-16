Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVKPOsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVKPOsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVKPOsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:48:14 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:37284 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1030353AbVKPOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:48:13 -0500
Date: Wed, 16 Nov 2005 15:48:25 +0100
From: Sander <sander@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1 libata pata_via
Message-ID: <20051116144825.GA16750@favonius>
Reply-To: sander@humilis.net
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net> <20051108121318.GB23549@favonius> <1131455213.25192.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131455213.25192.26.camel@localhost.localdomain>
X-Uptime: 15:06:50 up 2 days,  3:37, 21 users,  load average: 1.85, 1.36, 1.48
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (ao):
> On Maw, 2005-11-08 at 13:13 +0100, Sander wrote:
> > [42949377.130000]  sdf:<3>ata5: command error, drv_stat 0x51 host_stat 0x64
> > [42949377.210000] ata5: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [42949377.210000] ata5: status=0x51 { DriveReady SeekComplete Error }
> 
> Thats the important bit. It looks as if I got the timing clock loading
> wrong for this chip. (My EPIA works nicely but all the info I need is in
> your report).

I have one disk now, on an 80 wire cable. The system boots from the disk
but can't find it afterwards:

[42949376.200000] pata_via 0000:00:11.1: version 0.1.1
[42949376.200000] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 5 (level, low) -> IRQ 5
[42949376.200000] PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 5
[42949376.200000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xCC00 irq 14
[42949376.200000] ata5: port disabled. ignoring.
[42949376.200000] scsi4 : pata_via
[42949376.200000] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xCC08 irq 15
[42949376.370000] ATA: abnormal status 0xFF on port 0x177
[42949376.370000] ata6: disabling port
[42949376.370000] scsi5 : pata_via


(2.6.14-mm2, Epia MII 10000, Maxtor 250GB pata).

This is what 2.6.14-mm1 reports:

[42949378.560000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xCC00 irq 14
[42949378.720000] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
[42949378.720000] ata5: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
[42949378.720000] ata5: dev 0 configured for UDMA/100
[42949378.720000] scsi4 : pata_via
[42949378.720000]   Vendor: ATA       Model: Maxtor 6Y200P0    Rev: YAR4
[42949378.720000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[42949378.720000] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xCC08 irq 15
[42949378.890000] ATA: abnormal status 0xFF on port 0x177
[42949378.890000] ata6: disabling port
[42949378.890000] scsi5 : pata_via
[ ... ]
[42949378.970000] SCSI device sde: 398297088 512-byte hdwr sectors (203928 MB)
[42949378.970000] SCSI device sde: drive cache: write back
[42949378.970000] SCSI device sde: 398297088 512-byte hdwr sectors (203928 MB)
[42949378.970000] SCSI device sde: drive cache: write back
[42949378.970000]  sde: sde1 sde2
[42949378.990000] sd 4:0:0:0: Attached scsi disk sde


Btw, now I _can_ fdisk /dev/sde, while I could not do so with a
slave disk and a 40 wire cable.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
