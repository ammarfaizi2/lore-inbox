Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUJJIPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUJJIPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUJJIPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 04:15:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54252 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268197AbUJJIPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 04:15:01 -0400
Date: Sun, 10 Oct 2004 10:14:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041010081455.GB14636@suse.de>
References: <20041005142001.GR2433@suse.de> <200410100242.39249.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410100242.39249.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10 2004, Bartlomiej Zolnierkiewicz wrote:
> > --- drivers/ide/ide-dma.c~	2004-10-05 16:11:49.631910586 +0200
> > +++ drivers/ide/ide-dma.c	2004-10-05 16:21:58.828330845 +0200
> > @@ -354,11 +355,13 @@
> >  	struct hd_driveid *id = drive->id;
> >  	ide_hwif_t *hwif = HWIF(drive);
> >  
> > -	if ((id->capability & 1) && hwif->autodma) {
> > -		/* Consult the list of known "bad" drives */
> > -		if (__ide_dma_bad_drive(drive))
> > -			return __ide_dma_off(drive);
> > +	/* Consult the list of known "bad" drives */
> > +	if (__ide_dma_bad_drive(drive)) {
> > +		__ide_dma_off(drive);
> > +		return 1;
> > +	}
> >  
> > +	if ((id->capability & 1) && hwif->autodma) {
> >  		/*
> >  		 * Enable DMA on any drive that has
> >  		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
> 
> Is __ide_dma_bad_drive() check still needed?
> Doesn't __ide_dma_on() fix handle this now?

Yeah, we can solely rely on that if we so wish.

-- 
Jens Axboe

