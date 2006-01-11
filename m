Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWAKLLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWAKLLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWAKLLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:11:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61218 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751416AbWAKLLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:11:48 -0500
Date: Wed, 11 Jan 2006 12:13:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
Message-ID: <20060111111313.GD3389@suse.de>
References: <20060110104759.GA30546@elte.hu> <43C3A85A.7000003@reub.net> <20060110044240.3d3aa456.akpm@osdl.org> <20060110131618.GA27123@elte.hu> <17348.34472.105452.831193@cse.unsw.edu.au> <43C4947C.1040703@reub.net> <20060110213001.265a6153.akpm@osdl.org> <20060110213056.58f5e806.akpm@osdl.org> <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111030529.0bc03e0a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> > On 11/01/2006 6:30 p.m., Andrew Morton wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > >> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> > >>> I'm tempted to see if I can narrow it down to a specific -gitX release, maybe 
> > >>>  that would narrow it down to say, 200 or so patches ;-)
> > >> If -mm2 plus -mm2's linus.patch does not fail then
> > >> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt will
> > >> find the dud patch.
> > > 
> > > Actually 2.6.15-mm1 would be a better one to do the bisection on: it has
> > > all the md- patches separated out.
> > 
> > I've done some more testing - which may change the suggested approach somewhat..
> > 
> > 2.6.15-mm1 is OK, I'm running it now, rebooted probably 15 times and it's come 
> > up every time.
> > 2.6.15-git2 is OK, booted up to completion (tested once).
> > 2.6.15-git3 was a dud, bootup hung
> 
> Ah.
> 
> > 2.6.15- [linus.patch from -mm2, which is basically the same as -git3] won't boot
> > 2.6.15-mm2 doesn't boot either, tested many times
> > 2.6.15-git6 won't boot
> > 2.6.15-git7 got stuck also, same issue
> > 
> > So some change that went in between -git2 and -git3 seems to have caused it. 
> > Nothing from -git3 onwards has ever booted to completion.
> > 
> > Is there any chance a patch came in, was queued in -mm but was never released in 
> > any -mm (1|2) release before being sent to Linus/-gitX?  (in this case, -git3). 
> 
> Yes, people sneak stuff in at the last minute.
> 
> Neil thinks that an IO got lost.  In the git2->git3 diff we have:
> 
>  b/drivers/scsi/Kconfig                         |   10 
>  b/drivers/scsi/ahci.c                          |    1 
>  b/drivers/scsi/ata_piix.c                      |    5 
>  b/drivers/scsi/libata-core.c                   |  145 +
>  b/drivers/scsi/libata-scsi.c                   |   48 
>  b/drivers/scsi/libata.h                        |    4 
>  b/drivers/scsi/sata_mv.c                       |    1 
>  b/drivers/scsi/sata_promise.c                  |    1 
>  b/drivers/scsi/sata_sil.c                      |    1 
>  b/drivers/scsi/sata_sil24.c                    |    1 
>  b/drivers/scsi/sata_sx4.c                      |    1 
>  b/drivers/scsi/scsi_lib.c                      |   50 
>  b/drivers/scsi/scsi_sysfs.c                    |   31 
>  b/drivers/scsi/sd.c                            |   85 -
>  b/fs/bio.c                                     |   26 
> 
> Jens, Jeff: were any of those changes added in the final day or two, not
> included in the trees which I pull?

Reuben, do you have any barrier= options in your fstab for any reiser
file system?

-- 
Jens Axboe

