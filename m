Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUHIGeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUHIGeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHIGeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 02:34:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1678 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266161AbUHIGeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 02:34:00 -0400
Date: Mon, 9 Aug 2004 08:33:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Stefan Meyknecht <sm0407@nurfuerspam.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Message-ID: <20040809063323.GB10418@suse.de>
References: <200408061833.30751.sm0407@nurfuerspam.de> <20040806220654.5e857bed.akpm@osdl.org> <20040807083835.GA24860@suse.de> <200408071412.17411.sm0407@nurfuerspam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408071412.17411.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07 2004, Stefan Meyknecht wrote:
> Jens Axboe <axboe@suse.de> wrote:
> > drive. If you could look into why that isn't set for your mo device
> > and send a patch for that, it would be much better.
> 
> Assuming mo devices can do random writing, how about this patch:
> 
> --- linux/drivers/cdrom/cdrom.c.orig	2004-08-07 14:02:28.958908544 +0200
> +++ linux/drivers/cdrom/cdrom.c	2004-08-07 13:58:29.306167698 +0200
> @@ -833,8 +833,11 @@ static int cdrom_open_write(struct cdrom
>  	if (!cdrom_is_mrw(cdi, &mrw_write))
>  		mrw = 1;
>  
> -	(void) cdrom_is_random_writable(cdi, &ram_write);
> -
> +	if (CDROM_CAN(CDC_MO_DRIVE))
> +		ram_write = 1;
> +	else
> +		(void) cdrom_is_random_writable(cdi, &ram_write);
> +	
>  	if (mrw)
>  		cdi->mask &= ~CDC_MRW;
>  	else
> @@ -855,7 +858,7 @@ static int cdrom_open_write(struct cdrom
>  	else if (CDROM_CAN(CDC_DVD_RAM))
>  		ret = cdrom_dvdram_open_write(cdi);
>   	else if (CDROM_CAN(CDC_RAM) &&
> - 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW))
> + 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
>   		ret = cdrom_ram_open_write(cdi);
>  	else if (CDROM_CAN(CDC_MO_DRIVE))
>  		ret = mo_open_write(cdi);

Patch looks fine (last hunk is a little code, but that's not your
fault). Thanks!

-- 
Jens Axboe

