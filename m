Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSJOUFg>; Tue, 15 Oct 2002 16:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbSJOUFg>; Tue, 15 Oct 2002 16:05:36 -0400
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:8065 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264733AbSJOUFe>;
	Tue, 15 Oct 2002 16:05:34 -0400
Date: Tue, 15 Oct 2002 16:09:46 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       jdthood@yahoo.co.uk, boissiere@nl.linux.org, perex@perex.cz,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
Message-ID: <20021015160946.GD315@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
	jdthood@yahoo.co.uk, boissiere@nl.linux.org, perex@perex.cz,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <20021014135452.GB444@neo.rr.com> <20021014181028.GE7462@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014181028.GE7462@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:10:28AM -0700, Greg KH wrote:
> On Mon, Oct 14, 2002 at 01:54:52PM +0000, Adam Belay wrote:
> >
> >  PNP SUPPORT
> > -P:	Tom Lees
> > -M:	tom@lpsg.demon.co.uk
> > -L:	pnp-users@ferret.lmh.ox.ac.uk
> > -L:	pnp-devel@ferret.lmh.ox.ac.uk
> > -W:	http://www-jcr.lmh.ox.ac.uk/~pnp/
> > +P:	Adam Belay
> > +M:	ambx1@neo.rr.com
> >  S:	Maintained
>
> Any word from the people I pointed you at last time?

This would be the first time I sent it to them.

>
> > +#ifdef __PNP__
>
> No, don't redefine CONFIG variables.  What's wrong with using
> CONFIG_PNP?

Ok I'll use CONFIG_PNP instead.  Thanks for pointing this out.

>
>
> > +static const struct pnp_id pnp_dev_table[] = {
> > +	/* Standard LPT Printer Port */
> > +	{	"PNP0400",		0	},
>
> Using named initializers are preferred.

I'm not quite sure what you mean here.

>
> > +	/* ECP Printer Port */
> > +	{	"PNP0401",		0	},
> > +	{	"",			0	}
> > +};
> > +
> > +/* we only need the pnp layer to activate the device, at least for now */
> > +static struct pnp_driver parport_pc_pnp_driver = {
> > +	.name		= "parport_pc",
> > +	.card_id_table	= NULL,
> > +	.id_table	= pnp_dev_table,
> > +};
> > +#endif
> > +
> >  /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
> >  static int __init __attribute__((unused))
> >  parport_pc_find_isa_ports (int autoirq, int autodma)
> > @@ -3020,6 +3038,10 @@
> >
> >  int __init parport_pc_init (int *io, int *io_hi, int *irq, int *dma)
> >  {
> > +#ifdef __PNP__
> > +	/* try to activate any PnP parports first */
> > +	pnp_register_driver(&parport_pc_pnp_driver);
> > +#endif
>
> pnp_register_driver() should be implemented so that you don't need a
> #ifdef around it to call it.  Put the #ifdef in the header file.

Actually pnp_register_driver is implemented in this way.  The reason it
has #ifdef around it is becuase of the previous #ifdef statement
(where parport_pc_pnp_driver is defined).

Also I had a hotplug related question?  Is it possible for pnp drivers
to use this and if so what do I need to do?

MODULE_DEVICE_TABLE(pnp, pnp_dev_table);


These comments have been very helpful.

Thanks,
Adam

