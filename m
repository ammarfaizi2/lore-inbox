Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTLACED (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 21:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTLACED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 21:04:03 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:62760 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263081AbTLACD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 21:03:59 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200312010203.hB123YQr002367@devserv.devel.redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [USB] Fix connect/disconnect race
In-Reply-To: <mailman.1070178780.32610.linux-kernel2news@redhat.com>
References: <mailman.1070178780.32610.linux-kernel2news@redhat.com>
Date: Sun, 30 Nov 2003 21:03:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch was integrated by you in 2.4 six months ago.  Unfortunately
> it never got into 2.5.  Without it you can end up with crashes such
> as http://bugs.debian.org/218670

> --- kernel-source-2.5/drivers/usb/core/hub.c	28 Sep 2003 04:44:16 -0000	1.1.1.15
> +++ kernel-source-2.5/drivers/usb/core/hub.c	30 Nov 2003 07:44:40 -0000
>  			break;
>  		}
>  
> -		hub->children[port] = dev;
>  		dev->state = USB_STATE_POWERED;
>[...]
>  		/* Run it through the hoops (find a driver, etc) */
> -		if (!usb_new_device(dev, &hub->dev))
> +		if (!usb_new_device(dev, &hub->dev)) {
> +			hub->children[port] = dev;
>  			goto done;
> +		}

I'm surprised you need it. The updated usbfs is supposed
to be immune. This is probably the reason it wasn't ported.

-- Pete
