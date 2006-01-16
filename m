Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWAPIil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWAPIil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAPIil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:38:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932240AbWAPIik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:38:40 -0500
Date: Mon, 16 Jan 2006 09:40:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.15-mm4] drivers/cdrom/cdrom.c fix incorrect test
Message-ID: <20060116084026.GM3945@suse.de>
References: <20060114224926.GB26443@ens-lyon.fr> <20060114230453.GC26443@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114230453.GC26443@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15 2006, Benoit Boissinot wrote:
> On Sat, Jan 14, 2006 at 11:49:26PM +0100, Benoit Boissinot wrote:
> > In cleanup-cdrom_ioctl.patch,
> > 
> > the test in CDROMREADTOCENTRY ioctl was changed from
> > 
> > if (!((requested_format == CDROM_MSF) || (requested_format == CDROM_LBA)))
> > 		return -EINVAL;
> > 
> > to
> > 
> > if (requested_format != CDROM_MSF || requested_format != CDROM_LBA)
> > 	return -EINVAL;
> > 
> > which is not equivalent with morgan's law.
> > 
> 
> sorry, it doesn't apply with -p1 correct patch below:
> 
> In cleanup-cdrom_ioctl.patch,
> the test in CDROMREADTOCENTRY ioctl was changed from
> 
> if (!((requested_format == CDROM_MSF) || (requested_format == CDROM_LBA)))
> 		return -EINVAL;
> to
> 
> if (requested_format != CDROM_MSF || requested_format != CDROM_LBA)
> 	return -EINVAL;
> 
> which is not equivalent with morgan's law.
> 
> Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
> 
> diff -Naurp -X Documentation/dontdiff ../linux/drivers/cdrom/cdrom.c drivers/cdrom/cdrom.c
> --- a/drivers/cdrom/cdrom.c	2006-01-14 16:11:43.000000000 +0100
> +++ b/drivers/cdrom/cdrom.c	2006-01-14 23:44:51.000000000 +0100
> @@ -2585,7 +2585,7 @@ static int cdrom_ioctl_read_tocentry(str
>  		return -EFAULT;
>  
>  	requested_format = entry.cdte_format;
> -	if (requested_format != CDROM_MSF || requested_format != CDROM_LBA)
> +	if (requested_format != CDROM_MSF && requested_format != CDROM_LBA)
>  		return -EINVAL;
>  	/* make interface to low-level uniform */
>  	entry.cdte_format = CDROM_MSF;

Good catch, thanks!

-- 
Jens Axboe

