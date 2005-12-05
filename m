Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVLEO7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVLEO7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLEO7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:59:21 -0500
Received: from webapps.arcom.com ([194.200.159.168]:54542 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932432AbVLEO7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:59:20 -0500
Message-ID: <439455BC.4080908@cantab.net>
Date: Mon, 05 Dec 2005 14:59:08 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC PATCH 1/8] LED: Add LED Class
References: <1133788166.8101.125.camel@localhost.localdomain>
In-Reply-To: <1133788166.8101.125.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2005 15:01:34.0515 (UTC) FILETIME=[C899F030:01C5F9AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This LED subsystem isn't usable with LEDs that are controlled by I2C
GPIO devices.  Getting rid of (struct led_device).lock would go some way
to making it work.  It's not clear to me why it's needed anyway.

Suspend and resume probably needs to be LED specific.

Richard Purdie wrote:
> Index: linux-2.6.15-rc2/drivers/leds/Kconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.15-rc2/drivers/leds/Kconfig	2005-12-05 11:29:19.000000000 +0000
> @@ -0,0 +1,18 @@
> +
> +menu "LED devices"
> +
> +config NEW_LEDS

Is there a better name than NEW_LEDS?  It won't be 'new' for very long...

> Index: linux-2.6.15-rc2/include/linux/leds.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.15-rc2/include/linux/leds.h	2005-12-05 11:29:19.000000000 +0000
> [...]
> +	/* A function to set the brightness of the led.
> +	 * Values are between 0-100 */
> +	void (*brightness_set)(struct led_device *led_dev, int value);

0-255 is probably a better range to use.  Might be worth having an enum
like.

enum led_brightness {
	LED_OFF = 0, LED_HALF_BRIGHT = 127, LED_FULL_BRIGHT = 255,
};

David Vrabel
