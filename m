Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946056AbWGOOuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946056AbWGOOuy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 10:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946057AbWGOOuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 10:50:54 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:27292 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1946056AbWGOOux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 10:50:53 -0400
Message-ID: <44B900CC.7080709@bootc.net>
Date: Sat, 15 Jul 2006 15:50:52 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/char/pc8736x_gpio.c: unexport a static struct
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003527.GG3633@stusta.de>
In-Reply-To: <20060715003527.GG3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.18-rc1-mm1:
>> ...
>> +gpio-rename-exported-vtables-to-better-match.patch
>> ...
>>  Misc fixes and updates and cleanups.
>> ...
> 
> A static struct mustn't be exported.

I don't agree with unexporting pc8736x_gpio_ops. If anything the struct should 
be made global and kept exported (as _GPL perhaps). This lets other modules use 
the pc8736x_gpio module in a semi-independent way. See my comments about the 
scx200_gpio changes you submitted.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c.old	2006-07-14 22:27:28.000000000 +0200
> +++ linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c	2006-07-14 22:27:42.000000000 +0200
> @@ -215,19 +215,18 @@
>  static struct nsc_gpio_ops pc8736x_gpio_ops = {
>  	.owner		= THIS_MODULE,
>  	.gpio_config	= pc8736x_gpio_configure,
>  	.gpio_dump	= nsc_gpio_dump,
>  	.gpio_get	= pc8736x_gpio_get,
>  	.gpio_set	= pc8736x_gpio_set,
>  	.gpio_change	= pc8736x_gpio_change,
>  	.gpio_current	= pc8736x_gpio_current
>  };
> -EXPORT_SYMBOL(pc8736x_gpio_ops);
>  
>  static int pc8736x_gpio_open(struct inode *inode, struct file *file)
>  {
>  	unsigned m = iminor(inode);
>  	file->private_data = &pc8736x_gpio_ops;
>  
>  	dev_dbg(&pdev->dev, "open %d\n", m);
>  
>  	if (m >= PC8736X_GPIO_CT)

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
