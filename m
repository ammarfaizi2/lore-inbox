Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265601AbRF1IsT>; Thu, 28 Jun 2001 04:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbRF1Ir7>; Thu, 28 Jun 2001 04:47:59 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:17833 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S265601AbRF1Irt>; Thu, 28 Jun 2001 04:47:49 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200106280845.KAA20122@sunrise.pg.gda.pl>
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 28 Jun 2001 10:45:55 +0200 (MET DST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), elenstev@mesatop.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3541.993708852@kao2.melbourne.sgi.com> from "Keith Owens" at Jun 28, 2001 04:14:12 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Thu, 28 Jun 2001 00:07:13 -0400, 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Steven Cole wrote:
> >> -   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
> >> +   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI $CONFIG_PCI
> >
> >See the "EISA" and "VLB" parts in there?  EISA != PCI
> 
> Against 2.4.6-pre6.
> 
> Index: 6-pre6.1/drivers/net/Config.in
> --- 6-pre6.1/drivers/net/Config.in Thu, 28 Jun 2001 10:34:32 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.3.1.8 644)
> +++ 6-pre6.1(w)/drivers/net/Config.in Thu, 28 Jun 2001 16:07:03 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.3.1.8 644)
> @@ -142,7 +142,11 @@ if [ "$CONFIG_NET_ETHERNET" = "y" ]; the
>        tristate '  NE/2 (ne2000 MCA version) support' CONFIG_NE2_MCA
>        tristate '  IBM LAN Adapter/A support' CONFIG_IBMLANA
>     fi
> -   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
> +   if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then

CONFIG_EISA check in this condition is redundant.
Intentionally ?

> +     bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
