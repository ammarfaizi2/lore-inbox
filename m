Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVHNI0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVHNI0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 04:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVHNI0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 04:26:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751343AbVHNI0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 04:26:32 -0400
Date: Sun, 14 Aug 2005 01:25:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Iatrou <m.iatrou@freemail.gr>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com
Subject: Re: [PATCH] configurable debug info from radeonfb old driver
Message-Id: <20050814012506.79987caf.akpm@osdl.org>
In-Reply-To: <200508140118.27921.m.iatrou@freemail.gr>
References: <200508140118.27921.m.iatrou@freemail.gr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Iatrou <m.iatrou@freemail.gr> wrote:
>
> Hi,
> 
> Currently, radeonfb old driver always prints debugging informations. This 
> patch makes debug info reporting configurable.
>  
> 
> diff -urN linux-2.6.13-rc6/drivers/video/Kconfig linux-2.6.13-rc6.new/drivers/video/Kconfig
> --- linux-2.6.13-rc6/drivers/video/Kconfig      2005-08-14 00:48:34.000000000 +0300
> +++ linux-2.6.13-rc6.new/drivers/video/Kconfig  2005-08-14 00:54:10.000000000 +0300
> @@ -936,6 +936,15 @@
>           There is a product page at
>           <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
> 
> +config FB_RADEON_OLD_DEBUG
> +    bool "Enable debug output from Old Radeon driver"
> +    depends on FB_RADEON_OLD
> +    default n
> +    help
> +      Say Y here if you want the Radeon driver to output all sorts
> +      of debugging informations to provide to the maintainer when
> +      something goes wrong.
> +
>  config FB_RADEON
>         tristate "ATI Radeon display support"
>         depends on FB && PCI
> diff -urN linux-2.6.13-rc6/drivers/video/radeonfb.c linux-2.6.13-rc6.new/drivers/video/radeonfb.c
> --- linux-2.6.13-rc6/drivers/video/radeonfb.c   2005-06-19 14:49:29.000000000 +0300
> +++ linux-2.6.13-rc6.new/drivers/video/radeonfb.c       2005-08-14 00:55:16.000000000 +0300
> @@ -80,7 +80,11 @@
>  #include <video/radeon.h>
>  #include <linux/radeonfb.h>
> 
> -#define DEBUG  1
> +#ifdef CONFIG_FB_RADEON_OLD_DEBUG
> +#define DEBUG       1
> +#else
> +#define DEBUG       0
> +#endif
> 
>  #if DEBUG
>  #define RTRACE         printk

That's probably a bit fancier than we really need.  How about we just set
DEBUG to zero?

