Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTE2MpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTE2MpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:45:19 -0400
Received: from [212.18.235.100] ([212.18.235.100]:65296 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261888AbTE2MpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:45:18 -0400
Subject: SiI 3112 sata_error
From: Justin Cormack <justin@street-vision.com>
To: Kernel mailing list <linux-kernel@vger.kernel.org>, andre@linux-ide.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 29 May 2003 13:58:37 +0100
Message-Id: <1054213120.17709.72.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a SiI3112 PCI card 

01:01.0 Unknown mass storage controller: CMD Technology Inc: Unknown
device 3112 (rev 01)

SiI3112 Serial ATA: IDE controller at PCI slot 01:01.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

The drives are Maxtor 4A250J0 parallel ATA with Silicon Image
converters.

hdparm -i /dev/hde

/dev/hde:

 Model=Maxtor 4A250J0, FwRev=RAMB1TU0, SerialNo=A804KZ3E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):  1 2 3 4 5 6 7


running under 2.4.21-pre4-ac1 and I get continual errors of:

May 29 12:42:42 calamari kernel: hde: sata_error = 0x00000000, watchdog
= 0, siimage_mmio_ide_dma_test_irq
May 29 12:42:42 calamari kernel: hdg: sata_error = 0x00000000, watchdog
= 0, siimage_mmio_ide_dma_test_irq

as soon as I turn dma on. 

If I remove the printk from siimage.c they seem to run fine, with good
performance, so I wonder if this error might be bogus?



