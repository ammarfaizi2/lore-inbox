Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWFTFXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWFTFXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWFTFWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964998AbWFTFWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:18 -0400
Date: Mon, 19 Jun 2006 22:22:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 15/20] chardev: GPIO for SCx200 & PC-8736x: use
 dev_dbg in common module
Message-Id: <20060619222215.9729ec9e.akpm@osdl.org>
In-Reply-To: <44944BA3.5090905@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944BA3.5090905@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:36:19 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> 15/20. patch.devdbg-nscgpio
> 
> Use of dev_dbg() and friends is considered good practice.  dev_dbg()
> needs a struct device *devp, but nsc_gpio is only a helper module, so
> it doesnt have/need its own.  To provide devp to the user-modules
> (scx200 & pc8736x _gpio), we add it to the vtable, and set it during
> init.
> 
> ...
>
> --- ax-14/drivers/char/pc8736x_gpio.c	2006-06-17 01:42:57.000000000 -0600
> +++ ax-15/drivers/char/pc8736x_gpio.c	2006-06-17 01:45:49.000000000 -0600
> @@ -207,7 +207,7 @@ static void pc8736x_gpio_change(unsigned
>  	pc8736x_gpio_set(index, !pc8736x_gpio_get(index));
>  }
>  
> -extern void nsc_gpio_dump(unsigned iminor);
> +extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned iminor);

Wants to be in a header file.

> +
> +extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
> +

And there it is.  Odd.
