Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSJ2O0Q>; Tue, 29 Oct 2002 09:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJ2O0P>; Tue, 29 Oct 2002 09:26:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44740 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261907AbSJ2O0M>;
	Tue, 29 Oct 2002 09:26:12 -0500
Date: Tue, 29 Oct 2002 15:32:19 +0100
From: Jens Axboe <axboe@suse.de>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Fix: BK-Current doesn't compile w/o SCSI enabled
Message-ID: <20021029143219.GA12365@suse.de>
References: <E186XOP-0006Z7-00@snap.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E186XOP-0006Z7-00@snap.thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29 2002, tytso@mit.edu wrote:
> 
> BK current doesn't compile without SCSI being enabled, since
> sg_scsi_ioctl() in drivers/block/scsi_ioctl.c is always being compiled,
> regardless of whether or not SCSI is present (since some non-SCSI
> devices now use this infrastructure).  Unfortunately, it makes reference
> to the COMMAND_SIZE() macro, which is defined in drivers/scsi/scsi.c,
> and that is NOT defined on non-SCSI build kernels.
> 
> The simplest solution to this problem seems to be move scsi_command_size
> from drivers/scsi/scsi.c to drivers/block/scsi_ioctl.c, where it is used
> (and since it is always compiled in, this shouldn't break anything on
> SCSI systems).
> 
> I'm a bit uneasy about the abstraction violation of moving the
> scsi_command_size array outside of the drivers/scsi tree, but that
> problem was introduced when the code in drivers/block/scsi_ioctl.c was
> moved out of the drivers/scsi tree, since drivers/block/scsi_ioctl.c
> already #includes ../scsi/scsi.h, so I haven't introduced a new layering
> violation.

I think the "violation" is ok, since the commandset they reference is
the same. So no problem there.

> Jens, do you agree this is the best way of fixing this issue?  If so,
> please push this change to Linus.  Thanks!!

I've already sent the very same patch to Linus earlier today,
bit-for-bit identical :-)

-- 
Jens Axboe

