Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUBHQqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUBHQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:46:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9695 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263903AbUBHQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:46:45 -0500
Date: Sun, 8 Feb 2004 17:46:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 406] Amiga Zorro8390 Ethernet new driver model
Message-ID: <20040208164638.GV7388@fs.tum.de>
References: <200402081528.i18FSUlL027005@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402081528.i18FSUlL027005@callisto.of.borg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 04:28:30PM +0100, Geert Uytterhoeven wrote:
> Zorro8390 Ethernet: Convert to the new driver model
> 
> --- linux-2.6.3-rc1/drivers/net/zorro8390.c	2004-02-08 10:19:44.000000000 +0100
> +++ linux-m68k-2.6.3-rc1/drivers/net/zorro8390.c	2004-02-08 11:42:34.000000000 +0100
>...
> -static int __init zorro8390_probe(void);
> +static int __devinit zorro8390_init_one(struct zorro_dev *z,
> +					const struct zorro_device_id *ent);
>  static int __init zorro8390_init(struct net_device *dev, unsigned long board,
>  				 const char *name, unsigned long ioaddr);
>...
> -static int __init zorro8390_probe(void)
> +static int __devinit zorro8390_init_one(struct zorro_dev *z,
> +					const struct zorro_device_id *ent)
>  {
>...
> +    if ((err = zorro8390_init(dev, board, cards[i].name,
> +			      ZTWO_VADDR(ioaddr)))) {
> +	release_mem_region(ioaddr, NE_IO_EXTENT*2);
> +	free_netdev(dev);
> +	return err;
> +    }
> +    zorro_set_drvdata(z, dev);
> +    return 0;
>  }
>...


__init zorro8390_init called from __devinit zorro8390_init_one ?

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

