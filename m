Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282864AbRK0IPf>; Tue, 27 Nov 2001 03:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282872AbRK0IPT>; Tue, 27 Nov 2001 03:15:19 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:2432 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S282851AbRK0IMm>; Tue, 27 Nov 2001 03:12:42 -0500
Date: Tue, 27 Nov 2001 03:12:37 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
Message-Id: <200111270812.fAR8CbY10366@jik.kamens.brookline.ma.us>
To: nakai@neo.shinko.co.jp
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3C02DFDC.F433EBD3@neo.shinko.co.jp> (message from nakai on Tue,
	27 Nov 2001 09:35:40 +0900)
Subject: Re: IDE: 2.2.19+IDE patches works fine; 2.4.x fails miserably;please 
 help me figure out why!
In-Reply-To: <200111250457.fAP4vIt03205@jik.kamens.brookline.ma.us> <3C02DFDC.F433EBD3@neo.shinko.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Date: Tue, 27 Nov 2001 09:35:40 +0900
>  From: nakai <nakai@neo.shinko.co.jp>
>  
>  Would you try 2.4.2 ?

No dice.  It fails pretty spectacularly:

  Nov 26 21:29:47 jik kernel: hde: timeout waiting for DMA
  Nov 26 21:29:47 jik kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  Nov 26 21:29:47 jik kernel: hde: irq timeout: status=0x50 { DriveReady SeekComplete }
  Nov 26 21:29:48 jik kernel: hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  Nov 26 21:29:48 jik kernel: hdg: dma_intr: error=0x04 { DriveStatusError }
  Nov 26 21:29:50 jik kernel: hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  Nov 26 21:29:50 jik kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  Nov 26 21:29:50 jik kernel: hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  Nov 26 21:29:50 jik kernel: hdg: dma_intr: error=0x04 { DriveStatusError }
  Nov 26 21:29:50 jik kernel: attempt to access beyond end of device
  Nov 26 21:29:50 jik kernel: 22:01: rw=0, want=1101324772, limit=7502323
  [lots more of lines like the last two]
  Nov 26 21:29:52 jik kernel: hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  Nov 26 21:29:52 jik kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  Nov 26 21:29:52 jik kernel: hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  Nov 26 21:29:52 jik kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
  Nov 26 21:29:52 jik kernel: ide2: reset: success

With Mark Hahn's guidance, I have learned the following additional
information about these problems:

* It only occurs when I use an SMP kernel (I have two processors).
  With the uniprocessor kernel (i.e., letting my second processor sit
  idle), there are no disk errors.

* Changing the BIOS settings from MPS 1.4 to MPS 1.1 reduces the
  frequenty of, but does not completely eliminate, the problems.

Furthermore, I happened to have a SIIG Ultra ATA/66 controller lying
around, so I decided to see what would happen if I used it instead of
the Promise controller.  I rebuilt my 2.4.16 kernel with HPT366,
swapped the controllers and rebooted, and the problems persist with
the SIIG controller.

On the other hand, at least while the SIIG controller is working, it
seems to be much faster than the Promise controller, so I think I'll
leave it in and switch back to 2.2.19+IDE for the time being :-).

Thanks,

  Jonathan Kamens
