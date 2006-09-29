Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWI2ULb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWI2ULb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWI2ULb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:11:31 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:21228 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1422780AbWI2UL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:11:29 -0400
Message-ID: <451D7DE8.8020504@freescale.com>
Date: Fri, 29 Sep 2006 15:11:20 -0500
From: Timur Tabi <timur@freescale.com>
Organization: Freescale
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: SATA: "unknown partition table" error, fdisk can't fix, works in
 2.6.13
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a SATA drive attached to a PowerPC 8349E board, using the SIL 3114 controller.  I'm running the latest code from Paul Mackerras (PowerPC maintainer) (2.6.18-blabla).

I'm experiencing a number of I/O errors with the SATA drive.  fdisk can see the partition table, but when I issue the "w" command, I get this output:

Calling ioctl() to re-read partition table.
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: unknown partition table
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: unknown partition table
Syncing disks.

I cannot mount any partitions.  On boot, I see this:

sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xD100E080 ctl 0xD100E08A bmdma 0xD100E000 irq 22
ata2: SATA max UDMA/100 cmd 0xD100E0C0 ctl 0xD100E0CA bmdma 0xD100E008 irq 22
ata3: SATA max UDMA/100 cmd 0xD100E280 ctl 0xD100E28A bmdma 0xD100E200 irq 22
ata4: SATA max UDMA/100 cmd 0xD100E2C0 ctl 0xD100E2CA bmdma 0xD100E208 irq 22
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/100
scsi1 : sata_sil
ata2: SATA link down (SStatus 0 SControl 310)
scsi2 : sata_sil
ata3: SATA link down (SStatus 0 SControl 310)
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 ANSI: 5
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0

The odd thing is that this works in 2.6.13, so something is broken.  I don't know if it's a bug in the sata_sil driver, or a configuration issue.  Can anyone help?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
