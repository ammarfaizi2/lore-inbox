Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273233AbRIQVTq>; Mon, 17 Sep 2001 17:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273246AbRIQVTg>; Mon, 17 Sep 2001 17:19:36 -0400
Received: from codepoet.org ([166.70.14.212]:60267 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S273233AbRIQVTc>;
	Mon, 17 Sep 2001 17:19:32 -0400
Date: Mon, 17 Sep 2001 15:19:57 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010917151957.A26615@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.8-ac10-rmk1-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[----------snip----------]
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/255 SCBs

(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: OLYMPUS   Model: MOS364            Rev: 1.02
  Type:   Optical Device                     ANSI SCSI revision: 02
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: OLYMPUS   Model: MOS364            Rev: 1.02
  Type:   Optical Device                     ANSI SCSI revision: 02
[----------snip----------]
Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
SCSI device sda: 310352 2048-byte hdwr sectors (636 MB)
sda: Write Protect is off
 sda:<5>ll_rw_block: device 08:00: only 2048-char blocks implemented (1024)
 unable to read boot sectors / partition sectors
SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
sdb: Write Protect is off
 sdb:<5>ll_rw_block: device 08:10: only 2048-char blocks implemented (1024)
 unable to read boot sectors / partition sectors
[----------snip----------]



$ cat /proc/partitions
major minor  #blocks  name

   8     0     620704 sda
   8    16     620704 sdb
   8     0     620704 sda
   8    16     620704 sdb
   8     0     620704 sda
   8    16     620704 sdb
   8     0     620704 sda
   8    16     620704 sdb
   8     0     620704 sda
   8    16     620704 sdb
   8     0     620704 sda
   8    16     620704 sdb
   8     0     620704 sda
   8    16     620704 sdb
   <continues forever>

In this case, there is no partition table on the magneto optical media
(since there seems little reason for such things)

    $ fdisk -l /dev/sda
    Note: sector size is 2048 (not 512)

    Disk /dev/sda: 64 heads, 32 sectors, 151 cylinders
    Units = cylinders of 2048 * 2048 bytes

    Disk /dev/sda doesn't contain a valid partition table
    $ 
    $ file -s /dev/sda
    /dev/sda: Linux rev 1.0 ext2 filesystem data

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
