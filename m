Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWDSHQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWDSHQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWDSHQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:16:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbWDSHQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:16:47 -0400
Date: Wed, 19 Apr 2006 00:15:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Thayumanavar Sachithanantham" <thayumk@gmail.com>
Cc: info-linux@geode.amd.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: [PATCH]drivers/char/cs5535_gpio.c:call cdev_del during
 module_exit to unmap kobject references and other cleanups.
Message-Id: <20060419001547.320684bf.akpm@osdl.org>
In-Reply-To: <3b8510d80604182352v11fea186lde1b9987447a3318@mail.gmail.com>
References: <3b8510d80604182352v11fea186lde1b9987447a3318@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thayumanavar Sachithanantham" <thayumk@gmail.com> wrote:
>
> During module unloading, cdev_del be called to unmap cdev related
> kobject references and other cleanups(such as inode->i_cdev being set
> to NULL) which prevents the OOPS upon subsequent loading ,usage and
> unloading of modules(as
> seen in the mail thread
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114533640609018&w=2).
> Patch against 2.6.17-rc1
> 
> Signed-off-by: Thayumanavar Sachithanantham <thayumk@gmail.com>
> 
> --- linux-2.6/drivers/char/cs5535_gpio.c.orig   2006-04-17
> 21:37:25.000000000 -0700
> +++ linux-2.6/drivers/char/cs5535_gpio.c        2006-04-17
> 21:38:24.000000000 -0700
> @@ -241,6 +241,7 @@ static int __init cs5535_gpio_init(void)
>  static void __exit cs5535_gpio_cleanup(void)
>  {
>         dev_t dev_id = MKDEV(major, 0);
> +        cdev_del(&cs5535_gpio_cdev);
>         unregister_chrdev_region(dev_id, CS5535_GPIO_COUNT);

Fair enough.  Please note that your patch was wordwrapped and had its tabs
replaced with spaces.


>         if (gpio_base != 0)
>                 release_region(gpio_base, CS5535_GPIO_SIZE);

>From my reading, this test of gpio_base is unneeded and wrong, btw. 
Probably it can't be zero anyway...
