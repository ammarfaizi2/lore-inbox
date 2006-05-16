Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWEPJ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWEPJ5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 05:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWEPJ5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 05:57:44 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:1479 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1750727AbWEPJ5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 05:57:44 -0400
Date: Tue, 16 May 2006 10:57:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Frederic Rible <frible@teaser.fr>, Jean-Paul Roubelat <jpr@f6fbb.org>,
       linux-hams@vger.kernel.org
Subject: Re: [PATCH] fix potential NULL pointer dereference in yam
Message-ID: <20060516095737.GA23397@linux-mips.org>
References: <200605141512.50923.jesper.juhl@gmail.com> <20060514140946.GA23387@mipter.zuzino.mipt.ru> <200605152219.37265.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152219.37265.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 10:19:36PM +0200, Jesper Juhl wrote:

> > How can it be NULL here? The whole array of valid net_devices was
> > allocated at module init time.
> > 
> 
> It cannot. You are right, I'm wrong.
> I guess removing the check makes sense then ?

Yes.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> --- linux-2.6.17-rc4-mm1-orig/drivers/net/hamradio/yam.c	2006-05-13 21:28:27.000000000 +0200
> +++ linux-2.6.17-rc4-mm1/drivers/net/hamradio/yam.c	2006-05-15 22:16:32.000000000 +0200
> @@ -852,7 +852,7 @@ static int yam_open(struct net_device *d
>  
>  	printk(KERN_INFO "Trying %s at iobase 0x%lx irq %u\n", dev->name, dev->base_addr, dev->irq);
>  
> -	if (!dev || !yp->bitrate)
> +	if (!yp->bitrate)
>  		return -ENXIO;
>  	if (!dev->base_addr || dev->base_addr > 0x1000 - YAM_EXTENT ||
>  		dev->irq < 2 || dev->irq > 15) {
> 

73 de DL5RB op Ralf

--
Loc. JN47BS / CQ 14 / ITU 28 / DOK A21
