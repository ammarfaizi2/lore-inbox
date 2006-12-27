Return-Path: <linux-kernel-owner+w=401wt.eu-S1754688AbWL0Rvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbWL0Rvl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbWL0Rvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:51:41 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:42134 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbWL0Rvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:51:40 -0500
Message-ID: <4592B25A.4040906@gmail.com>
Date: Wed, 27 Dec 2006 18:50:18 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATA -- pata_amd on 2.6.19 fails to IDENTIFY my DVD-ROM
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com>
In-Reply-To: <45921E73.1080601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

> Rene Herman wrote:

>> I just tried the PATA driver for my AMD756 chip. During boot, it hangs
>> for 3 minutes failing to identify my DVD-ROM (secondary slave) and does
>> not give me access to it after it timed out.
> 
> Please give a shot at v2.6.20-rc2 and report what the kernel says.

This IDENTIFY issue seems already fixed in -rc2. No more pause, and my
DVD-ROM works fine again. Unfortunately, another issue seems to have
cropped up. On 2.6.20-rc2, hdparm -t /dev/sda gets me ~ 24 M/s while
both the old IDE driver and the 2.6.19 PATA driver do ~ 50 M/s

2.6.20-rc2-ata:

# hdparm -t /dev/sda

/dev/sda:
  Timing buffered disk reads:   72 MB in  3.03 seconds =  23.75 MB/sec

2.6.19-ata:

# hdparm -t /dev/sda

/dev/sda:
  Timing buffered disk reads:  150 MB in  3.00 seconds =  49.94 MB/sec

Here's the ata part of the 2.6.20-rc2 dmesg:

===
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : pata_amd
ata1.00: ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/66
scsi1 : pata_amd
ata2.00: ATAPI, max UDMA/33
ata2.01: ATAPI, max UDMA/66
ata2.00: configured for UDMA/33
ata2.01: configured for UDMA/66
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y120P0   YAR4 PQ: 0 ANSI: 5
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sda: sda1 < sda5 sda6 sda7 sda8 > sda2 sda3 sda4
  sda2: <minix: sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            PLEXTOR  CD-R   PREMIUM   1.07 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
scsi 1:0:1:0: CD-ROM            PLEXTOR  DVD-ROM PX-116A  1.00 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr 1:0:1:0: Attached scsi CD-ROM sr1
sr 1:0:1:0: Attached scsi generic sg2 type 5
===

There's some difference with respect to caching versus 2.6.19 it seems? 
The same bit for 2.6.19:

===
pata_amd 0000:00:07.1: version 0.2.4
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : pata_amd
ata1.00: ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/66
scsi1 : pata_amd
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: port failed to respond (30 secs, Status 0xd8)
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y120P0   YAR4 PQ: 0 ANSI: 5
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 < sda5 sda6 sda7 sda8 > sda2 sda3 sda4
  sda2: <minix: sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            PLEXTOR  CD-R   PREMIUM   1.07 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
===

Rene.
