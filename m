Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268759AbTBZOlt>; Wed, 26 Feb 2003 09:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268760AbTBZOlt>; Wed, 26 Feb 2003 09:41:49 -0500
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:46212 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S268759AbTBZOlr>; Wed, 26 Feb 2003 09:41:47 -0500
Date: Wed, 26 Feb 2003 15:50:14 +0100 (CET)
From: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] Re: 2.5.63 : Compile failure in ne driver
In-Reply-To: <20030225165417.GO7685@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0302261548580.1327-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Adrian Bunk wrote:

> On Tue, Feb 25, 2003 at 12:20:52AM +0100, Martijn Uffing wrote:
> 
> > Ave people
> 
> Hi Martijn,
> 
> > 2.5.63 won't compile for me.
> > In my .config I  got PNP selected but ISAPNP not. 
> > 
> > This because I  have a 
> > -PCI pnp sound card
> > -ISA nopnp ne2000 clone network card.
> > 
> > Greetz Mu
> > 
> > make -f scripts/Makefile.build obj=drivers/net
> >   gcc -Wp,-MD,drivers/net/.ne.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ne -DKBUILD_MODNAME=ne -c -o drivers/net/ne.o drivers/net/ne.c
> > drivers/net/ne.c: In function `ne_probe_isapnp':
> > drivers/net/ne.c:208: too many arguments to function `pnp_activate_dev'
> > make[2]: *** [drivers/net/ne.o] Error 1
> > make[1]: *** [drivers/net] Error 2
> > make: *** [drivers] Error 2
> >...
> 
> please try the following patch:
> 
> --- linux-2.5.63-notfull/drivers/net/ne.c.old	2003-02-25 17:50:25.000000000 +0100
> +++ linux-2.5.63-notfull/drivers/net/ne.c	2003-02-25 17:50:41.000000000 +0100
> @@ -205,7 +205,7 @@
>  			/* Avoid already found cards from previous calls */
>  			if (pnp_device_attach(idev) < 0)
>  				continue;
> -			if (pnp_activate_dev(idev, NULL) < 0) {
> +			if (pnp_activate_dev(idev) < 0) {
>  			      	pnp_device_detach(idev);
>  			      	continue;
>  			}
> 
> 
> cu
> Adrian
> 
> 


Thanx for the patch.
It works and it's now in Linus' tree.

Greetz Mu

