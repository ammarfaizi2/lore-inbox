Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270468AbTGaR4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270478AbTGaR4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:56:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:9697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270468AbTGaR4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:56:40 -0400
Date: Thu, 31 Jul 2003 10:51:02 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reorganize USB submenu's
Message-ID: <20030731175102.GE3963@kroah.com>
References: <20030731101144.32a3f0d7.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731101144.32a3f0d7.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 10:11:44AM -0700, Stephen Hemminger wrote:
> The USB configuration menu's in 2.6 are a mismash of sub-menu's and comments.
> This patch tries to rationalize it so it comes out looking more like the current
> filesystems menus.
> 
> I think it is easier to navigate, there should be no functional change from this.
> Though some elements may appear/disappear differently based on earlier choices.
> 
> diff -Nru a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> --- a/drivers/usb/Kconfig	Thu Jul 31 10:07:11 2003
> +++ b/drivers/usb/Kconfig	Thu Jul 31 10:07:11 2003
> @@ -44,18 +44,15 @@
>  
>  source "drivers/usb/class/Kconfig"
>  
> -source "drivers/usb/storage/Kconfig"
> -
>  source "drivers/usb/input/Kconfig"
>  
> +source "drivers/usb/storage/Kconfig"
> +
>  source "drivers/usb/image/Kconfig"
>  
>  source "drivers/usb/media/Kconfig"
>  
>  source "drivers/usb/net/Kconfig"
> -
> -comment "USB port drivers"
> -	depends on USB
>  
>  config USB_USS720
>  	tristate "USS720 parport driver"
> diff -Nru a/drivers/usb/class/Kconfig b/drivers/usb/class/Kconfig
> --- a/drivers/usb/class/Kconfig	Thu Jul 31 10:07:11 2003
> +++ b/drivers/usb/class/Kconfig	Thu Jul 31 10:07:11 2003
> @@ -1,9 +1,6 @@
>  #
>  # USB Class driver configuration
>  #
> -comment "USB Device Class drivers"
> -	depends on USB
> -

Why remove these seperators?  They seem to be useful, as they were added
to help remove the clutter we have.

> -menuconfig USB_GADGET
> +menu "USB Gadgets"
> +	depends on USB!=n
> +
> +config USB_GADGET
>  	tristate "Support for USB Gadgets"
> -	depends on EXPERIMENTAL
> +	depends on USB && EXPERIMENTAL

Nope, USB_GADGET does not depend on USB at all.

> -menu "USB HID Boot Protocol drivers"
> -	depends on USB!=n && USB_HID!=y
>  
>  config USB_KBD
>  	tristate "USB HIDBP Keyboard (simple Boot) support"
> -	depends on USB && INPUT
> +	depends on USB && INPUT && USB_HIDINPUT=n

Nope, I can build USB_KBD and USB_HIDINPUT as modules at the same time.
This breaks that ability.


>  config USB_MOUSE
>  	tristate "USB HIDBP Mouse (simple Boot) support"
> -	depends on USB && INPUT
> +	depends on USB && INPUT && USB_HIDINPUT=n

Same thing here.

> -comment "USB Multimedia devices"
> -	depends on USB
> +menu "USB Multimedia devices"

I don't really see a nest of menu options as a better option from the
separators we have today.  But that's just my opinion :)

> -comment "USB Miscellaneous drivers"
> -	depends on USB
> +menu "USB Miscellaneous drivers"
> +	depends on USB!=n

Why "USB!=n"  What's wrong with just "depends on USB"?

thanks,

greg k-h
