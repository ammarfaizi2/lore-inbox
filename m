Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283438AbRLINwx>; Sun, 9 Dec 2001 08:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283439AbRLINwo>; Sun, 9 Dec 2001 08:52:44 -0500
Received: from pc2-camb4-0-cust100.cam.cable.ntl.com ([213.107.105.100]:1920
	"EHLO eden.lincnet") by vger.kernel.org with ESMTP
	id <S283438AbRLINwe>; Sun, 9 Dec 2001 08:52:34 -0500
Date: Sun, 9 Dec 2001 13:52:32 +0000 (GMT)
From: Carl Ritson <critson@perlfu.co.uk>
X-X-Sender: <critson@eden.lincnet>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
In-Reply-To: <20011209103104.GD20061@suse.de>
Message-ID: <Pine.LNX.4.33.0112091347090.1290-100000@eden.lincnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, Dec 09 2001, Jens Axboe wrote:
> > On Sun, Dec 09 2001, Carl Ritson wrote:
> > > Got this at the very start of burning a cd, nothing special, using
> > > ide-scsi build into kernel. "cdrecord -v dev=0,0,0 speed=4 img.iso".
> > > Box is Dual-PIII 866, 1GB Ram, all IDE system.
> >
> > Agrh, because of a bug in ide-scsi conversion this (other) bug went
> > unnoticed for a while. Basically we cannot look up the request queue
> > reliably from a request, since it may not have originated from the block
> > layer. ide-scsi builds it's own, for example. For those, we don't want
> > to trust the sg count either.
> >
> > Does attached patch work?
>
> Irk, there's a ide-scsi bug in there too. In
> drivers/scsi/ide-scsi.c:idescsi_free_bio() change the kfree(bhp) to
> bio_put(bhp)
>

With both these fixes applied cdrecord hangs for 30 seconds, then spits
out "cdrecord: No such device or address. Cannot send SCSI cmd via ioctl",
a couple of hundred times.

In the from dmesg from the same time I get.
------
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
scsi: device set offline - command error recover failed: host 0 channel 0
id 0 lun 0
------

So no joy yet. :/

Carl Ritson
critson@perlfu.co.uk

