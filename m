Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSK2QwT>; Fri, 29 Nov 2002 11:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbSK2QwT>; Fri, 29 Nov 2002 11:52:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32459 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267111AbSK2QwR>; Fri, 29 Nov 2002 11:52:17 -0500
Date: Fri, 29 Nov 2002 17:59:34 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: carbonated beverage <ramune@net-ronin.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.4.20 kernel link error
Message-ID: <20021129165934.GH6981@fs.tum.de>
References: <20021129150050.GA5136@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129150050.GA5136@net-ronin.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 07:00:50AM -0800, carbonated beverage wrote:

> Anything other info needed?
>...

Thanks for your report, the information you included was sufficient.

> gcc 2.95.4
> binutils 2.12.90.0.1
> Debian/woody
> Linux 2.4.20
> 
> drivers/net/pcmcia/pcmcia_net.o: In function `smc_link_ok':
> drivers/net/pcmcia/pcmcia_net.o(.text+0x280c): undefined reference to `mii_link_ok'
> drivers/net/pcmcia/pcmcia_net.o: In function `smc_ethtool_ioctl':
> drivers/net/pcmcia/pcmcia_net.o(.text+0x29ce): undefined reference to `mii_ethtool_gset'
> drivers/net/pcmcia/pcmcia_net.o(.text+0x2a7d): undefined reference to `mii_ethtool_sset'
> drivers/net/pcmcia/pcmcia_net.o(.text+0x2b1c): undefined reference to `mii_nway_restart'
> drivers/net/pcmcia/pcmcia_net.o: In function `smc_ioctl':
> drivers/net/pcmcia/pcmcia_net.o(.text+0x2b8d): undefined reference to `generic_mii_ioctl'
>...
> CONFIG_PCMCIA_SMC91C92=y
>...

I already sent a patch for this for 2.5 but I didn't know the problem
also exists in 2.4. The following patch fixes it:

--- linux-2.4.20-test/drivers/net/Makefile.old	2002-11-29 17:46:47.000000000 +0100
+++ linux-2.4.20-test/drivers/net/Makefile	2002-11-29 17:47:22.000000000 +0100
@@ -122,6 +122,7 @@
 obj-$(CONFIG_MAC8390) += daynaport.o 8390.o
 obj-$(CONFIG_APNE) += apne.o 8390.o
 obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
+obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
 obj-$(CONFIG_SHAPER) += shaper.o
 obj-$(CONFIG_SK_G16) += sk_g16.o
 obj-$(CONFIG_HP100) += hp100.o


Zwane changed this driver to use the MII support library but he
accidentially forgot that this requires mii.o.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

