Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283540AbRLIPis>; Sun, 9 Dec 2001 10:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283541AbRLIPij>; Sun, 9 Dec 2001 10:38:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11794 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283540AbRLIPia>;
	Sun, 9 Dec 2001 10:38:30 -0500
Date: Sun, 9 Dec 2001 16:38:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Carl Ritson <critson@perlfu.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <20011209153820.GE28729@suse.de>
In-Reply-To: <20011209135825.GN20061@suse.de> <Pine.LNX.4.33.0112091524320.1163-100000@eden.lincnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112091524320.1163-100000@eden.lincnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09 2001, Carl Ritson wrote:
> On Sun, 9 Dec 2001, Jens Axboe wrote:
> > > > > Agrh, because of a bug in ide-scsi conversion this (other) bug went
> > > > > unnoticed for a while. Basically we cannot look up the request queue
> > > > > reliably from a request, since it may not have originated from the block
> > > > > layer. ide-scsi builds it's own, for example. For those, we don't want
> > > > > to trust the sg count either.
> > > > >
> > > > > Does attached patch work?
> > > >
> > > > Irk, there's a ide-scsi bug in there too. In
> > > > drivers/scsi/ide-scsi.c:idescsi_free_bio() change the kfree(bhp) to
> > > > bio_put(bhp)
> > > >
> > >
> > > With both these fixes applied cdrecord hangs for 30 seconds, then spits
> > > out "cdrecord: No such device or address. Cannot send SCSI cmd via ioctl",
> > > a couple of hundred times.
> > >
> > > In the from dmesg from the same time I get.
> > > ------
> > > hdc: timeout waiting for DMA
> > > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > > hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > > hdc: drive not ready for command
> > > scsi: device set offline - command error recover failed: host 0 channel 0
> > > id 0 lun 0
> > > ------
> >
> > Please try a run with DMA disabled.
> >
> 
> Ok works with DMA off, so I expect that this new error is due to my resent
> memory upgrade (36 Hours ago) and the switch to using HIGHMEM(4GB)..
> So am I to believe that DMA is a problem with HIGHMEM(4GB) enabled ?

No it's probably still an ide-scsi bug, I'm not suspecting your
hardware. The reason I ask is because until -pre8 (since bio merge in
-pre2), ide-scsi never used DMA even though it was set for the drive.

-- 
Jens Axboe

