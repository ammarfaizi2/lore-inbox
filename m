Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUBHSrS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 13:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBHSrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 13:47:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53465 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264359AbUBHSrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 13:47:15 -0500
Date: Sun, 8 Feb 2004 19:47:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 405] Amiga Hydra Ethernet new driver model
Message-ID: <20040208184705.GW7388@fs.tum.de>
References: <200402081528.i18FSTrV026999@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402081528.i18FSTrV026999@callisto.of.borg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 04:28:29PM +0100, Geert Uytterhoeven wrote:
> Hydra Ethernet: Convert to the new driver model
> 
> --- linux-2.6.3-rc1/drivers/net/hydra.c	2004-02-08 10:19:34.000000000 +0100
> +++ linux-m68k-2.6.3-rc1/drivers/net/hydra.c	2004-02-08 11:47:55.000000000 +0100
>...
> -static int __init hydra_init(unsigned long board);
> +static int __devinit hydra_init_one(struct zorro_dev *z,
> +				    const struct zorro_device_id *ent);
> +static int __init hydra_init(struct zorro_dev *z);
>...
> +static int __devinit hydra_init_one(struct zorro_dev *z,
> +				    const struct zorro_device_id *ent)
> +{
> +    int err;
>  
> -    return err;
> +    if (!request_mem_region(z->resource.start, 0x10000, "Hydra"))
> +	return -EBUSY;
> +    if ((err = hydra_init(z))) {
> +	release_mem_region(z->resource.start, 0x10000);
> +	return -EBUSY;
> +    }
> +    return 0;
>  }
>...

__init hydra_init called from __devinit hydra_init_one ?

This will break when compiling the driver statically into a kernel with
CONFIG_HOTPLUG=y .


> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

