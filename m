Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWH0IUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWH0IUG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWH0IUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:20:06 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:38672 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751346AbWH0IUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:20:04 -0400
Date: Sun, 27 Aug 2006 10:20:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       christer@weinigel.se, Greg Kroah-Hartman <gregkh@suse.de>,
       i2c@lm-sensors.org
Subject: Re: [-mm patch] drivers/i2c/busses/scx200_i2c.c: update struct
 scx200_i2c_data
Message-Id: <20060827102008.2b6e97cd.khali@linux-fr.org>
In-Reply-To: <20060827015957.GN4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060827015957.GN4765@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc4-mm2:
> >...
> > +gregkh-i2c-i2c-algo-bit-kill-mdelay.patch
> >...
> >  I2C tree updates
> >...
> 
> drivers/i2c/busses/scx200_i2c.c was forgotten:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/i2c/busses/scx200_i2c.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c:79: warning: excess elements in struct initializer
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c:79: warning: (near initialization for ‘scx200_i2c_data’)
> ...
> 
> <--  snip  -->
> 
> While fixing it, I also converted the struct to C99 initializers.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c.old	2006-08-27 03:57:50.000000000 +0200
> +++ linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c	2006-08-27 03:51:50.000000000 +0200
> @@ -71,12 +71,12 @@
>   */
>  
>  static struct i2c_algo_bit_data scx200_i2c_data = {
> -	NULL,
> -	scx200_i2c_setsda,
> -	scx200_i2c_setscl,
> -	scx200_i2c_getsda,
> -	scx200_i2c_getscl,
> -	10, 10, 100,		/* waits, timeout */
> +	.setsda		= scx200_i2c_setsda,
> +	.setscl		= scx200_i2c_setscl,
> +	.getsda		= scx200_i2c_getsda,
> +	.getscl		= scx200_i2c_getscl,
> +	.udelay		= 10,
> +	.timeout	= 100,
>  };
>  
>  static struct i2c_adapter scx200_i2c_ops = {

Good catch, thanks for fixing that. I tried to catch and fix all users
when dropping mdelay from struct i2c_algo_bit_data, but obviously I
missed this one.

Patch applied.

-- 
Jean Delvare
