Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVKCTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVKCTEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVKCTEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:04:11 -0500
Received: from hell.sks3.muni.cz ([147.251.210.189]:31880 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1030447AbVKCTEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:04:10 -0500
Date: Thu, 3 Nov 2005 20:03:34 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Large file system oddities
Message-ID: <20051103190334.GI2507@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use vanilla kernel 2.6.13.4 on Pentium 4 with EM64T extensions in x86_64 mode.

I have 3.5TB partition formated as XFS.

This is from dmesg:
scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec 39320A Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

(scsi2:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
  Vendor: SB-3163S  Model: Volume Set # 00   Rev: R001
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi2:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sdc: 854676032 4096-byte hdwr sectors (3500753 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 854676032 4096-byte hdwr sectors (3500753 MB)
SCSI device sdc: drive cache: write back
 sdc: unknown partition table


Using fdisk I made one big partition accross whole disk:

fdisk /dev/sdc
Note: sector size is 4096 (not 512)

The number of cylinders for this disk is set to 53201.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/sdc: 3500.7 GB, 3500753027072 bytes
255 heads, 63 sectors/track, 53201 cylinders
Units = cylinders of 16065 * 4096 = 65802240 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1       53201  3418696008   83  Linux

However, cat /proc/partitions produces:
# cat /proc/partitions 
major minor  #blocks  name

   8     0  244198584 sda
   8     1   39062016 sda1
   8     2    3903795 sda2
   8     3  201230190 sda3
   8    32 3418704128 sdc
   8    33 1271212360 sdc1

I made XFS file system on it:
# mkfs.xfs -f -s size=4096 -d su=65536,sw=7 /dev/sdc1

mounted partition results in:
# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sdc1             1.2T  332G  882G  28% /mnt/export1


So what's wrong? Or am I something missing?


-- 
Luká¹ Hejtmánek
