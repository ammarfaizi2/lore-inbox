Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbUAPSMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbUAPSMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:12:22 -0500
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:27299 "EHLO
	garfield") by vger.kernel.org with ESMTP id S265612AbUAPSL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:11:57 -0500
Message-ID: <40082961.6050704@free.fr>
Date: Fri, 16 Jan 2004 19:11:45 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031015 Debian/1.4-0jds2
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org>	<200401161449.i0GEnoAv026627@fire-1.osdl.org> <20040116090349.73b1fad4.akpm@osdl.org>
In-Reply-To: <20040116090349.73b1fad4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Fabian Fenaut <fabian.fenaut@free.fr> wrote:
> 
>>I got an error compiling -mm4 :
>>
>>    [...]
>>    CC [M]  drivers/media/video/ir-kbd-gpio.o
>> drivers/media/video/ir-kbd-gpio.c:185: unknown field `name' specified in
>> initializer
> 
> You must be using an elderly gcc.

2.95.4 from debian stable

> diff -puN drivers/media/video/ir-kbd-gpio.c~ir-kbd-gpio-build-fix drivers/media/video/ir-kbd-gpio.c
> --- 25/drivers/media/video/ir-kbd-gpio.c~ir-kbd-gpio-build-fix	2004-01-16 09:01:59.000000000 -0800
> +++ 25-akpm/drivers/media/video/ir-kbd-gpio.c	2004-01-16 09:02:17.000000000 -0800
> @@ -182,9 +182,11 @@ static int ir_probe(struct device *dev);
>  static int ir_remove(struct device *dev);
>  
>  static struct bttv_sub_driver driver = {
> -	.drv.name	= DEVNAME,
> -	.drv.probe	= ir_probe,
> -	.drv.remove	= ir_remove,
> +	.drv = {
> +		.name	= DEVNAME,
> +		.probe	= ir_probe,
> +		.remove	= ir_remove,
> +	},
>  	.gpio_irq       = ir_irq,
>  };

it works, thanks.

Fabian

