Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSKZVS0>; Tue, 26 Nov 2002 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSKZVS0>; Tue, 26 Nov 2002 16:18:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1489 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261292AbSKZVSX>; Tue, 26 Nov 2002 16:18:23 -0500
Date: Tue, 26 Nov 2002 22:25:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andika Triwidada <andika@research.indocisc.com>
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] drivers/net/Makefile
Message-ID: <20021126212532.GC21307@fs.tum.de>
References: <20021103053017.GB29448@research.indocisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103053017.GB29448@research.indocisc.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:30:17PM +0700, Andika Triwidada wrote:
> This patch will allow 2.5.45 make modules_install
> I'm not sure the best way to say that drivers/net/pcmcia/smc91c92_cs.c
> needs exports from drivers/net/mii.c. But at least this modification
> allows my kernel compile error free.
> 
> 
> --- linux-2.5.44/drivers/net/Makefile.orig	2002-10-19 11:01:19.000000000 +0700
> +++ linux-2.5.44/drivers/net/Makefile	2002-11-02 22:00:02.000000000 +0700
> @@ -78,7 +78,7 @@
>  obj-$(CONFIG_NET_SB1000) += sb1000.o
>  obj-$(CONFIG_MAC8390) += daynaport.o 8390.o
>  obj-$(CONFIG_APNE) += apne.o 8390.o
> -obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
> +obj-$(CONFIG_PCMCIA_PCNET) += 8390.o mii.o
>  obj-$(CONFIG_SHAPER) += shaper.o
>  obj-$(CONFIG_SK_G16) += sk_g16.o
>  obj-$(CONFIG_HP100) += hp100.o


It has definitely nothing to do with CONFIG_PCMCIA_PCNET.

The following (untested) patch should be correct:

--- linux-2.5.49/drivers/net/Makefile.old	2002-11-26 22:20:27.000000000 +0100
+++ linux-2.5.49/drivers/net/Makefile	2002-11-26 22:21:34.000000000 +0100
@@ -79,6 +79,7 @@
 obj-$(CONFIG_MAC8390) += mac8390.o 8390.o
 obj-$(CONFIG_APNE) += apne.o 8390.o
 obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
+obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
 obj-$(CONFIG_SHAPER) += shaper.o
 obj-$(CONFIG_SK_G16) += sk_g16.o
 obj-$(CONFIG_HP100) += hp100.o


> -- andika

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

