Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274838AbTGaRqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274839AbTGaRqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:46:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:11282 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S274838AbTGaRp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:45:59 -0400
Date: Thu, 31 Jul 2003 19:45:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Stephen Hemminger <shemminger@osdl.org>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reorganize USB submenu's
In-Reply-To: <20030731101144.32a3f0d7.shemminger@osdl.org>
Message-ID: <Pine.LNX.4.44.0307311940270.717-100000@serv>
References: <20030731101144.32a3f0d7.shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Jul 2003, Stephen Hemminger wrote:

> diff -Nru a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> --- a/drivers/usb/gadget/Kconfig	Thu Jul 31 10:07:11 2003
> +++ b/drivers/usb/gadget/Kconfig	Thu Jul 31 10:07:11 2003
> @@ -6,9 +6,12 @@
>  # for 2.5 kbuild, drivers/usb/gadget/Kconfig
>  # source this at the end of drivers/usb/Kconfig
>  #
> -menuconfig USB_GADGET
> +menu "USB Gadgets"
> +	depends on USB!=n
> +
> +config USB_GADGET
>  	tristate "Support for USB Gadgets"
> -	depends on EXPERIMENTAL
> +	depends on USB && EXPERIMENTAL
>  	help
>  	   USB is a master/slave protocol, organized with one master
>  	   host (such as a PC) controlling up to 127 peripheral devices.

Why do you remove the menuconfig?
USB_GADGET is independent of USB.

> diff -Nru a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
> --- a/drivers/usb/input/Kconfig	Thu Jul 31 10:07:11 2003
> +++ b/drivers/usb/input/Kconfig	Thu Jul 31 10:07:11 2003
> @@ -1,8 +1,10 @@
>  #
>  # USB Input driver configuration
>  #
> -comment "USB Human Interface Devices (HID)"
> -	depends on USB
> +menu "USB Input devices"
> +
> +comment "Input core support is needed for USB HID input layer or HIDBP support"
> +	depends on USB && INPUT=n
>  
>  config USB_HID
>  	tristate "USB Human Interface Device (full HID) support"

The menu needs to depend on USB otherwise you'll have empty menus if USB 
is disabled (the same is true for storage/media/net).

bye, Roman

