Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVHNTaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVHNTaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 15:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVHNTaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 15:30:16 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:11751 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751055AbVHNTaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 15:30:15 -0400
Date: Sun, 14 Aug 2005 21:30:10 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Message-Id: <20050814213010.2936c6fb.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "hdparm -I /dev/hdc"

hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
de: failed opcode was: 0xec

Is present on all kernels that I have locally (oldest 2.6.11.11)
so it is not related to the threadstarters problems, it seems.

root:sleipner:~# hdparm -I /dev/hdc

/dev/hdc:

ATAPI CD-ROM, with removable media
        Model Number:       TSSTcorpCD/DVDW TS-L532A                
        Serial Number:      254A204626          
        Firmware Revision:  TI50    
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2 
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 2048.0kB
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    DEVICE RESET cmd
           *    PACKET command feature set
           *    Power Management feature set
           *    Mandatory FLUSH CACHE command 
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by CSEL

root:sleipner:~# hdparm -i /dev/hdc

/dev/hdc:

 Model=TSSTcorpCD/DVDW TS-L532A, FwRev=TI50, SerialNo=254A204626
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: Reserved: 

 * signifies the current active mode

root:sleipner:~# hdparm /dev/hdc

/dev/hdc:
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument

root:sleipner:~# grep VIA /usr/src/testing/my-2.6.13-rc6-.config 
[edited]
CONFIG_BLK_DEV_VIA82CXXX=y

root:sleipner:~# grep IDE /usr/src/testing/my-2.6.13-rc6-.config 
[edited]
# CONFIG_PARIDE is not set
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# Please see Documentation/ide.txt for help/info on IDE drives
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# IDE chipset support/bugfixes
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y

Mvh
Mats Johannesson
--
