Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269029AbUINP1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269029AbUINP1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUINP1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:27:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62124 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269029AbUINPZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:25:25 -0400
Date: Tue, 14 Sep 2004 17:25:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914152509.GA27892@suse.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain> <41470BBD.7060700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41470BBD.7060700@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Jeff Garzik wrote:
> Alan Cox wrote:
> >On Maw, 2004-09-14 at 07:06, Jens Axboe wrote:
> >
> >>Alan, I bet there are a lot of these. Maybe we should consider letting
> >>the user manually flag support for FLUSH_CACHE, at least it is in their
> >>hands then.
> >
> >
> >You are assuming the drive supports "FLUSH_CACHE" just because it
> >doesn't error it. Thats a good way to have accidents. 
> >
> >The patch I posted originally did turn wcache off for barrier if no
> >flush cache support was present but had a small bug so that bit got
> >dropped.
> 
> 
> FWIW the libata test for checking whether it is OK to issue a flush is
> 
>         return ata_id_wcache_enabled(dev) ||
>                ata_id_has_flush(dev) ||
>                ata_id_has_flush_ext(dev);
> 
> and if it passes that test,
> 
>         if ((tf->flags & ATA_TFLAG_LBA48) &&
>             (ata_id_has_flush_ext(qc->dev)))
>                 tf->command = ATA_CMD_FLUSH_EXT;
>         else
>                 tf->command = ATA_CMD_FLUSH;
> 
> I wouldn't object to removing the "ata_id_wcache_enabled" test if people 
> feel that it is unsafe.

Alan says it's unsafe for some of his flash cards, and I do believe they
say they have write caching enabled.

-- 
Jens Axboe

