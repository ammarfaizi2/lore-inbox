Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVEYMgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVEYMgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVEYMgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:36:31 -0400
Received: from panda.sul.com.br ([200.219.150.4]:6923 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262327AbVEYMg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:36:29 -0400
Date: Wed, 25 May 2005 09:36:26 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Ian Campbell <icampbell@arcom.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [UINPUT] Allow EV_ABS to work in uinput.c
Message-ID: <20050525123626.GC3772@cathedrallabs.org>
References: <1117023999.20237.8.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117023999.20237.8.camel@icampbell-debian>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> uinput_alloc_device() is supposed to return the number of bytes read,
> the value is returned to uinput_write() and from there to userspace. If
> EV_ABS is set then it returns the value from uinput_validate_absbits()
> instead, which is zero when everything is ok instead of the count.
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>
Acked-by: Aristeu Rozanski <aris@cathedrallabs.org>

> --- 2.6.orig/drivers/input/misc/uinput.c	2005-05-25 10:45:56.000000000 +0100
> +++ 2.6/drivers/input/misc/uinput.c	2005-05-25 10:47:02.000000000 +0100
> @@ -216,9 +216,11 @@
>  	/* check if absmin/absmax/absfuzz/absflat are filled as
>  	 * told in Documentation/input/input-programming.txt */
>  	if (test_bit(EV_ABS, dev->evbit)) {
> -		retval = uinput_validate_absbits(dev);
> -		if (retval < 0)
> +		int err = uinput_validate_absbits(dev);
> +		if (err < 0) {
> +			retval = err;
>  			kfree(dev->name);
> +		}
>  	}
>  
>  exit:

-- 
Aristeu

