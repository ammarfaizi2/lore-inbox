Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946033AbWGOMuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946033AbWGOMuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 08:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946034AbWGOMuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 08:50:04 -0400
Received: from mx2.rowland.org ([192.131.102.7]:17161 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1946033AbWGOMuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 08:50:03 -0400
Date: Sat, 15 Jul 2006 08:50:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [RFC: -mm patch] drivers/usb/core/driver.c:
 make 2 functions static
In-Reply-To: <20060715003552.GJ3633@stusta.de>
Message-ID: <Pine.LNX.4.44L0.0607150846450.21022-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2006, Adrian Bunk wrote:

> This patch makes two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
...
> --- linux-2.6.18-rc1-mm2-full/drivers/usb/core/driver.c.old	2006-07-14 23:29:20.000000000 +0200
> +++ linux-2.6.18-rc1-mm2-full/drivers/usb/core/driver.c	2006-07-14 23:29:51.000000000 +0200
> @@ -471,7 +471,7 @@
>  }
>  EXPORT_SYMBOL_GPL_FUTURE(usb_match_id);
>  
> -int usb_device_match(struct device *dev, struct device_driver *drv)
> +static int usb_device_match(struct device *dev, struct device_driver *drv)
>  {
>  	/* devices and interfaces are handled separately */
>  	if (is_usb_device(dev)) {
> @@ -877,7 +877,7 @@
>  }
>  
>  /* Caller has locked udev */
> -int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
> +static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
>  {
>  	int			status = 0;
>  	int			i = 0;

There's no problem with making usb_device_match() static, but I've got a
patch almost ready for submission which needs usb_suspend_both() to be
publicly visible.

Alan Stern

