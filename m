Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSIPLMg>; Mon, 16 Sep 2002 07:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbSIPLMg>; Mon, 16 Sep 2002 07:12:36 -0400
Received: from b114225.adsl.hansenet.de ([62.109.114.225]:3076 "EHLO
	smaug.lan.local") by vger.kernel.org with ESMTP id <S261351AbSIPLMR>;
	Mon, 16 Sep 2002 07:12:17 -0400
Message-ID: <XFMail.20020916131706.f.hinzmann@hamburg.de>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10209141539550.6925-100000@master.linux-ide.org>
Date: Mon, 16 Sep 2002 13:17:06 +0200 (CEST)
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
       Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14-Sep-2002 Andre Hedrick wrote:

> Yep I had that problem too and fixed it.
> Please try a newer pre5-acX

Problem is still there with 2.4.20-pre5-ac6:

kernel: hdd: dma_timer_expiry: dma status == 0x60
kernel: hdd: timeout waiting for DMA
kernel: hdd: timeout waiting for DMA
kernel: hdd: (__ide_dma_test_irq) called while not waiting
kernel: hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: 
kernel: hdd: drive not ready for command
kernel: blk: queue c02e50e0, I/O limit 4095Mb (mask 0xffffffff)


No high load (wether cpu or disk io) is needed for this to happen.


In my initial mail I said the machine is running stable with DMA turned off.
This is not true for latest 2.4.20pre5 kernels. When I start one or two bigger 
file copy operations it usually takes less than one minute and I get errors 
like these (running 2.4.20-pre5-ac6 for this output):

kernel: hdb: status timeout: status=0xd0 { Busy }
kernel: 
kernel: hdb: no DRQ after issuing WRITE
kernel: ide0: reset: success
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: ide0: reset: success
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: ide0: reset: success
kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
kernel: end_request: I/O error, dev 03:41 (hdb), sector 97567008


2.4.20-pre5-ac6 does not work for me with or without DMA. Using 2.4.19 that
machine is running stable with DMA turned off. Would it be interesting to hear
wich 2.4.20-preX-acY kernel was first to break pio mode at my machine?


  Regards
      Florian



--
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65
