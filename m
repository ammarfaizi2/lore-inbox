Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWFTFYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWFTFYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFTFY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:24:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964988AbWFTFWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:10 -0400
Date: Mon, 19 Jun 2006 22:22:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 11/20] chardev: GPIO for SCx200 & PC-8736x: migrate
 file-ops to common module
Message-Id: <20060619222207.2a995d75.akpm@osdl.org>
In-Reply-To: <44944AC4.9050705@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944AC4.9050705@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:32:36 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> 11/20. patch.migrate-fops
> 
> Now that the read(), write() file-ops are dispatching gpio-ops via the
> vtable, they are generic, and can be moved 'verbatim' to the nsc_gpio
> common-support module.  After the move, various symbols are renamed to
> update 'scx200_' to 'nsc_', and headers are adjusted accordingly.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> 
> --- ax-10/drivers/char/scx200_gpio.c	2006-06-17 01:23:47.000000000 -0600
> +++ ax-11/drivers/char/scx200_gpio.c	2006-06-17 01:33:50.000000000 -0600
> @@ -37,6 +37,12 @@ MODULE_PARM_DESC(major, "Major device nu
>  
>  extern void scx200_gpio_dump(unsigned index);
>  
> +extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
> +			      size_t len, loff_t *ppos);
> +
> +extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
> +			     size_t len, loff_t *ppos);
> +

extern decls always always go into .h files.

> --- ax-10/include/linux/nsc_gpio.h	2006-06-17 01:20:34.000000000 -0600
> +++ ax-11/include/linux/nsc_gpio.h	2006-06-17 01:33:50.000000000 -0600
> @@ -31,3 +31,8 @@ struct nsc_gpio_ops {
>  	int	(*gpio_current)	(unsigned iminor);
>  };
>  
> +extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
> +			      size_t len, loff_t *ppos);
> +
> +extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
> +			     size_t len, loff_t *ppos);
> 

Yeah, like that ;)
