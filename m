Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUAYH3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 02:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUAYH3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 02:29:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:18645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263793AbUAYH3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 02:29:14 -0500
Date: Sat, 24 Jan 2004 23:29:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Serge Belyshev <33554432@mtu-net.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add_*_randomness calls in usbkbd.c and usbmouse.c
Message-Id: <20040124232914.13a2beb7.akpm@osdl.org>
In-Reply-To: <87vfn063fm.fsf@mtu-net.ru>
References: <87vfn063fm.fsf@mtu-net.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Belyshev <33554432@mtu-net.ru> wrote:
>
> Please comment on struct usb_kbd. Did I choose right place to get
> 'randomness' from?
> 
> @@ -125,6 +126,7 @@
>  
>  	memcpy(kbd->old, kbd->new, 8);
>  
> +	add_keyboard_randomness (kbd->new[0]);
>  resubmit:
>  	i = usb_submit_urb (urb, SLAB_ATOMIC);
>  	if (i)

This function already calls input_report_key(), which calls
add_mouse_randomness().  This change seems to be unneeded.

> diff -urN vanilla/drivers/usb/input/usbmouse.c hack/drivers/usb/input/usbmouse.c
> --- vanilla/drivers/usb/input/usbmouse.c	Sat Aug 23 19:34:14 2003
> +++ hack/drivers/usb/input/usbmouse.c	Tue Nov 11 23:16:04 2003
> @@ -32,6 +32,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/usb.h>
> +#include <linux/random.h>
>  
>  /*
>   * Version Information
> @@ -89,6 +90,7 @@
>  	input_report_rel(dev, REL_WHEEL, data[3]);
>  
>  	input_sync(dev);
> +	add_mouse_randomness (*(u32 *) data);
>  resubmit:
>  	status = usb_submit_urb (urb, SLAB_ATOMIC);
>  	if (status)

Similarly, this function has just called input_report_event() several
times.

