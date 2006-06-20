Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWFTFWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWFTFWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWFTFWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964932AbWFTFWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:00 -0400
Date: Mon, 19 Jun 2006 22:21:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 02/20] chardev: GPIO for SCx200 & PC-8736x:
 modernize driver init to 2.6 api
Message-Id: <20060619222157.9abba5a0.akpm@osdl.org>
In-Reply-To: <449448CA.1060601@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<449448CA.1060601@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:24:10 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> 2/20. patch.api26
> 
> Adopt many modern 2.6 coding practices, ala LDD3, chapter 3.
> Changes are limited to initialization calls from module init,
> ie: cdev_init, cdev_add, *_chrdev_region, mkdev.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> 
> ---
> 
> diffstat gpio-scx/patch.api26
>  scx200_gpio.c |   55 ++++++++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff -ruNp -X dontdiff -X exclude-diffs ax-1/drivers/char/scx200_gpio.c ax-2/drivers/char/scx200_gpio.c
> --- ax-1/drivers/char/scx200_gpio.c	2006-06-17 00:55:59.000000000 -0600
> +++ ax-2/drivers/char/scx200_gpio.c	2006-06-17 01:01:13.000000000 -0600
> @@ -14,6 +14,9 @@
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  
> +#include <linux/types.h>
> +#include <linux/cdev.h>
> +
>  #include <linux/scx200_gpio.h>
>  
>  #define NAME "scx200_gpio"
> @@ -26,6 +29,8 @@ static int major = 0;		/* default to dyn
>  module_param(major, int, 0);
>  MODULE_PARM_DESC(major, "Major device number");
>  
> +extern void scx200_gpio_dump(unsigned index);

extern declarations should go in .h files.

>  static ssize_t scx200_gpio_write(struct file *file, const char __user *data,
>  				 size_t len, loff_t *ppos)
>  {
> @@ -108,33 +113,57 @@ static struct file_operations scx200_gpi
>  	.release = scx200_gpio_release,
>  };
>  
> +struct cdev *scx200_devices;
> +int num_devs = 32;

`num_devs' is too generic a name for a global symbol.


