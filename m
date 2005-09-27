Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVI0RXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVI0RXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVI0RXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:23:18 -0400
Received: from smtp06.web.de ([217.72.192.224]:61896 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S965022AbVI0RXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:23:17 -0400
Message-ID: <43397FF8.4090902@web.de>
Date: Tue, 27 Sep 2005 19:23:04 +0200
From: Gregor Jasny <gjasny@web.de>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Laurent Meunier <meunier.laurent@laposte.net>
CC: mmcclell@bigfoot.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ov511-2.28 patch for 2.6.12 kernel compat.
References: <43392BF9.30906@laposte.net>
In-Reply-To: <43392BF9.30906@laposte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Meunier schrieb:
> This patch basically remove references to the 'id' field from the static 
> struct i2c_client client_template in ovcamchip_core.c, tda7313.c and 
> saa7111-new.c) and update a deprecated function (usb_unlink_urb -> 
> usb_kill_urb).

> diff -rbup ov511-2.28-orig/ovfx2.c ov511-2.28-new/ovfx2.c
> --- ov511-2.28-orig/ovfx2.c	2004-07-16 01:32:08.000000000 +0200
> +++ ov511-2.28-new/ovfx2.c	2005-09-24 14:00:12.000000000 +0200
> @@ -1678,7 +1678,11 @@ ovfx2_unlink_bulk(struct usb_ovfx2 *ov)
>  	/* Unschedule all of the bulk td's */
>  	for (n = OVFX2_NUMSBUF - 1; n >= 0; n--) {
>  		if (ov->sbuf[n].urb) {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
>  			usb_unlink_urb(ov->sbuf[n].urb);
> +#else
> +			usb_unlink_urb(ov->sbuf[n].urb);
> +#endif

This lines look suspicous to me. Do you meant usb_kill_urb in the >= 
2.6.12 case?

Gregor
