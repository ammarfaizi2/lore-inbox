Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbULQMJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbULQMJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbULQMJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:09:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16320 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262788AbULQMJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:09:01 -0500
Date: Fri, 17 Dec 2004 13:08:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Rashkae <rashkae@tigershaunt.com>, linux-kernel@vger.kernel.org
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-ID: <20041217120854.GC3140@suse.de>
References: <20041217012014.GA5374@tigershaunt.com> <20041217001315.1b31cf2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217001315.1b31cf2d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17 2004, Andrew Morton wrote:
> Rashkae <rashkae@tigershaunt.com> wrote:
> >
> > I can confirm that Linux Kerenl 2.6.9 still cannot mount a
> >  multi-session DVD if the last session starts at > 2.2 GB.  The
> >  only information on this problem I can find is here:
> > 
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=108827602322464&w=2
> > 
> >  Is there a patch anywhere to address this?
> 
> Please test this.  Jens, could you please check this one?

It looks fine for the case where the tocentry read suceeds, but you
should change the fallback assignment to be lba based as well I think.

> diff -puN drivers/ide/ide-cd.c~ide-cd-unable-to-read-multisession-dvds drivers/ide/ide-cd.c
> --- 25/drivers/ide/ide-cd.c~ide-cd-unable-to-read-multisession-dvds	2004-12-11 22:14:16.629388296 -0800
> +++ 25-akpm/drivers/ide/ide-cd.c	2004-12-11 22:14:16.635387384 -0800
> @@ -2353,7 +2353,7 @@ static int cdrom_read_toc(ide_drive_t *d
>  	/* Read the multisession information. */
>  	if (toc->hdr.first_track != CDROM_LEADOUT) {
>  		/* Read the multisession information. */
> -		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
> +		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
>  					   sizeof(ms_tmp), sense);
>  		if (stat) return stat;
>  	} else {

it's the bottom part of that else.

-- 
Jens Axboe

