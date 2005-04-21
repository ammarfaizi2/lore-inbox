Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVDUUtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVDUUtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVDUUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:49:05 -0400
Received: from [205.233.219.253] ([205.233.219.253]:37311 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261874AbVDUUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:47:58 -0400
Date: Thu, 21 Apr 2005 16:46:25 -0400
From: Jody McIntyre <scjody@steamballoon.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Ben Collins <bcollins@debian.org>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee1394: remove NULL checks prior to kfree in ieee1394, kfree handles null pointers fine.
Message-ID: <20050421204625.GY1111@conscoop.ottawa.on.ca>
References: <Pine.LNX.4.62.0504161748560.2480@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504161748560.2480@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 05:55:19PM +0200, Jesper Juhl wrote:
> This patch removes redundant NULL pointer checks before kfree() in all of drivers/ieee1394/

Thanks, applied to our SVN and queued for 2.6.13.

Jody

> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> ---
> 
>  drivers/ieee1394/nodemgr.c   |    3 +--
>  drivers/ieee1394/ohci1394.c  |    2 +-
>  drivers/ieee1394/video1394.c |   29 ++++++++---------------------
>  3 files changed, 10 insertions(+), 24 deletions(-)
> 
> 
> diff -upr linux-2.6.12-rc2-mm3-orig/drivers/ieee1394/nodemgr.c linux-2.6.12-rc2-mm3/drivers/ieee1394/nodemgr.c
> --- linux-2.6.12-rc2-mm3-orig/drivers/ieee1394/nodemgr.c	2005-04-11 21:20:41.000000000 +0200
> +++ linux-2.6.12-rc2-mm3/drivers/ieee1394/nodemgr.c	2005-04-16 17:44:23.000000000 +0200
> @@ -1006,8 +1006,7 @@ static struct unit_directory *nodemgr_pr
>  	return ud;
>  
>  unit_directory_error:
> -	if (ud != NULL)
> -		kfree(ud);
> +	kfree(ud);
>  	return NULL;
>  }
>  
> diff -upr linux-2.6.12-rc2-mm3-orig/drivers/ieee1394/ohci1394.c linux-2.6.12-rc2-mm3/drivers/ieee1394/ohci1394.c
> --- linux-2.6.12-rc2-mm3-orig/drivers/ieee1394/ohci1394.c	2005-04-05 21:21:24.000000000 +0200
> +++ linux-2.6.12-rc2-mm3/drivers/ieee1394/ohci1394.c	2005-04-16 17:44:48.000000000 +0200
> @@ -2893,7 +2893,7 @@ static void free_dma_rcv_ctx(struct dma_
>  		kfree(d->prg_cpu);
>  		kfree(d->prg_bus);
>  	}
> -	if (d->spb) kfree(d->spb);
> +	kfree(d->spb);
>  
>  	/* Mark this context as freed. */
>  	d->ohci = NULL;
> diff -upr linux-2.6.12-rc2-mm3-orig/drivers/ieee1394/video1394.c linux-2.6.12-rc2-mm3/drivers/ieee1394/video1394.c
> --- linux-2.6.12-rc2-mm3-orig/drivers/ieee1394/video1394.c	2005-04-11 21:20:41.000000000 +0200
> +++ linux-2.6.12-rc2-mm3/drivers/ieee1394/video1394.c	2005-04-16 17:47:03.000000000 +0200
> @@ -180,23 +180,13 @@ static int free_dma_iso_ctx(struct dma_i
>  		kfree(d->prg_reg);
>  	}
>  
> -	if (d->ir_prg)
> -		kfree(d->ir_prg);
> -
> -	if (d->it_prg)
> -		kfree(d->it_prg);
> -
> -	if (d->buffer_status)
> -		kfree(d->buffer_status);
> -	if (d->buffer_time)
> -		kfree(d->buffer_time);
> -	if (d->last_used_cmd)
> -		kfree(d->last_used_cmd);
> -	if (d->next_buffer)
> -		kfree(d->next_buffer);
> -
> +	kfree(d->ir_prg);
> +	kfree(d->it_prg);
> +	kfree(d->buffer_status);
> +	kfree(d->buffer_time);
> +	kfree(d->last_used_cmd);
> +	kfree(d->next_buffer);
>  	list_del(&d->link);
> -
>  	kfree(d);
>  
>  	return 0;
> @@ -1060,8 +1050,7 @@ static int __video1394_ioctl(struct file
>  			PRINT(KERN_ERR, ohci->host->id,
>  			      "Buffer %d is already used",v.buffer);
>  			spin_unlock_irqrestore(&d->lock,flags);
> -			if (psizes)
> -				kfree(psizes);
> +			kfree(psizes);
>  			return -EBUSY;
>  		}
>  
> @@ -1116,9 +1105,7 @@ static int __video1394_ioctl(struct file
>  			}
>  		}
>  
> -		if (psizes)
> -			kfree(psizes);
> -
> +		kfree(psizes);
>  		return 0;
>  
>  	}
> 
> 
> 
> -- 
> Jesper Juhl
> 
> PS. Please CC: me on replies as I'm not subscribed to the linux1394-devel list.
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
