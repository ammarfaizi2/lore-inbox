Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbUATPdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUATPdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:33:32 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:983 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265567AbUATPc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:32:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] 2.6.1-mm5: compile error with IDE legacy driver
Date: Tue, 20 Jan 2004 16:37:09 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040120000535.7fb8e683.akpm@osdl.org> <20040120132011.GB12027@fs.tum.de>
In-Reply-To: <20040120132011.GB12027@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401201637.09711.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, my fault.  Thanks!

On Tuesday 20 of January 2004 14:20, Adrian Bunk wrote:
> On Tue, Jan 20, 2004 at 12:05:35AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.1-mm4:
> >...
> > -modular-ide-is-broken.patch
> > +fix-improve-modular-ide.patch
> >
> >  Make IDE work as a module again.
> >...
>
> I got the following compile error:
>
> <--  snip  -->
>
> ...
>   CC      drivers/ide/ide-pnp.o
> make[2]: *** No rule to make target `drivers/ide/pdc4030.s', needed by
> `drivers/ide/pdc4030.o'.  Stop.
> make[1]: *** [drivers/ide] Error 2
>
> <--  snip  -->
>
> The patch below fixes this problem.
>
> cu
> Adrian
>
>
> --- linux-2.6.1-mm5/drivers/ide/Makefile.old	2004-01-20 13:39:23.000000000
> +0100 +++ linux-2.6.1-mm5/drivers/ide/Makefile	2004-01-20
> 13:40:04.000000000 +0100 @@ -23,18 +23,18 @@
>  ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
>
>  # built-in only drivers from legacy/
> -ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
> -ide-core-$(CONFIG_BLK_DEV_PDC4030)	+= pdc4030.o
> -ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= buddha.o
> -ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
> -ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= gayle.o
> -ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= macide.o
> -ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
> +ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
> +ide-core-$(CONFIG_BLK_DEV_PDC4030)	+= legacy/pdc4030.o
> +ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= legacy/buddha.o
> +ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= legacy/falconide.o
> +ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= legacy/gayle.o
> +ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= legacy/macide.o
> +ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= legacy/q40ide.o
>
>  # built-in only drivers from ppc/
> -ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
> -ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= pmac.o
> -ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= swarm.o
> +ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
> +ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
> +ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= ppc/swarm.o
>
>  obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
>  obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o

