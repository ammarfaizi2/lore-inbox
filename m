Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSG0Ozt>; Sat, 27 Jul 2002 10:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSG0Ozt>; Sat, 27 Jul 2002 10:55:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51450 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317450AbSG0Ozs>; Sat, 27 Jul 2002 10:55:48 -0400
Date: Sat, 27 Jul 2002 16:59:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] make de2104x hotplugable
In-Reply-To: <3D42ABF5.5050600@mandrakesoft.com>
Message-ID: <Pine.NEB.4.44.0207271654510.9592-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, Jeff Garzik wrote:

> > since drivers/net/tulip/de2104x.c does currently not compile in 2.5.29 due
> > to a .text.exit error when the driver is compiled into a kernel without
> > hotplug support I'm wondering whether the patch below would be correct to
> > make this PCI driver hotpluggable. Is my approach to change __init to
> > __devinit and __exit to __devexit correct or is there something I've
> > overseen?
>
>
> This driver is intentionally not hot-pluggable.  I'll convert when
> someone actually tells me they are trying to hot-plug such a card.

It's OK for me not to make it hot-pluggable, but in this case you need the
following patch to make it possible to compile the driver statically into
the kernel (currently it fails with a .text.exit error at the final
linking):

--- drivers/net/tulip/de2104x.c.old	Sun May 12 13:55:28 2002
+++ drivers/net/tulip/de2104x.c	Sun May 12 13:56:09 2002
@@ -2216,7 +2216,9 @@
 	name:		DRV_NAME,
 	id_table:	de_pci_tbl,
 	probe:		de_init_one,
+#ifdef MODULE
 	remove:		de_remove_one,
+#endif
 #ifdef CONFIG_PM
 	suspend:	de_suspend,
 	resume:		de_resume,

> > -static int __init de_init (void)
> > +static int __devinit de_init (void)
> >  {
> >  #ifdef MODULE
> >  	printk("%s", version);
> > @@ -2231,7 +2231,7 @@
> >  	return pci_module_init (&de_driver);
> >  }
> >
> > -static void __exit de_exit (void)
> > +static void __devexit de_exit (void)
> >  {
> >  	pci_unregister_driver (&de_driver);
> >  }
>
>
> This is incorrect in any case -- the module init/exit functions are
> always __init and __exit.


Ah thanks, I had the feeling that something was wrong with my patch but I
didn't know what...


> 	Jeff

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

