Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030623AbWBODcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbWBODcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWBODcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:32:54 -0500
Received: from xenotime.net ([66.160.160.81]:27354 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030623AbWBODcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:32:54 -0500
Date: Tue, 14 Feb 2006 19:33:41 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
Message-Id: <20060214193341.30695606.rdunlap@xenotime.net>
In-Reply-To: <ff1cadb20602141305o5fa0acebn@mail.gmail.com>
References: <ff1cadb20602141305o5fa0acebn@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 22:05:37 +0100 Luca Falavigna wrote:

> This patch, built against kernel version 2.6.16-rc3, provides a Kconfig
> option in order to easily enable or disable CONSOLE_LP_STRICT variable
> in drivers/char/lp.c without modifying it directly.


The patch does not apply cleanly to 2.6.16-rc3 -- because tabs
have been converted to spaces, either by your email client or
by using copy-n-paste to create the email.

Couple of typo corrections below.


> Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>
> 
> --- linux-2.6.16-rc3/drivers/char/lp.c.orig    2006-01-08
> 16:48:14.000000000 +0100
> +++ linux-2.6.16-rc3/drivers/char/lp.c    2006-02-14 13:43:41.000000000
> +0100
> @@ -686,9 +686,13 @@ static struct file_operations lp_fops =
>  #define CONSOLE_LP 0
> 
>  /* If the printer is out of paper, we can either lose the messages or
> - * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
> - * non-zero to get the latter behaviour. */
> -#define CONSOLE_LP_STRICT 1
> + * stall until the printer is happy again. If CONSOLE_LP_STRICT is
> + * non-zero to, we get the latter behaviour. */
*              too,
> +#ifdef CONFIG_LP_CONSOLE_STRICT
> +# define CONSOLE_LP_STRICT 1
> +#else
> +# define CONSOLE_LP_STRICT 0
> +#endif
> 
>  /* The console must be locked when we get here. */
> 
> @@ -697,7 +701,7 @@ static void lp_console_write (struct con
>  {
>      struct pardevice *dev = lp_table[CONSOLE_LP].dev;
>      struct parport *port = dev->port;
> -    ssize_t written;
> +    ssize_t written = 0;
> 
>      if (parport_claim (dev))
>          /* Nothing we can do. */
> --- linux-2.6.16-rc3/drivers/char/Kconfig.orig    2006-02-14
> 00:14:08.000000000 +0100
> +++ linux-2.6.16-rc3/drivers/char/Kconfig    2006-02-14
> 13:47:33.000000000 +0100
> @@ -512,14 +512,21 @@ config LP_CONSOLE
> 
> +config LP_CONSOLE_STRICT
> +    bool "Wait for a ready printer"
> +    depends on LP_CONSOLE
> +    default y
> +    ---help---
> +      With this option enabled, if the printer is out of paper (or off,
> +      or unplugged, or too busy..) the kernel will stall until the printer
* add comma:                         ,
> +      is ready again. By turning this option off (at your own risk), you
> +      can make the kernel continue when this happens, but it will lose
> +      some kernel messages.
> +
> +      If unsure, say Y
> +
>  config PPDEV
>      tristate "Support for user-space parallel port device drivers"
>      depends on PARPORT


---
~Randy
