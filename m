Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSHJH6e>; Sat, 10 Aug 2002 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSHJH6e>; Sat, 10 Aug 2002 03:58:34 -0400
Received: from [202.105.36.198] ([202.105.36.198]:43650 "EHLO
	systemx.zsu.edu.cn") by vger.kernel.org with ESMTP
	id <S316659AbSHJH6d>; Sat, 10 Aug 2002 03:58:33 -0400
Date: Sat, 10 Aug 2002 16:02:06 +0000 (UTC)
From: Bruce M Beach <brucemartinbeach@21cn.com>
X-X-Sender: bmbeach@systemx.zsu.edu.cn
To: linux-kernel@vger.kernel.org
cc: brucemartinbeach@21cn.com
Subject: IDE numbers
Message-ID: <Pine.LNX.4.43.0208101416500.302-100000@systemx.zsu.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Thanks all for your messages

  Willy Tarreau wonders why I have hda1 in the letter and hdc1 in the
  dmesg and suggests that the speed is related to the head movement.
  Mike Dresser wonders what 'hdparm /dev/hda' and 'hdparm -Tt /dev/hda'
  have to say and Marian Jancar wonders from
  'ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA'
  that the kernel doesn't attemp UDMA anyway.

  As for "hda1 and hdc3", I constantly change things around and
  the dmesg that I sent in was made 2 days before the letter. In that time
  hdc1 became hda1. I wouldn't be surprised to see that a transfer from one
  drive to another did not make any speed increase. I have another drive
  and will try it. Now as to what hdparm says, we have:
     1) /dev/hda:
         multcount    =  0 (off)
         I/O support  =  0 (default 16-bit)
         unmaskirq    =  0 (off)
         using_dma    =  0 (off)
         keepsettings =  0 (off)
         nowerr       =  0 (off)
         readonly     =  0 (off)
         readahead    =  8 (on)
         geometry     = 7297/255/63, sectors = 117231408, start = 0
  and
     2) /dev/hda:
        Timing buffer-cache reads:  128 MB in  0.27 seconds =474.07 MB/sec
        Timing buffered disk reads:  64 MB in 21.24 seconds =  3.01 MB/sec
  In the second group we get a salesman's number, a realistic number
  and in the first group there are some interesting entries indicating
  that something may be wrong.
        I/O support  =  0 (default 16-bit)
        using_dma    =  0 (off)
  Now as to why the kernel doesn't use UDMA anyway, I too am surprised
  because I always believed that no matter what was in your machine the
  kernel would always, under all circumstances give an optimal configuration.
  Since the thought pleases me, I'll continue to believe it and attribute
  this case to some obscure third stream phenomena.

  Now a switch from 2.4.18 to 2.4.19 stops my USB mouse from working and also
  gives a new dmesg that gives a clear indication of the IDE problem:

       ICH3: IDE controller on PCI bus 00 dev f9
       ICH3: detected chipset, but driver not compiled in!
  So reconfiguring with:
       Intel PIIXn chipsets support  and
       PIIXn Tuning support
  gives us from dmesg
       ide: Assuming 33MHz system bus speed for PIO modes;
       ICH3: IDE controller on PCI bus 00 dev f9
       PCI: Device 00:1f.1 not available because of resource collisions
       ICH3: (ide_setup_pci_device:) Could not enable device.
 also we have the following

K2.4.18: ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
K2.4.19: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

  and

   sh-2.05b# hdparm -d1 /dev/hda1
             /dev/hda1:
              setting using_dma to 1 (on)
              HDIO_SET_DMA failed: Invalid argument
              using_dma    =  0 (off)
    sh-2.05b# hdparm -c1 /dev/hda1
              /dev/hda1:
              setting 32-bit I/O support flag to 1
              HDIO_SET_32BIT failed: Invalid argument
              I/O support  =  0 (default 16-bit)
  hdparm -c1 /dev/hda1 worked before PIIXn support was
  compiled in and would give
       Timing buffered disk reads:  64 MB in 21.24 seconds =  5.51 MB/sec

  Finally some pertinant information on the Machine

       Processor: Dual 2.2Ghz Xeon P4
       Chipset:   Intel E7500
                    MCH:    E7500
                    ICH3-S: 820801CA
                    P64H2:  82870P2
  Regards Bruce








