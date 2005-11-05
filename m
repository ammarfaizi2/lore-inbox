Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVKESmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVKESmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVKESmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:42:46 -0500
Received: from ruth.realtime.net ([205.238.132.69]:15890 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S932195AbVKESmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:42:44 -0500
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40564dc5fa508b27c752b692f93562f4@bga.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH]: linux-2.6.14-uc0 (MMU-less support)
Date: Sat, 5 Nov 2005 12:42:42 -0600
To: gerg@uclinux.org
X-Mailer: Apple Mail (2.623)
X-Server: High Performance Mail Server - http://surgemail.com r=-224271992
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 01 2005 - 23:01:02 EST, Greg Ungerer wrote:

> Hi All,
>
>  An update of the uClinux (MMU-less) fixups against 2.6.14.
>
>  Some new platform support, for the 5207/5208 ColdFire parts.
>  A few bug fixes and some other minor cleanups.
>
> http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.14- 
> uc0.patch.gz

Hi Greg.

I'm not a user but thought I would give it a once over to see what you  
were carrying.


>  /*
> + *	The Freescale 5208EVB board has 32MB of RAM.
> + */
> +#if defined(CONFIG_M5208EVB)
> +#define	RAM_START	0x40020000
> +#define	RAM_LENGTH	0x01e00000
> +#endif
> +
> +/*

That doesn't quite add up to 32MB.  Should that be 0x1FE0000 or
is the last 0x1E0000 (1920k) supposed to be reserved too?  Again,
I am not a user.

> diff -Naur linux-2.6.14/drivers/net/Kconfig  
> linux-2.6.14-uc0/drivers/net/Kconfig
> --- linux-2.6.14/drivers/net/Kconfig	2005-10-31 15:39:46.000000000  
> +1000
> +++ linux-2.6.14-uc0/drivers/net/Kconfig	2005-10-31 15:41:58.000000000  
> +1000
> @@ -730,7 +730,7 @@
>
>  config NET_VENDOR_SMC
>  	bool "Western Digital/SMC cards"
> -	depends on NET_ETHERNET && (ISA || MCA || EISA || MAC)
> +	depends on NET_ETHERNET && (ISA || MCA || EISA || MAC || EMBEDDED)
>  	help
>  	  If you have a network (Ethernet) card belonging to this class, say  
> Y
>  	  and read the Ethernet-HOWTO, available from
> @@ -820,7 +820,7 @@
>
>  config SMC9194
>  	tristate "SMC 9194 support"
> -	depends on NET_VENDOR_SMC && (ISA || MAC && BROKEN)
> +	depends on NET_VENDOR_SMC && (ISA || MAC && BROKEN || EMBEDDED)
>  	select CRC32
>  	---help---
>  	  This is support for the SMC9xxx based Ethernet cards. Choose this
> @@ -1059,7 +1059,7 @@
>
>  config NE2000
>  	tristate "NE2000/NE1000 support"
> -	depends on NET_ISA || (Q40 && m) || M32R
> +	depends on NET_ISA || (Q40 && m) || M32R || EMBEDDED
>  	select CRC32
>  	---help---
>  	  If you have a network (Ethernet) card of this type, say Y and read
> @@ -1190,7 +1190,7 @@
>
>  config NET_PCI
>  	bool "EISA, VLB, PCI and on board controllers"
> -	depends on NET_ETHERNET && (ISA || EISA || PCI)
> +	depends on NET_ETHERNET && (ISA || EISA || PCI || EMBEDDED)
>  	help
>  	  This is another class of network cards which attach directly to the
>  	  bus. If you have one of those, say Y and read the Ethernet-HOWTO,
>

Lots of people turn on EMBEDDED for lots of reasons, asking about
a lot more drivers seems burdensome.

Care to create a single intermediate Kconfig var for those?
Something like "Controllers attached directly to a cpu?"


> +config CS89x0_SWAPPED
> +	bool "Hardware swapped CS89x0"
> +	depends on CS89x0 && !NET_PCI && !ISA
> +	---help---
> +	  Say Y if your CS89x0 data bus is swapped.
> +	  This option is for single board computers using a CS89x0 chip. If  
> you
> +	  are using a regular Ethernet card, say N.
> +
>

This would then depend on your directly attached config and you
could have both it and pci configured.

>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> -CFLAGS		+= -Os
> +CFLAGS		+= -O
>  else
>  CFLAGS		+= -O2
>  endif

Sees this undoes part of the benefit, perhaps you should add a
third option.

milton

