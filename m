Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRARUiZ>; Thu, 18 Jan 2001 15:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135270AbRARUiR>; Thu, 18 Jan 2001 15:38:17 -0500
Received: from argo.starforce.com ([216.158.56.82]:52951 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S132301AbRARUiE>; Thu, 18 Jan 2001 15:38:04 -0500
Date: Thu, 18 Jan 2001 15:36:57 -0500 (EST)
From: Derek Wildstar <dwild@starforce.com>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: (2.4.0->2.4.1-pre8) config problem with PCMCIA causing link
 error
In-Reply-To: <Pine.LNX.4.10.10101181131020.7942-100000@chaos.thphy.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.31.0101181149350.30790-100000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Kai Germaschewski wrote:

> This looks more like a counterexample to what you're saying. Also, I don't
> see how it could happen that CONFIG_PCMCIA_NETCARD=y without
> CONFIG_NET_PCMCIA=y, from looking at the drivers/net/pcmcia/Config.in.
> (It may be still possible somehow because there is CONFIG_NET_PCMCIA=y in
> defconfig).

> Your patch is wrong. It removes the config variable CONFIG_NET_PCMCIA,
> which is referenced in drivers/net/Makefile:
>
> 	subdir-$(CONFIG_NET_PCMCIA) += pcmcia
>
> So the pcmcia net drivers will never be built.

Blah had been working too long yesterday, you're right i got the lines
switched, and therefore screwed up the patch.

> I still don't see what's going wrong with the current code, but it can be
> simplified with the following patch. Does that work for you?

Now it looks like the error was in my .config file.  I failed to do "make
mrproper" after applying the pre8 patch, and ended up with a screwed up
.config.  I just tested after "make mrproper" and it worked without
modifications, after backing out the patch i submitted.  Sorry for the
confusion.

-dwild

> diff -ur linux-2.4.1-pre8/Makefile linux-2.4.1-pre8.work/Makefile
> --- linux-2.4.1-pre8/Makefile	Thu Jan 18 11:21:38 2001
> +++ linux-2.4.1-pre8.work/Makefile	Thu Jan 18 11:23:27 2001
> @@ -155,7 +155,7 @@
>  DRIVERS-$(CONFIG_PCI) += drivers/pci/driver.o
>  DRIVERS-$(CONFIG_MTD) += drivers/mtd/mtdlink.o
>  DRIVERS-$(CONFIG_PCMCIA) += drivers/pcmcia/pcmcia.o
> -DRIVERS-$(CONFIG_PCMCIA_NETCARD) += drivers/net/pcmcia/pcmcia_net.o
> +DRIVERS-$(CONFIG_NET_PCMCIA) += drivers/net/pcmcia/pcmcia_net.o
>  DRIVERS-$(CONFIG_PCMCIA_CHRDEV) += drivers/char/pcmcia/pcmcia_char.o
>  DRIVERS-$(CONFIG_DIO) += drivers/dio/dio.a
>  DRIVERS-$(CONFIG_SBUS) += drivers/sbus/sbus_all.o
> diff -ur linux-2.4.1-pre8/drivers/net/pcmcia/Config.in linux-2.4.1-pre8.work/drivers/net/pcmcia/Config.in
> --- linux-2.4.1-pre8/drivers/net/pcmcia/Config.in	Sun Nov 12 03:56:58 2000
> +++ linux-2.4.1-pre8.work/drivers/net/pcmcia/Config.in	Thu Jan 18 11:23:33 2001
> @@ -32,13 +32,4 @@
>     fi
>  fi
>
> -if [ "$CONFIG_PCMCIA_3C589" = "y" -o "$CONFIG_PCMCIA_3C574" = "y" -o \
> -     "$CONFIG_PCMCIA_FMVJ18X" = "y" -o "$CONFIG_PCMCIA_PCNET" = "y" -o \
> -     "$CONFIG_PCMCIA_NMCLAN" = "y" -o "$CONFIG_PCMCIA_SMC91C92" = "y" -o \
> -     "$CONFIG_PCMCIA_XIRC2PS" = "y" -o "$CONFIG_PCMCIA_RAYCS" = "y" -o \
> -     "$CONFIG_PCMCIA_NETWAVE" = "y" -o "$CONFIG_PCMCIA_WAVELAN" = "y" -o \
> -     "$CONFIG_PCMCIA_XIRTULIP" = "y" ]; then
> -   define_bool CONFIG_PCMCIA_NETCARD y
> -fi
> -
>  endmenu
>
>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
