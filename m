Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283537AbRLIPfi>; Sun, 9 Dec 2001 10:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283540AbRLIPf2>; Sun, 9 Dec 2001 10:35:28 -0500
Received: from pc2-camb4-0-cust100.cam.cable.ntl.com ([213.107.105.100]:2688
	"EHLO eden.lincnet") by vger.kernel.org with ESMTP
	id <S283537AbRLIPfJ>; Sun, 9 Dec 2001 10:35:09 -0500
Date: Sun, 9 Dec 2001 15:35:14 +0000 (GMT)
From: Carl Ritson <critson@perlfu.co.uk>
X-X-Sender: <critson@eden.lincnet>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
In-Reply-To: <20011209135825.GN20061@suse.de>
Message-ID: <Pine.LNX.4.33.0112091524320.1163-100000@eden.lincnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Jens Axboe wrote:
> > > > Agrh, because of a bug in ide-scsi conversion this (other) bug went
> > > > unnoticed for a while. Basically we cannot look up the request queue
> > > > reliably from a request, since it may not have originated from the block
> > > > layer. ide-scsi builds it's own, for example. For those, we don't want
> > > > to trust the sg count either.
> > > >
> > > > Does attached patch work?
> > >
> > > Irk, there's a ide-scsi bug in there too. In
> > > drivers/scsi/ide-scsi.c:idescsi_free_bio() change the kfree(bhp) to
> > > bio_put(bhp)
> > >
> >
> > With both these fixes applied cdrecord hangs for 30 seconds, then spits
> > out "cdrecord: No such device or address. Cannot send SCSI cmd via ioctl",
> > a couple of hundred times.
> >
> > In the from dmesg from the same time I get.
> > ------
> > hdc: timeout waiting for DMA
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > hdc: drive not ready for command
> > scsi: device set offline - command error recover failed: host 0 channel 0
> > id 0 lun 0
> > ------
>
> Please try a run with DMA disabled.
>

Ok works with DMA off, so I expect that this new error is due to my resent
memory upgrade (36 Hours ago) and the switch to using HIGHMEM(4GB)..
So am I to believe that DMA is a problem with HIGHMEM(4GB) enabled ?

Carl Ritson
critson@perlfu.co.uk

