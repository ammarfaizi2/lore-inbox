Return-Path: <linux-kernel-owner+w=401wt.eu-S1750952AbXAVFYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXAVFYO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 00:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXAVFYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 00:24:13 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:49837 "EHLO
	thing.hostingexpert.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXAVFYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 00:24:13 -0500
X-Greylist: delayed 18681 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 00:24:13 EST
Message-ID: <45B3BB26.7000208@linuxtv.org>
Date: Sun, 21 Jan 2007 14:12:38 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070120)
MIME-Version: 1.0
To: Chris Rankin <rankincj@yahoo.com>
CC: v4l-dvb-maintainer@linuxtv.org, linux-dvb@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [PATCH] Register the bus,	vendor and product
 IDs for dvb-usb remote device
References: <879469.96393.qm@web52901.mail.yahoo.com>
In-Reply-To: <879469.96393.qm@web52901.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rankin wrote:
> Hi,
>
> This patch writes the USB vendor and product IDs into the /sys/class/input/inputX/id/ files, so
> that udev can find them. A rule like this does the trick for me:
>
> KERNEL="event*", SYSFS{../id/vendor}=="2040", SYSFS{../id/product}=="9301",
> SYMLINK+="input/dvb-remote"
>
> --- linux-2.6.18/drivers/media/dvb/dvb-usb/dvb-usb-remote.c.old 2007-01-21 02:43:11.000000000
> +0000
> +++ linux-2.6.18/drivers/media/dvb/dvb-usb/dvb-usb-remote.c     2007-01-21 02:39:02.000000000
> +0000
> @@ -107,6 +107,9 @@
>         d->rc_input_dev->keycodemax = KEY_MAX;
>         d->rc_input_dev->name = "IR-receiver inside an USB DVB receiver";
>         d->rc_input_dev->phys = d->rc_phys;
> +       d->rc_input_dev->id.bustype = BUS_USB;
> +       d->rc_input_dev->id.vendor = d->udev->descriptor.idVendor;
> +       d->rc_input_dev->id.product = d->udev->descriptor.idProduct;
>
>         /* set the bits for the keys */
>         deb_rc("key map size: %d\n", d->props.rc_key_map_size);

Chris,

The patch is fine.  Could you please provide a sign-off, in the form:

Signed-off-by: Your Name <email@addre.ss>

...so that we can apply this to the kernel sources?

Cheers,

Mike Krufky
