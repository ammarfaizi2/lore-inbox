Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWJROyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWJROyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWJROyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:54:53 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:63244 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161097AbWJROyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:54:52 -0400
Date: Wed, 18 Oct 2006 16:54:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] i2c: Fix return value check
Message-Id: <20061018165450.35e0c5d4.khali@linux-fr.org>
In-Reply-To: <20061017062449.GA13100@localhost>
References: <20061017062449.GA13100@localhost>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akinobu,

On Tue, 17 Oct 2006 15:24:49 +0900, Akinobu Mita wrote:
> class_device_create() returns error code as pointer on failure.
> This patch checks the return value of class_device_create() by using IS_ERR().
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

Typo ;)

> 
>  drivers/i2c/i2c-dev.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: 2.6-rc/drivers/i2c/i2c-dev.c
> ===================================================================
> --- 2.6-rc.orig/drivers/i2c/i2c-dev.c
> +++ 2.6-rc/drivers/i2c/i2c-dev.c
> @@ -417,8 +417,8 @@ static int i2cdev_attach_adapter(struct 
>  						 MKDEV(I2C_MAJOR, adap->nr),
>  						 &adap->dev, "i2c-%d",
>  						 adap->nr);
> -	if (!i2c_dev->class_dev) {
> -		res = -ENODEV;
> +	if (IS_ERR(i2c_dev->class_dev)) {
> +		res = PTR_ERR(i2c_dev->class_dev);
>  		goto error;
>  	}
>  	res = class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);

Patch looks correct, however class devices are going away soon, and
this patch will conflict with Greg's work:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver-class/i2c-dev-device.patch

So your patch should apply on top of Greg's, if still needed after his
changes. It might even be later folded into Greg's patch to make things
easier to handle.

Thanks,
-- 
Jean Delvare
