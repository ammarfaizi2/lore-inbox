Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283287AbRLIKbX>; Sun, 9 Dec 2001 05:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283294AbRLIKbN>; Sun, 9 Dec 2001 05:31:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2056 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283287AbRLIKbK>;
	Sun, 9 Dec 2001 05:31:10 -0500
Date: Sun, 9 Dec 2001 11:31:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Carl Ritson <critson@perlfu.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <20011209103104.GD20061@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112090919220.1468-100000@eden.lincnet> <20011209102208.GC20061@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011209102208.GC20061@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09 2001, Jens Axboe wrote:
> On Sun, Dec 09 2001, Carl Ritson wrote:
> > Got this at the very start of burning a cd, nothing special, using
> > ide-scsi build into kernel. "cdrecord -v dev=0,0,0 speed=4 img.iso".
> > Box is Dual-PIII 866, 1GB Ram, all IDE system.
> 
> Agrh, because of a bug in ide-scsi conversion this (other) bug went
> unnoticed for a while. Basically we cannot look up the request queue
> reliably from a request, since it may not have originated from the block
> layer. ide-scsi builds it's own, for example. For those, we don't want
> to trust the sg count either.
> 
> Does attached patch work?

Irk, there's a ide-scsi bug in there too. In
drivers/scsi/ide-scsi.c:idescsi_free_bio() change the kfree(bhp) to
bio_put(bhp)


-- 
Jens Axboe

