Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTEGExy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTEGExy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:53:54 -0400
Received: from fmr02.intel.com ([192.55.52.25]:26338 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262440AbTEGExx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:53:53 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FDF50@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: RE: [Bluetooth] HCI USB driver update. Support for SCO over HCI U
	SB.
Date: Tue, 6 May 2003 22:06:22 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Greg KH [mailto:greg@kroah.com]
>
> +int usb_init_urb(struct urb *urb)
> +{
> +	if (!urb)
> +		return -EINVAL;
> ...
> ...
> ...
> @@ -38,13 +61,14 @@
>  		mem_flags);
>  	if (!urb) {
>  		err("alloc_urb: kmalloc failed");
> -		return NULL;
> +		goto exit;
> +	}
> +	if (usb_init_urb(urb)) {
> +		kfree(urb);
> +		urb = NULL;
>  	}

If usb_init_urb() is already testing for !urb, why
test it again? No doubt the compiler will probably
catch it if inlining ... but I think the best is
for usb_init_urb() to assume that urb is not NULL.
Let the caller make that sure.

Sorry if this is a dup ... I am catching up with
my mail ...


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
