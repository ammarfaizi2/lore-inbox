Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTEaX1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 19:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTEaX1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 19:27:50 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:7642 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264494AbTEaX1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 19:27:46 -0400
Message-ID: <3ED93D30.4070704@pacbell.net>
Date: Sat, 31 May 2003 16:39:28 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.5 patch] let USB_GADGET depend on USB
References: <20030531221855.GM29425@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> USB_GADGET is still selectable even with USB disabled. It seems the 
> following is intended:

This is wrong.

CONFIG_USB has always represented the master/host side ... while
CONFIG_USB_GADGET represents just the slave/gadget side.

The two are completely independent.  Hardware that supports
one will typically _not_ support the other.  And systems
that support the slave/gadget side will have no use at all
for the 100KB+ of "usbcore".


If you want CONFIG_USB_GADGET to depend on USB, then you're
going to need to change the meaning of CONFIG_USB so that it
becomes just an "umbrella" ... and change EVERYTHING that
currently depends on CONFIG_USB to depend on some new config
varaible representing just the host side (which also depends
on CONFIG_USB).  That sort of change seems pointless.





> --- linux-2.5.70-mm3/drivers/usb/gadget/Kconfig.old	2003-06-01 00:15:30.000000000 +0200
> +++ linux-2.5.70-mm3/drivers/usb/gadget/Kconfig	2003-06-01 00:15:49.000000000 +0200
> @@ -8,7 +8,7 @@
>  #
>  menuconfig USB_GADGET
>  	tristate "Support for USB Gadgets"
> -	depends on EXPERIMENTAL
> +	depends on USB && EXPERIMENTAL
>  	help
>  	   USB is a master/slave protocol, organized with one master
>  	   host (such as a PC) controlling up to 127 peripheral devices.
> 
> 
> 
> cu
> Adrian
> 



