Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbWHQPWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWHQPWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWHQPWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:22:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52486 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965138AbWHQPWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:22:03 -0400
Date: Thu, 17 Aug 2006 15:21:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH,RFC]: acpi,backlight: MSI S270 - driver, second try
Message-ID: <20060817152101.GD5950@ucw.cz>
References: <20060810162329.GA11603@curacao>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810162329.GA11603@curacao>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Remove /proc/acpi/s270 interface, replace it by a platform device
>   /sys/devices/platform/s270pf/. This means: no procfs is touched
>   anymore, all features are now accessible through /sys/.
> 
> This patch applies to 2.6.17 and requires the ACPI ec_transaction()
> patch I posted earlier:
> 
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115517193511970&w=2
> 
> Please comment and/or apply!

Looks ok to me...

> +static int auto_brightness;
> +module_param(auto_brightness, int, 0);
> +MODULE_PARM_DESC(auto_brightness, "Enable automatic brightness control (0: disabled; 1: enabled; 2: don't touch)");
> +
> +/*** Hardware access ***/
> +
> +static const uint8_t lcd_table[MSI_LCD_LEVEL_MAX] = {
> +        0x00, 0x1f, 0x3e, 0x5d, 0x7c, 0x9b, 0xba, 0xd9, 0xf8
> +};

Can we get 0xf8 levels and simplify code while we are at it?

> +        if ((result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1, &rdata, 1)) < 0)
> +                return result;

Please split this into two lines.

result = ...;
if (result.....)


> +static DEVICE_ATTR(bluetooth, 0444, show_bluetooth, NULL);
> +static DEVICE_ATTR(wlan, 0444, show_wlan, NULL);

So bluetooth and wlan basically mirror physical switch state? Should
we make these switches available through input subsystem one day?
-- 
Thanks for all the (sleeping) penguins.
