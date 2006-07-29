Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWG2Vyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWG2Vyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWG2Vys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:54:48 -0400
Received: from smtp.ono.com ([62.42.230.12]:19649 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932232AbWG2Vys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:54:48 -0400
Date: Sat, 29 Jul 2006 23:54:31 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [2.6.18-rc2-mm1] libata: DMA speed too slow for cdrecord
Message-ID: <20060729235431.322ea6d3@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.3.1cvs86 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

(plz, linux-ide people, CC me, I'm subscribed to linux-kernel but not -ide, thx)

Using -rc2-mm1+libata fixes from
http://marc.theaimsgroup.com/?l=linux-kernel&m=115415195508235&w=2
(it was the same without the patch)
I get this:

werewolf:/store/tmp/burn# cdrecord dev=/dev/sr0 gno*.iso
cdrecord: No write mode specified.
cdrecord: Asuming -tao mode.
cdrecord: Future versions of cdrecord may have different drive dependent defaults.
Cdrecord-Clone 2.01.01a04 (i686-pc-linux-gnu) Copyright (C) 1995-2006 Jörg Schilling
scsidev: '/dev/sr0'
devname: '/dev/sr0'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   : 
Vendor_info    : 'HL-DT-ST'
Identifikation : 'DVDRAM GSA-4120B'
Revision       : 'A111'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Speed set to 7056 KB/s
cdrecord: DMA speed too slow (OK for 8x). Cannot write at speed 40x.
cdrecord: Max DMA data speed is 8.
cdrecord: Try to use 'driveropts=burnfree'.

Uh ? I have always burn at x40 with IDE. Capabilities for the burner say:
  Number of supported write speeds: 6
  Write speed # 0:  7056 kB/s CLV/PCAV (CD  40x, DVD  5x)
  Write speed # 1:  5645 kB/s CLV/PCAV (CD  32x, DVD  4x)
  Write speed # 2:  4234 kB/s CLV/PCAV (CD  24x, DVD  3x)
  Write speed # 3:  2822 kB/s CLV/PCAV (CD  16x, DVD  2x)
  Write speed # 4:  1411 kB/s CLV/PCAV (CD   8x, DVD  1x)
  Write speed # 5:   706 kB/s CLV/PCAV (CD   4x, DVD  0x)

Any idea ?

More info:

werewolf:/store/tmp/burn# lsscsi
[0:0:0:0]    cd/dvd  HL-DT-ST DVDRAM GSA-4120B A111  /dev/sr0
[0:0:1:0]    disk    IOMEGA   ZIP 250          51.G  /dev/sda
[1:0:0:0]    disk    ATA      ST3120022A       3.06  /dev/sdb
[1:0:1:0]    cd/dvd  TOSHIBA  DVD-ROM SD-M1712 1004  /dev/sr1
[2:0:0:0]    disk    ATA      ST3200822AS      3.01  /dev/sdc

dmesg:

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for PIO3
ata1.01: configured for PIO3
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
  Type:   Direct-Access                      ANSI SCSI revision: 05

werewolf:/store/tmp/burn# cdrecord dev=/dev/sr0 -prcap
Cdrecord-Clone 2.01.01a04 (i686-pc-linux-gnu) Copyright (C) 1995-2006 Jörg Schilling
scsidev: '/dev/sr0'
devname: '/dev/sr0'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   : 
Vendor_info    : 'HL-DT-ST'
Identifikation : 'DVDRAM GSA-4120B'
Revision       : 'A111'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.

Drive capabilities, per MMC-3 page 2A:

  Does read CD-R media
  Does write CD-R media
  Does read CD-RW media
  Does write CD-RW media
  Does read DVD-ROM media
  Does read DVD-R media
  Does write DVD-R media
  Does read DVD-RAM media
  Does write DVD-RAM media
  Does support test writing

  Does read Mode 2 Form 1 blocks
  Does read Mode 2 Form 2 blocks
  Does read digital audio blocks
  Does restart non-streamed digital audio reads accurately
  Does support Buffer-Underrun-Free recording
  Does read multi-session CDs
  Does read fixed-packet CD media using Method 2
  Does not read CD bar code
  Does not read R-W subcode information
  Does read raw P-W subcode data from lead in
  Does return CD media catalog number
  Does return CD ISRC information
  Does support C2 error pointers
  Does not deliver composite A/V data

  Does play audio CDs
  Number of volume control levels: 256
  Does support individual volume control setting for each channel
  Does support independent mute setting for each channel
  Does not support digital output on port 1
  Does not support digital output on port 2

  Loading mechanism type: tray
  Does support ejection of CD via START/STOP command
  Does not lock media on power up via prevent jumper
  Does allow media to be locked in the drive via PREVENT/ALLOW command
  Is not currently in a media-locked state
  Does not support changing side of disk
  Does not have load-empty-slot-in-changer feature
  Does not support Individual Disk Present feature

  Maximum read  speed:  7056 kB/s (CD  40x, DVD  5x)
  Current read  speed:  7056 kB/s (CD  40x, DVD  5x)
  Maximum write speed:  7056 kB/s (CD  40x, DVD  5x)
  Current write speed:  7056 kB/s (CD  40x, DVD  5x)
  Rotational control selected: CLV/PCAV
  Buffer size in KB: 2048
  Copy management revision supported: 1
  Number of supported write speeds: 6
  Write speed # 0:  7056 kB/s CLV/PCAV (CD  40x, DVD  5x)
  Write speed # 1:  5645 kB/s CLV/PCAV (CD  32x, DVD  4x)
  Write speed # 2:  4234 kB/s CLV/PCAV (CD  24x, DVD  3x)
  Write speed # 3:  2822 kB/s CLV/PCAV (CD  16x, DVD  2x)
  Write speed # 4:  1411 kB/s CLV/PCAV (CD   8x, DVD  1x)
  Write speed # 5:   706 kB/s CLV/PCAV (CD   4x, DVD  0x)

Supported CD-RW media types according to MMC-4 feature 0x37:
  Does write multi speed       CD-RW media
  Does write high  speed       CD-RW media
  Does write ultra high speed  CD-RW media
  Does write ultra high speed+ CD-RW media


--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam04 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
