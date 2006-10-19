Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423263AbWJSKLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423263AbWJSKLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423265AbWJSKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:11:15 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:55309 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1423263AbWJSKLO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:11:14 -0400
Date: Thu, 19 Oct 2006 12:11:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: Fix return value check
Message-Id: <20061019121115.70130d27.khali@linux-fr.org>
In-Reply-To: <20061019032801.GB20695@localhost>
References: <20061017062449.GA13100@localhost>
	<20061018165450.35e0c5d4.khali@linux-fr.org>
	<20061019032801.GB20695@localhost>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akinobu,

On Thu, 19 Oct 2006 12:28:01 +0900, Akinobu Mita wrote:
> On Wed, Oct 18, 2006 at 04:54:50PM +0200, Jean Delvare wrote:
> > Patch looks correct, however class devices are going away soon, and
> > this patch will conflict with Greg's work:
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver-class/i2c-dev-device.patch
> > 
> > So your patch should apply on top of Greg's, if still needed after his
> > changes. It might even be later folded into Greg's patch to make things
> > easier to handle.
> 
> I made the patch on top of i2c-dev-device.patch
> 
> Subject: i2c: Fix return value check
> 
> device_create() returns error code as pointer on failures.
> This patch checks the return value of device_create() by using IS_ERR().
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/i2c/i2c-dev.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: work-fault-inject/drivers/i2c/i2c-dev.c
> ===================================================================
> --- work-fault-inject.orig/drivers/i2c/i2c-dev.c
> +++ work-fault-inject/drivers/i2c/i2c-dev.c
> @@ -417,8 +417,8 @@ static int i2cdev_attach_adapter(struct 
>  	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
>  				     MKDEV(I2C_MAJOR, adap->nr),
>  				     "i2c-%d", adap->nr);
> -	if (!i2c_dev->dev) {
> -		res = -ENODEV;
> +	if (IS_ERR(i2c_dev->dev)) {
> +		res = PTR_ERR(i2c_dev->dev);
>  		goto error;
>  	}
>  	res = device_create_file(i2c_dev->dev, &dev_attr_name);

Great, thanks. I've this in my tree now so it won't be lost.

Greg, do you want to fold this into i2c-dev-device.patch?

Thanks,
-- 
Jean Delvare
