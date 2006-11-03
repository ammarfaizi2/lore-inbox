Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752962AbWKCC11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbWKCC11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbWKCC11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:27:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63498 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752960AbWKCC1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:27:25 -0500
Date: Fri, 3 Nov 2006 03:27:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, akpm@osdl.org,
       zippel@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061103022726.GF13381@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610251922.09692.david-b@pacbell.net> <20061102071507.GB28382@kroah.com> <200611021229.17324.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611021229.17324.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 12:29:12PM -0800, David Brownell wrote:
> On Wednesday 01 November 2006 11:15 pm, Greg KH wrote:
> 
> > Argh, there were just too many different versions of these patches
> > floating around.  Can you resend the final versions please?
> 
> This should replace BOTH of Randy's patches.  It addresses all the
> issues I've heard raised, and resolves the regresssion introduced
> when adding the mcs7830 minidriver.

It seems to lack the "select MII" at the USB_RTL8150 option that was in 
Randy's first patch?

> - Dave
>...
> --- at91.orig/drivers/usb/net/Kconfig	2006-11-02 10:58:49.000000000 -0800
> +++ at91/drivers/usb/net/Kconfig	2006-11-02 12:10:13.000000000 -0800
> @@ -92,8 +92,13 @@ config USB_RTL8150
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rtl8150.
>  
> +config USB_USBNET_MII
> +	tristate
> +	default n
> +
>  config USB_USBNET
>  	tristate "Multi-purpose USB Networking Framework"
> +	select MII if USBNET_MII != n
>  	---help---
>  	  This driver supports several kinds of network links over USB,
>  	  with "minidrivers" built around a common network driver core
> @@ -129,7 +134,7 @@ config USB_NET_AX8817X
>  	tristate "ASIX AX88xxx Based USB 2.0 Ethernet Adapters"
>  	depends on USB_USBNET && NET_ETHERNET
>  	select CRC32
> -	select MII
> +	select USB_USBNET_MII
>  	default y
>  	help
>  	  This option adds support for ASIX AX88xxx based USB 2.0
> @@ -210,6 +215,7 @@ config USB_NET_PLUSB
>  config USB_NET_MCS7830
>  	tristate "MosChip MCS7830 based Ethernet adapters"
>  	depends on USB_USBNET
> +	select USB_USBNET_MII
>  	help
>  	  Choose this option if you're using a 10/100 Ethernet USB2
>  	  adapter based on the MosChip 7830 controller. This includes
> Index: at91/drivers/usb/net/usbnet.c
> ===================================================================
> --- at91.orig/drivers/usb/net/usbnet.c	2006-11-02 10:58:49.000000000 -0800
> +++ at91/drivers/usb/net/usbnet.c	2006-11-02 11:09:29.000000000 -0800
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

