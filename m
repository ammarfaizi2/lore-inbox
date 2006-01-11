Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWAKLGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWAKLGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWAKLGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:06:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751421AbWAKLGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:06:21 -0500
Date: Wed, 11 Jan 2006 03:05:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: neilb@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15-mm2
Message-Id: <20060111030529.0bc03e0a.akpm@osdl.org>
In-Reply-To: <43C4E2BE.6050800@reub.net>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43BFD8C1.9030404@reub.net>
	<20060107133103.530eb889.akpm@osdl.org>
	<43C38932.7070302@reub.net>
	<20060110104759.GA30546@elte.hu>
	<43C3A85A.7000003@reub.net>
	<20060110044240.3d3aa456.akpm@osdl.org>
	<20060110131618.GA27123@elte.hu>
	<17348.34472.105452.831193@cse.unsw.edu.au>
	<43C4947C.1040703@reub.net>
	<20060110213001.265a6153.akpm@osdl.org>
	<20060110213056.58f5e806.akpm@osdl.org>
	<43C4E2BE.6050800@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> On 11/01/2006 6:30 p.m., Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> >> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >>> I'm tempted to see if I can narrow it down to a specific -gitX release, maybe 
> >>>  that would narrow it down to say, 200 or so patches ;-)
> >> If -mm2 plus -mm2's linus.patch does not fail then
> >> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt will
> >> find the dud patch.
> > 
> > Actually 2.6.15-mm1 would be a better one to do the bisection on: it has
> > all the md- patches separated out.
> 
> I've done some more testing - which may change the suggested approach somewhat..
> 
> 2.6.15-mm1 is OK, I'm running it now, rebooted probably 15 times and it's come 
> up every time.
> 2.6.15-git2 is OK, booted up to completion (tested once).
> 2.6.15-git3 was a dud, bootup hung

Ah.

> 2.6.15- [linus.patch from -mm2, which is basically the same as -git3] won't boot
> 2.6.15-mm2 doesn't boot either, tested many times
> 2.6.15-git6 won't boot
> 2.6.15-git7 got stuck also, same issue
> 
> So some change that went in between -git2 and -git3 seems to have caused it. 
> Nothing from -git3 onwards has ever booted to completion.
> 
> Is there any chance a patch came in, was queued in -mm but was never released in 
> any -mm (1|2) release before being sent to Linus/-gitX?  (in this case, -git3). 

Yes, people sneak stuff in at the last minute.

Neil thinks that an IO got lost.  In the git2->git3 diff we have:

 b/drivers/scsi/Kconfig                         |   10 
 b/drivers/scsi/ahci.c                          |    1 
 b/drivers/scsi/ata_piix.c                      |    5 
 b/drivers/scsi/libata-core.c                   |  145 +
 b/drivers/scsi/libata-scsi.c                   |   48 
 b/drivers/scsi/libata.h                        |    4 
 b/drivers/scsi/sata_mv.c                       |    1 
 b/drivers/scsi/sata_promise.c                  |    1 
 b/drivers/scsi/sata_sil.c                      |    1 
 b/drivers/scsi/sata_sil24.c                    |    1 
 b/drivers/scsi/sata_sx4.c                      |    1 
 b/drivers/scsi/scsi_lib.c                      |   50 
 b/drivers/scsi/scsi_sysfs.c                    |   31 
 b/drivers/scsi/sd.c                            |   85 -
 b/fs/bio.c                                     |   26 

Jens, Jeff: were any of those changes added in the final day or two, not
included in the trees which I pull?


> 
> I'm not sure where this leaves quilt testing.  Would quilt testing just narrow 
> me down to it being the linus.patch in mm which actually caused it? (Which I 
> already know is the source)..

Yes, there's not much point in that.

`git bisect' will find it.

