Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWEHXrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWEHXrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 19:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWEHXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 19:47:47 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:31407 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750895AbWEHXrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 19:47:46 -0400
Message-ID: <445FD8D4.9030106@keyaccess.nl>
Date: Tue, 09 May 2006 01:48:36 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch update
References: <1147104400.3172.7.camel@localhost.localdomain>
In-Reply-To: <1147104400.3172.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> I've posted a new patch versus 2.6.17-rc3 up at the usual location.

Am currently running with this on AMD756. Both channels have 80w cables.

===
libata version 1.20 loaded.
pata_amd 0000:00:07.1: version 0.1.7
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
88:107f
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1: dev 0 configured for UDMA/66
scsi0 : pata_amd
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 1 cfg 49:0b00 82:4218 83:4000 84:4000 85:4218 86:0000 87:4000
88:101f
ata2: dev 1 ATAPI, max UDMA/66
ata2: dev 0 configured for UDMA/33
ata2: dev 1 configured for UDMA/33
scsi1 : pata_amd
   Vendor: PLEXTOR   Model: CD-R   PREMIUM    Rev: 1.06
   Type:   CD-ROM                             ANSI SCSI revision: 05
   Vendor: PLEXTOR   Model: DVD-ROM PX-116A   Rev: 1.00
   Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 > sda2
sd 0:0:0:0: Attached scsi disk sda
===

It seems to be working nicely. The hdparm -t result is slightly lower
than with the old IDE driver. With the default settings, the old IDE
driver gives me 49.4/5 MB/s, and 50.6/7 after a hdparm -a 1024. With
default setting the new driver gives me 46.6/7 MB/s, and 48.8/9 after
that same hdparm -a 1024. Higher than -a 1024 does not seem to matter
with either driver. The numbers are close, but completely repeatable.

CD and DVD ROMs are also working fine, including readcd and CDDA. This
is what cdparanoia has to say about sr0:

===
Checking /dev/sr0 for cdrom...
         Testing /dev/sr0 for cooked ioctl() interface
                 /dev/sr0 is not a cooked ioctl CDROM.
         Testing /dev/sr0 for SCSI interface
                 generic device: /dev/sg1
                 ioctl device: /dev/sr0

Found an accessible SCSI CDROM drive.
Looking at revision of the SG interface in use...
         SG interface version 3.5.33; OK.

CDROM model sensed sensed: PLEXTOR CD-R   PREMIUM 1.06

Checking for SCSI emulation...
         Drive is ATAPI (using SCSI host adaptor emulation)
         Couldn't disable kernel command translation layer

Checking for MMC style command set...
         Drive is MMC style
         DMA scatter/gather table entries: 127
         table entry size: 32768 bytes
         maximum theoretical transfer: 1769 sectors
         Setting default read size to 13 sectors (30576 bytes).

Verifying CDDA command set...
         Expected command set reads OK.
===

The "couldn't disable kernel command translation layer" bit is probably
expected?

It does have somwhat higher system times during ripping. The old IDE
driver, with cdparanoia -v -z -B, gives me some 30% user and 10-15%
system. This driver gets me 15-25% user and 15-20 % system. Lower user
times though, so I guess that might just be a protocol difference?

In any case, it seems that this driver is also not using DMA for CDDA? I 
am using slackware 10.2 (vanilla) "cdparanoia III release 9.8 (March 23, 
2001)". A while ago someone on this list pointed to some patches for 
SG_IO use with cdparanoia but this made my machine highly unstable. 
Would you like me to retest with this new driver? If so, any specific 
version of cdparanoia?

DVD is fine. UDMA33 though, although the drive is capable of UDMA66:

===
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 1 cfg 49:0b00 82:4218 83:4000 84:4000 85:4218 86:0000 87:4000
88:101f
ata2: dev 1 ATAPI, max UDMA/66
ata2: dev 0 configured for UDMA/33
ata2: dev 1 configured for UDMA/33
===

The old IDE driver does set it to UDMA66 after an ide1=ata66, and after
the recently merged patch to amd74xx to "only do disk side cable
detection". I assumed it was that same problem, but I see that
amd_early_probe_init() also assumes 80w cables on amd756 same as amd74xx
does. Do I need to tell it something additionally to make it do UDMA66?

This is what the drive itself says, through the old IDE driver:

===
/dev/hdd:

  Model=PLEXTOR DVD-ROM PX-116A, FwRev=1.00, SerialNo=
  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
  IORDY=yes, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 *udma4
  AdvancedPM=no
  Drive conforms to: device does not report version:

  * signifies the current active mode
===

Hope this was a useful report...

Rene.

