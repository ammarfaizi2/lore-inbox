Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270585AbRHWVm1>; Thu, 23 Aug 2001 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRHWVmR>; Thu, 23 Aug 2001 17:42:17 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:46009 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S270557AbRHWVmE>;
	Thu, 23 Aug 2001 17:42:04 -0400
Date: Thu, 23 Aug 2001 23:42:18 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Cc: oesi@plan9.de
Subject: software raid does not do parallel reads under 2.4?
Message-ID: <20010823234218.B12873@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org, oesi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the md driver in striped mode does not parallelize any reads
under 2.4. The scenario is that I have 3 disks on different controllers
(different pci slots), so there should not be any ide bus contention.

When I read any single disk (e.g. using hdparm or dd), I get 32MB/s. When
I read two of them at the same time, I get about 28MB/s for each disk.

Under linux-2.2 using md and striping I get about 40-50MB/s, whereas, under
2.4, the same raid gives about 30MB/s.

I then reformatted the raid to have 2MB chunksize. If I look at the disk
LED's while reading from them (e.g. dd if=/dev/md3 bs=1024x1024x8), I see
that each disk is read in turn, while the other two disks are idle.

so it looks as if md under 2.4 only reads disks in turn, which makes
striping useless as a performance tool.

hdparm for all drives looks like this:

cerebro:/tmp# hdparm /dev/hde
/dev/hde:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 23988/16/63, sectors = 156301487, start = 0

two of the disks use a promise ultra tx2 controller, one the older ultra
100, and all run at udma 100.


-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
