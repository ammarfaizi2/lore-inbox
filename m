Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946054AbWGOOtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946054AbWGOOtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 10:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWGOOtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 10:49:11 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:16284 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1161176AbWGOOtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 10:49:10 -0400
Message-ID: <44B90063.5070504@bootc.net>
Date: Sat, 15 Jul 2006 15:49:07 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] drivers/char/scx200_gpio.c: make code static
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003536.GH3633@stusta.de>
In-Reply-To: <20060715003536.GH3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes needlessly global code static.

I don't agree with unexporting scx200_gpio_ops and making the struct static, 
this lets other modules use the scx200_gpio module in a semi-independent way. My 
net48xx LED Class code is going to be modified to use the entries in this struct 
to do its GPIO-twiddling magic, potentially allowing my module to do more than 
just the net48xx Error LED.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/char/scx200_gpio.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.18-rc1-mm2-full/drivers/char/scx200_gpio.c.old	2006-07-14 22:31:22.000000000 +0200
> +++ linux-2.6.18-rc1-mm2-full/drivers/char/scx200_gpio.c	2006-07-14 22:31:44.000000000 +0200
> @@ -35,7 +35,7 @@
>  
>  #define MAX_PINS 32		/* 64 later, when known ok */
>  
> -struct nsc_gpio_ops scx200_gpio_ops = {
> +static struct nsc_gpio_ops scx200_gpio_ops = {
>  	.owner		= THIS_MODULE,
>  	.gpio_config	= scx200_gpio_configure,
>  	.gpio_dump	= nsc_gpio_dump,
> @@ -44,7 +44,6 @@
>  	.gpio_change	= scx200_gpio_change,
>  	.gpio_current	= scx200_gpio_current
>  };
> -EXPORT_SYMBOL(scx200_gpio_ops);
>  
>  static int scx200_gpio_open(struct inode *inode, struct file *file)
>  {
> @@ -69,7 +68,7 @@
>  	.release = scx200_gpio_release,
>  };
>  
> -struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
> +static struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
>  
>  static int __init scx200_gpio_init(void)
>  {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
