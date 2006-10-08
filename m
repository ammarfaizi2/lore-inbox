Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWJHB7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWJHB7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 21:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWJHB67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 21:58:59 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:100 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1750709AbWJHB67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 21:58:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FACr3J0WBToo1LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Early keyboard initialization?
Date: Sat, 7 Oct 2006 21:58:54 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
References: <20061006204254.GD5489@bouh.residence.ens-lyon.fr>
In-Reply-To: <20061006204254.GD5489@bouh.residence.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610072158.55659.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 16:42, Samuel Thibault wrote:
> Hi,
> 
> Is there any reason for initializing the input layer and keyboards so
> late?  Since prevents from being able to perform alt-sysrqs early, and
> blind people who use speakup would like to get early control over the
> speech.  Here is the patch that they use.
>

It looks like the change will only work for non-USB input devices since
USB subsystem is initialized much later.

Greg, is there a reason why USB can't be initialized earlier?

Btw, I don't think we need to initialize gameport early and maybe not
entire input but split off input/keyboard in the same fashion that
input/serio and input/gameport are split off.

> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> --- /usr/src/linux-2.6.18/drivers/Makefile.orig	2006-10-06 11:34:15.000000000 -0400
> +++ drivers/Makefile	2006-10-06 11:34:15.000000000 -0400
> @@ -27,6 +27,9 @@
>  
>  obj-y				+= serial/
>  obj-$(CONFIG_PARPORT)		+= parport/
> +obj-$(CONFIG_SERIO)		+= input/serio/
> +obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> +obj-$(CONFIG_INPUT)		+= input/
>  obj-y				+= base/ block/ misc/ mfd/ net/ media/
>  obj-$(CONFIG_NUBUS)		+= nubus/
>  obj-$(CONFIG_ATM)		+= atm/
> @@ -50,9 +53,6 @@
>  obj-$(CONFIG_USB)		+= usb/
>  obj-$(CONFIG_PCI)		+= usb/
>  obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> -obj-$(CONFIG_SERIO)		+= input/serio/
> -obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> -obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_I2O)		+= message/
>  obj-$(CONFIG_RTC_LIB)		+= rtc/
>  obj-$(CONFIG_I2C)		+= i2c/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dmitry
