Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310370AbSCPN70>; Sat, 16 Mar 2002 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310372AbSCPN7R>; Sat, 16 Mar 2002 08:59:17 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:26855 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310370AbSCPN7D> convert rfc822-to-8bit; Sat, 16 Mar 2002 08:59:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: some ide-scsi commands starve drives on the same cable
Date: Sat, 16 Mar 2002 14:58:53 +0100
X-Mailer: KMail [version 1.3.2]
Cc: andre@linux-ide.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mEhy-0004Yj-00@mrvdomng1.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

during some activities (e.g. erasing a CDRW or fixating a CDR on my 
CD-Burner) the hard disc on the same cable cannot be accessed.All data and 
swap partitions are inaccessable. There is no dmesg output, just entering the
mount point fails.

Other activities (like burning the track) does not cause this problem.
I use Cdrecord 1.11a13.

The problem occurs with 2.4.18 and 2.4.19pre3, that means with the new and 
old ide-driver.

I have not included ATA-CD-Support in the kernel and instead compiled 
ide-scsi as a module to use all my CD-drives with cdrecord. (see config below)

I am not sure if it is a kernel problem or if it is a firmware-bug.
Any idea? 

Thank you.

Christian


Configuration:

hdc:  (the stalled hard disc)
 Model=Maxtor 52049H3, FwRev=JAC61HU0, SerialNo=F3HCCZYC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=40021632
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3 ATA-4 
ATA-5 ATA-6

hdd:  (the burner)
 Model=SONY CD-RW CRX140E, FwRev=1.0s, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no


hda(hard disc) and hdb(dvd-rom) are still working.

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-M1502 Rev: 1008
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX140E   Rev: 1.0s
  Type:   CD-ROM                           ANSI SCSI revision: 02

#cat /proc/ide/hda/driver   (ok)
ide-disk version 1.12
#cat /proc/ide/hdb/driver   (ok)
ide-scsi version 0.9



# cat /proc/ide/hdc/driver   (stalled)
ide-disk version 1.12
# cat /proc/ide/hdd/driver   (doing special things)
ide-scsi version 0.9


The IDE-Controller is a KT133A-Chipset:
lspci:
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 0d30 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)


.config:
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
