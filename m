Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319636AbSH2Xi3>; Thu, 29 Aug 2002 19:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319637AbSH2Xi3>; Thu, 29 Aug 2002 19:38:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35292 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319636AbSH2Xi1>; Thu, 29 Aug 2002 19:38:27 -0400
Date: Fri, 30 Aug 2002 01:42:49 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       Michael Obster <michael.obster@bingo-ev.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Compiling 2.5.32
In-Reply-To: <3D6EAD3B.6030108@mandrakesoft.com>
Message-ID: <Pine.NEB.4.44.0208300138120.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Jeff Garzik wrote:

> > Jeff Garzik doesn't want 1. until "someone actually tells me they are
> > trying to hot-plug such a card" and he didn't apply the following patch to
> > #ifdef the .remove away if the driver is compiled statically into the
> > kernel:
> >
> >
> > --- drivers/net/tulip/de2104x.c.old	2002-08-30 01:06:09.000000000 +0200
> > +++ drivers/net/tulip/de2104x.c	2002-08-30 01:06:45.000000000 +0200
> > @@ -2216,7 +2216,9 @@
> >  	.name		= DRV_NAME,
> >  	.id_table	= de_pci_tbl,
> >  	.probe		= de_init_one,
> > +#ifdef MODULE
> >  	.remove		= de_remove_one,
> > +#endif
> >  #ifdef CONFIG_PM
> >  	.suspend	= de_suspend,
> >  	.resume		= de_resume,
>
>
> You missed my recent message, I think.
>
> Currently in 2.5.x, you should be able to replace that #ifdef with
> __devexit_p -- without changing the de_remove_one prototype.  I updated
> the definition of __devexit_p in 2.5.30 or so.

>From include/linux/init.h in 2.5.32:

<--  snip  -->

...
#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x
#else
#define __devexit_p(x) NULL
#endif
...

<--  snip  -->


With the .config of Michael a __devexit_p in de2104x.c doesn't help
because CONFIG_HOTPLUG is defined...


> 	Jeff



cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


