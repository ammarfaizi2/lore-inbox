Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281055AbRKYUzY>; Sun, 25 Nov 2001 15:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRKYUzP>; Sun, 25 Nov 2001 15:55:15 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:38528 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S281055AbRKYUzI>; Sun, 25 Nov 2001 15:55:08 -0500
Date: Sun, 25 Nov 2001 15:55:05 -0500
Message-Id: <200111252055.fAPKt5V22876@jik.kamens.brookline.ma.us>
X-mailer: xrn 9.03-beta-12
To: linux-kernel@vger.kernel.org
In-Reply-To: <fa.fdgrtcv.qh4d14@ifi.uio.no>
From: jik@kamens.brookline.ma.us (Jonathan Kamens)
Subject: Re: IDE: 2.2.19+IDE patches works fine; 2.4.x fails miserably; please help me figure out why!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I opened up my case.  I cleaned everything out with compressed
air.  I unplugged the two IDE cables connecting my drives to my Promise
Ultra66 controller.  I replaced them with brand new Maxtor ATA/100
cables I just bought today.  In the process, I discovered that one of
the two old cables was reversed, i.e., the end that was supposed to be
connected to the controller was connected to the drive instead but this
does not seem to have been the problem.  I closed up the computer,
powered it up, booted 2.4.16-pre1, and did some disk-intensive stuff on
my hde drive.  It's still barfing:

  hde: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  ide2: reset: success
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  ide2: reset: success
  hde: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hde: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hde: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hdg: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hdg: status error: status=0x51 { DriveReady SeekComplete Error }
  hdg: status error: error=0x04 { DriveStatusError }
  hdg: no DRQ after issuing MULTWRITE
  hdg: status error: status=0x51 { DriveReady SeekComplete Error }
  hdg: status error: error=0x04 { DriveStatusError }
  hdg: no DRQ after issuing MULTWRITE
  hdg: status error: status=0x51 { DriveReady SeekComplete Error }
  hdg: status error: error=0x04 { DriveStatusError }
  hdg: no DRQ after issuing MULTWRITE
  hdg: status error: status=0x51 { DriveReady SeekComplete Error }
  hdg: status error: error=0x04 { DriveStatusError }
  hdg: no DRQ after issuing WRITE
  ide3: reset: success
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hdg: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hdg: drive not ready for command
  hdg: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hdg: drive not ready for command
  hdg: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command
  hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hde: drive not ready for command

I set multcount to 0 and the problems persist, just as they did with
the old cables.

This clearly isn't a problem with my cables (and I've just wasted over
$40 to prove it, unless I can convince Staples to take back the opened
cables).

If it's a problem with my drives, then how is it that I don't have any
problems at all when I run 2.2.19+IDE on exactly the same hardware? 
And isn't it a mighty big coincidence that *both* of the drives on
this controller are having problems?

Someone asked me in E-mail to post details about the IDE controller
that's having the problems.  Here's /proc/ide/pdc202xx:

                                PDC20262 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 13
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          enabled 
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    no               yes             no                yes
DMA Mode:       UDMA 4           NOTSET          UDMA 4            NOTSET
PIO Mode:       PIO 4            NOTSET           PIO 4            NOTSET
