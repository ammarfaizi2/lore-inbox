Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUFWITo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUFWITo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 04:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUFWITo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 04:19:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:42368 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265237AbUFWITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 04:19:42 -0400
Date: Wed, 23 Jun 2004 04:21:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartmann <greg@kroah.com>
Subject: Re: Oops w/ USB serial + modular ipaq
In-Reply-To: <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0406230420310.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Zwane Mwaikambo wrote:

> Loading the ipaq module, connecting a device and then unloading ipaq.ko
> oopses.
>
> It's not safe to use serial->interface after that
> usb_driver_release_interface(). The following patch works as a workaround
> but i don't trust it as there may be a leak.
>
> Index: linux-2.6.7/drivers/usb/serial/usb-serial.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.7/drivers/usb/serial/usb-serial.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 usb-serial.c
> --- linux-2.6.7/drivers/usb/serial/usb-serial.c	16 Jun 2004 16:49:38 -0000	1.1.1.1
> +++ linux-2.6.7/drivers/usb/serial/usb-serial.c	23 Jun 2004 06:29:56 -0000
> @@ -1393,7 +1393,6 @@ void usb_serial_deregister(struct usb_se
>  		serial = serial_table[i];
>  		if ((serial != NULL) && (serial->type == device)) {
>  			usb_driver_release_interface (&usb_serial_driver, serial->interface);
> -			usb_serial_disconnect (serial->interface);
>  		}
>  	}
>

I'll leave this patch going in a load/unload loop overnight and check on
slab.

Thanks,
	Zwane

