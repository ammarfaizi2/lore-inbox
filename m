Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBPAEh>; Thu, 15 Feb 2001 19:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129329AbRBPAE0>; Thu, 15 Feb 2001 19:04:26 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25611
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129104AbRBPAEI>; Thu, 15 Feb 2001 19:04:08 -0500
Date: Thu, 15 Feb 2001 16:03:49 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jasmeet Sidhu <jsidhu@arraycomm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA Problems...system hangs
In-Reply-To: <5.0.2.1.2.20010215153520.02498628@pop.arraycomm.com>
Message-ID: <Pine.LNX.4.10.10102151601060.25463-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have junk for cables or they are noe sheilded correctly from
crosstalk.  But I do not think this is the case.
Go check your power-supply for stality and load.
Then do a ripple noise test to make sure that underload, it does not cause
the clock on the drives to fail.


On Thu, 15 Feb 2001, Jasmeet Sidhu wrote:

> 
>  >>I've not changed anything related to DMA handling specifically. The current
>  >>-ac does have a fix for a couple of cases where an IDE reset on the promise
>  >>could hang the box dead. That may be the problem.
> 
> I tried the new patches (2.4.1-ac13) and it seemed very stable.  After 
> moving about 50GB of data to the raid5, the system crashed.  here is the 
> syslog... (the system had been up for about 20 hours)
> 
> Feb 14 03:48:53 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 14 03:48:53 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> <snip - about 40 lines exact same hdo: error>
> Feb 14 19:35:52 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 14 19:35:52 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 14 19:35:52 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 14 20:13:06 bertha kernel: hdi: dma_intr: bad DMA status
> Feb 14 20:13:06 bertha kernel: hdi: dma_intr: status=0x50 { DriveReady 
> SeekComplete }
> 
> Feb 15 01:26:34 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 15 01:26:34 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 15 01:26:34 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 15 01:26:34 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 15 01:26:38 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 15 01:26:38 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 15 01:45:06 bertha kernel: hdo: dma_intr: status=0x53 { DriveReady 
> SeekComplete Index Error }
> Feb 15 01:45:06 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 15 01:45:06 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 15 01:45:06 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 15 01:45:06 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 15 01:45:06 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }
> Feb 15 01:54:01 bertha kernel: hdg: timeout waiting for DMA
> <SYSTEM FROZEN>
> 
> Jasmeet
> 
> 
> At 08:54 PM 2/14/2001 +0000, Alan Cox wrote:
> > > >You will get horribly bad performance off raid5 if you have stripes on 
> > both
> > > >hda/hdb  or hdc/hdd etc.
> > >
> > > If I am reading this correctly, then by striping on both hda/hdb and
> > > /hdc/hdd you mean that I have two drives per ide channel.  In other words,
> > > you think I have a Master and a Slave type of a setup?  This is
> > > incorrect.  Each drive on the system is a master.  I have 5 promise cards
> >
> >Ok then your performance should be fine (at least reasonably so, the lack
> >of tagged queueing does hurt)
> >
> > > ide chanel, the penalty should not be much in terms of performance.  Maybe
> > > its just that the hdparam utility is not a good tool for benchamarking a
> > > raid set?
> >
> >Its not a good raid benchmark tool but its a good indication of general 
> >problems.
> >Bonnie is a good tool for accurate assessment.
> >
> > > disable DMA if its giving it a lot of problems, but it should not hang.  I
> > > have been experiencing this for quite a while with the newer
> > > kernels.  Should I try the latest ac13 patch?  I glanced of the changes 
> > and
> > > didnt seem like anything had changed regarding the ide subsystem.
> >
> >I've not changed anything related to DMA handling specifically. The current
> >-ac does have a fix for a couple of cases where an IDE reset on the promise
> >could hang the box dead. That may be the problem.
> >
> > > Is there anyway I can force the kernel to output more messages...maybe 
> > that
> > > could help narrow down the problem?
> >
> >Ask andre@linux-ide.org. He may know the status of the promise support
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

