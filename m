Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTDZHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 03:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbTDZHlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 03:41:08 -0400
Received: from tag.witbe.net ([81.88.96.48]:64270 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263792AbTDZHlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 03:41:07 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Marek Habersack'" <grendel@caudium.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lost interrupts with IDE DMA on 2.5.x
Date: Sat, 26 Apr 2003 09:53:00 +0200
Message-ID: <004401c30bc8$dc4bb660$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
In-Reply-To: <Pine.SOL.4.30.0304252143370.602-200000@mion.elka.pw.edu.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

It seems the patch is missing :-(

Regards,
Paul

> 
> Attached patch should help, please try.
> 
> --
> Bartlomiej
> 
> On Fri, 25 Apr 2003, Marek Habersack wrote:
> 
> > Hello,
> >
> >  I've recently added a second drive to my workstation and 
> since then 
> > I'm getting the following error from time to time:
> >
> >   Apr 25 20:42:06 beowulf kernel: hda: dma_timer_expiry: 
> dma status == 0x64
> >   Apr 25 20:42:06 beowulf kernel: hda: lost interrupt
> >   Apr 25 20:42:06 beowulf kernel: hda: dma_intr: bad DMA 
> status (dma_stat=70)
> >   Apr 25 20:42:06 beowulf kernel: hda: dma_intr: 
> status=0x50 { DriveReady
> >    SeekComplete }
> >
> > Both drives are new Maxtors (60 and 40GB) on the VIA KT266 chipset 
> > (the mobo is MSI K7T266 Pro2-A mobo):
> >
> > ----------VIA BusMastering IDE Configuration----------------
> > Driver Version:                     3.36
> > South Bridge:                       VIA vt8233a
> > Revision:                           ISA 0x0 IDE 0x6
> > Highest DMA rate:                   UDMA133
> > BM-DMA base:                        0xfc00
> > PCI clock:                          33.3MHz
> > Master Read  Cycle IRDY:            0ws
> > Master Write Cycle IRDY:            0ws
> > BM IDE Status Register Read Retry:  yes
> > Max DRDY Pulse Width:               No limit
> > -----------------------Primary IDE-------Secondary IDE------
> > Read DMA FIFO flush:          yes                 yes
> > End Sector FIFO flush:         no                  no
> > Prefetch Buffer:              yes                 yes
> > Post Write Buffer:            yes                 yes
> > Enabled:                      yes                 yes
> > Simplex only:                  no                  no
> > Cable Type:                   80w                 40w
> > -------------------drive0----drive1----drive2----drive3-----
> > Transfer Mode:       UDMA      UDMA       PIO       DMA
> > Address Setup:      120ns     120ns     120ns     120ns
> > Cmd Active:          90ns      90ns      90ns      90ns
> > Cmd Recovery:        30ns      30ns      30ns      30ns
> > Data Active:         90ns      90ns     330ns      90ns
> > Data Recovery:       30ns      30ns     270ns      30ns
> > Cycle Time:          15ns      15ns     600ns     120ns
> > Transfer Rate:  133.3MB/s 133.3MB/s   3.3MB/s  16.6MB/s
> >
> >   Of course, when the above happens, all disk I/O freezes. 
> The above 
> > happens only when there's simultaneous activity on both devices. It 
> > doesn't happen when the devices are on different IDE 
> interfaces. The 
> > transfer is always retried and completed successfully, so 
> it's not a 
> > bad hdd and I can only guess the problem is somewhere in 
> the DMA/IRQ 
> > handling by the IDE driver. If there's not enough information to 
> > diagnose/solve the problem, I can do more tests (run with 2.4 for a 
> > while, run with the generic IDE drive etc.).
> >
> > TIA,
> >
> > marek
> 

