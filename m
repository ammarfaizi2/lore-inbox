Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWCDQ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWCDQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCDQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:58:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55314 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751341AbWCDQ6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:58:44 -0500
Date: Sat, 4 Mar 2006 17:58:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] RTC Subsystem, library functions
Message-ID: <20060304165843.GD9295@stusta.de>
References: <20060304164247.963655000@towertech.it> <20060304164248.171528000@towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304164248.171528000@towertech.it>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 05:42:48PM +0100, Alessandro Zummo wrote:
>...
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-rtc/drivers/rtc/Makefile	2006-02-28 13:16:36.000000000 +0100
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for RTC class/drivers.
> +#
> +
> +ifneq ($(CONFIG_RTC_LIB), n)
> +obj-y			+= rtc-lib.o
> +endif
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-rtc/drivers/rtc/Kconfig	2006-02-28 13:16:36.000000000 +0100
> @@ -0,0 +1,6 @@
> +#
> +# RTC class/drivers configuration
> +#
> +
> +config RTC_LIB
> +	bool
>...

What about

config RTC_LIB
        tristate

and

obj-$(CONFIG_RTC_LIB)   += rtc-lib.o

?


IOW:
Is there anything besides adding a MODULE_LICENSE("GPL"); required for 
allowing an rtc-lib module?


> --- linux-rtc.orig/drivers/Makefile	2006-02-28 13:16:34.000000000 +0100
> +++ linux-rtc/drivers/Makefile	2006-02-28 13:16:36.000000000 +0100
> @@ -56,6 +56,7 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
>  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
>  obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_I2O)		+= message/
> +obj-y				+= rtc/
>...

obj-$(CONFIG_RTC_LIB)	+= rtc/

should be possible since RTC_CLASS select's RTC_LIB.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

