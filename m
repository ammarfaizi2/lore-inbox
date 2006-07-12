Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWGLVlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWGLVlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWGLVls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:41:48 -0400
Received: from ns.suse.de ([195.135.220.2]:10112 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751435AbWGLVls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:41:48 -0400
Date: Wed, 12 Jul 2006 14:37:23 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resource_size_t and printk()
Message-ID: <20060712213723.GB9049@kroah.com>
References: <44AAD59E.7010206@drzeus.cx> <20060704214508.GA23607@kroah.com> <44AB3DF7.8080107@drzeus.cx> <20060711231537.GC18973@kroah.com> <44B4B041.9050808@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B4B041.9050808@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 10:18:09AM +0200, Pierre Ossman wrote:
> Greg KH wrote:
> > Good catch, care to create a patch to fix these?
> >   
> 
> Included.

> [PNP] Add missing casts in printk() arguments
> 
> Some resource_size_t values are fed to printk() without handling the fact
> that they can have different size depending on your .config.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
> 
>  drivers/pnp/interface.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
> index 3163e3d..0c14f4f 100644
> --- a/drivers/pnp/interface.c
> +++ b/drivers/pnp/interface.c
> @@ -265,8 +265,8 @@ static ssize_t pnp_show_current_resource
>  				pnp_printf(buffer," disabled\n");
>  			else
>  				pnp_printf(buffer," 0x%llx-0x%llx\n",
> -						pnp_port_start(dev, i),
> -						pnp_port_end(dev, i));
> +					(long long)pnp_port_start(dev, i),
> +					(long long)pnp_port_end(dev, i));
>  		}
>  	}
>  	for (i = 0; i < PNP_MAX_MEM; i++) {
> @@ -276,8 +276,8 @@ static ssize_t pnp_show_current_resource
>  				pnp_printf(buffer," disabled\n");
>  			else
>  				pnp_printf(buffer," 0x%llx-0x%llx\n",
> -						pnp_mem_start(dev, i),
> -						pnp_mem_end(dev, i));
> +					(long long)pnp_mem_start(dev, i),
> +					(long long)pnp_mem_end(dev, i));

Like Randy said, please use "unsigned long long".

Care to redo this?

thanks,

greg k-h
