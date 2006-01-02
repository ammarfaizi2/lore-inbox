Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWABMHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWABMHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWABMHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:07:04 -0500
Received: from sd291.sivit.org ([194.146.225.122]:50955 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751098AbWABMHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:07:01 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Stelian Pop <stelian@popies.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20051231235124.GA18506@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <20051231235124.GA18506@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 02 Jan 2006 13:06:40 +0100
Message-Id: <1136203601.5803.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 01 janvier 2006 à 00:51 +0100, Michael Hanselmann a écrit :
> On Sun, Dec 25, 2005 at 11:04:30PM -0500, Dmitry Torokhov wrote:
> > Well, we have used 11 out of 32 available bits so there still some
> > reserves. My concern is that your implementation allows only one
> > hook to be installed while with quirks you can have several of them
> > active per device.
> 
> Below you find an implementation using quirks:
> 
> ---
> diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c linux-2.6.15-rc7/drivers/usb/input/hid-core.c
> --- linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c	2006-01-01 00:41:15.000000000 +0100
> +++ linux-2.6.15-rc7/drivers/usb/input/hid-core.c	2005-12-31 22:39:53.000000000 +0100
> @@ -1580,6 +1580,10 @@ static struct hid_blacklist {
>  	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
>  
> +	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
> +

Works fine for me on a slightly older (jul '05) Powerbook after adding
the following USB identifiers:

+       { USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
+       { USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
+       { USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
+       { USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },

Mine is a 020F but the other three ones should be fine too (those are
taken from the appletouch trackpad driver).

Stelian.
-- 
Stelian Pop <stelian@popies.net>

