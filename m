Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbTFWTum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbTFWTum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:50:42 -0400
Received: from windsormachine.com ([206.48.122.28]:61703 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S266117AbTFWTuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:50:40 -0400
Date: Mon, 23 Jun 2003 16:04:19 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: xircom card bus with 2.4.20 link trouble
In-Reply-To: <Pine.LNX.4.33.0306221545350.6572-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.33.0306231557020.755-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Mike Dresser wrote:

> I will check the exact lspci and hdparm -i when I get to the office
> tomorrow.

# hdparm -i /dev/hda

/dev/hda:

 Model=TOSHIBA MK1301MAV, FwRev=B0.03 A, SerialNo=86O37347
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=2633/16/63, TrkSize=40257, SectSize=639, ECCbytes=21
 BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=16, MultSect=16
 CurCHS=2633/16/63, CurSects=2654064, LBA=yes, LBAsects=2654280
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3

# lspci -vvv -s 00:14.0

00:14.0 IDE interface: OPTi Inc. 82C621 (rev 12) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 3000 [size=16]

and when i hdparm -d 1 /dev/hda

blk: queue c0273700, I/O limit 4095Mb (mask 0xffffffff)
hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

It doesn't work with sdma0 or mdma0 either.

/dev/hda:
 Timing buffer-cache reads:   128 MB in  4.38 seconds = 29.22 MB/sec
 Timing buffered disk reads:  64 MB in 20.09 seconds =  3.19 MB/sec

No speed demon there!

Mike

