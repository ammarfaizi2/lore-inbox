Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314125AbSDQPNL>; Wed, 17 Apr 2002 11:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSDQPNK>; Wed, 17 Apr 2002 11:13:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5385 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314125AbSDQPMh>; Wed, 17 Apr 2002 11:12:37 -0400
Date: Wed, 17 Apr 2002 11:09:29 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
In-Reply-To: <20020417125838.GA27648@dark.x.dtu.dk>
Message-ID: <Pine.LNX.3.96.1020417105817.32318B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Baldur Norddahl wrote:

> I have been doing some simple benchmarks on my IDE system. It got 12 disks
> and a system disk. The 12 disks are organized in two raids like this:

> echo Testing hdo1, hds1 and hdk1
> time dd if=/dev/hdo1 of=/dev/null bs=1M count=1k &
> time dd if=/dev/hds1 of=/dev/null bs=1M count=1k &
> time dd if=/dev/hdk1 of=/dev/null bs=1M count=1k &
> wait

> It is clear that the 33 MHz PCI bus maxes out at 75 MB/s. Is there a reason
> it doesn't reach 132 MB/s?

  I suspect you have tuned your system to the max, but I will mention
using 32 bit transfers on all drives, read ahead via hdparm, etc.
 
> Second, why are the md devices so slow? I would have expected it to reach
> 130+ MB/s on both md0 and md1. It even has spare CPU time to do it with.

  Possibly contention? Try smaller read sizes and see if the rate goes up.
Also, your strip size is small for stuff like this, for high volume
sequential data I used 256k. That was SCSI, though.
 
> Another issue is when the system is under heavy load this often happens:
> 
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdt: dma_intr: bad DMA status (dma_stat=75)
> hdt: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: timeout waiting for DMA
> PDC202XX: Primary channel reset.
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: timeout waiting for DMA
> PDC202XX: Primary channel reset.
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> etc.

  That looks like a hardware issue to me. I haven't looked at this
closely, but does the fallback include switching to PIO mode on errors
like this?
 
> It did not happen during the test above though.

  Good to eliminate, however.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

