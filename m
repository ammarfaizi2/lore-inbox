Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbTBYQoJ>; Tue, 25 Feb 2003 11:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268038AbTBYQoJ>; Tue, 25 Feb 2003 11:44:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14795 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268034AbTBYQoI>; Tue, 25 Feb 2003 11:44:08 -0500
Date: Tue, 25 Feb 2003 17:54:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] Re: 2.5.63 : Compile failure in ne driver
Message-ID: <20030225165417.GO7685@fs.tum.de>
References: <Pine.LNX.4.44.0302250013350.16352-100000@cam029208.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302250013350.16352-100000@cam029208.student.utwente.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:20:52AM +0100, Martijn Uffing wrote:

> Ave people

Hi Martijn,

> 2.5.63 won't compile for me.
> In my .config I  got PNP selected but ISAPNP not. 
> 
> This because I  have a 
> -PCI pnp sound card
> -ISA nopnp ne2000 clone network card.
> 
> Greetz Mu
> 
> make -f scripts/Makefile.build obj=drivers/net
>   gcc -Wp,-MD,drivers/net/.ne.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ne -DKBUILD_MODNAME=ne -c -o drivers/net/ne.o drivers/net/ne.c
> drivers/net/ne.c: In function `ne_probe_isapnp':
> drivers/net/ne.c:208: too many arguments to function `pnp_activate_dev'
> make[2]: *** [drivers/net/ne.o] Error 1
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
>...

please try the following patch:

--- linux-2.5.63-notfull/drivers/net/ne.c.old	2003-02-25 17:50:25.000000000 +0100
+++ linux-2.5.63-notfull/drivers/net/ne.c	2003-02-25 17:50:41.000000000 +0100
@@ -205,7 +205,7 @@
 			/* Avoid already found cards from previous calls */
 			if (pnp_device_attach(idev) < 0)
 				continue;
-			if (pnp_activate_dev(idev, NULL) < 0) {
+			if (pnp_activate_dev(idev) < 0) {
 			      	pnp_device_detach(idev);
 			      	continue;
 			}


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

