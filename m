Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbSJNSEW>; Mon, 14 Oct 2002 14:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSJNSEV>; Mon, 14 Oct 2002 14:04:21 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7686 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262081AbSJNSEU>;
	Mon, 14 Oct 2002 14:04:20 -0400
Date: Mon, 14 Oct 2002 11:10:28 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, torvalds@transmeta.com,
       alan@lxorguk.ukuu.org.uk, perex@suse.cz, jdthood@yahoo.co.uk,
       boissiere@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
Message-ID: <20021014181028.GE7462@kroah.com>
References: <20021014135452.GB444@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014135452.GB444@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 01:54:52PM +0000, Adam Belay wrote:
>  
>  PNP SUPPORT
> -P:	Tom Lees
> -M:	tom@lpsg.demon.co.uk
> -L:	pnp-users@ferret.lmh.ox.ac.uk
> -L:	pnp-devel@ferret.lmh.ox.ac.uk
> -W:	http://www-jcr.lmh.ox.ac.uk/~pnp/
> +P:	Adam Belay
> +M:	ambx1@neo.rr.com
>  S:	Maintained

Any word from the people I pointed you at last time?

> +#ifdef __PNP__

No, don't redefine CONFIG variables.  What's wrong with using
CONFIG_PNP?


> +static const struct pnp_id pnp_dev_table[] = {
> +	/* Standard LPT Printer Port */
> +	{	"PNP0400",		0	},

Using named initializers are preferred.

> +	/* ECP Printer Port */
> +	{	"PNP0401",		0	},
> +	{	"",			0	}
> +};
> +
> +/* we only need the pnp layer to activate the device, at least for now */
> +static struct pnp_driver parport_pc_pnp_driver = {
> +	.name		= "parport_pc",
> +	.card_id_table	= NULL,
> +	.id_table	= pnp_dev_table,
> +};
> +#endif
> +
>  /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
>  static int __init __attribute__((unused))
>  parport_pc_find_isa_ports (int autoirq, int autodma)
> @@ -3020,6 +3038,10 @@
>  
>  int __init parport_pc_init (int *io, int *io_hi, int *irq, int *dma)
>  {
> +#ifdef __PNP__
> +	/* try to activate any PnP parports first */
> +	pnp_register_driver(&parport_pc_pnp_driver);
> +#endif

pnp_register_driver() should be implemented so that you don't need a
#ifdef around it to call it.  Put the #ifdef in the header file.

thanks,

greg k-h
