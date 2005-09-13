Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVIMRWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVIMRWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVIMRWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:22:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:6104 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964906AbVIMRW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:22:29 -0400
Date: Tue, 13 Sep 2005 10:21:57 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 3/5] isicom: pci probing
Message-ID: <20050913172157.GC6309@kroah.com>
References: <200509131649.j8DGnNnw021871@localhost.localdomain> <200509131652.j8DGquXo022115@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509131652.j8DGquXo022115@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 06:52:56PM +0200, Jiri Slaby wrote:
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> 
>  drivers/char/isicom.c  |  598 +++++++++++++++++++++++++++----------------------
>  include/linux/isicom.h |    3 
>  2 files changed, 333 insertions(+), 268 deletions(-)
> 
> diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
> --- a/drivers/char/isicom.c
> +++ b/drivers/char/isicom.c
> @@ -91,6 +91,8 @@
>   *	06/01/05  Alan Cox 		Merged the ISI and base kernel strands
>   *					into a single 2.6 driver
>   *
> + *	10/09/05  Jiri Slaby		driver rewritten to 2.6 API
> + *

The git changelog works well enough that you don't need to add stuff to
the files themselves anymore.

> +#define InterruptTheCard(base) outw(0, (base) + 0xc)
> +#define ClearInterrupt(base) inw((base) + 0x0a)
> +
> +#ifdef ISICOM_DEBUG
> +#define pr_deb(str, ...) printk((str), ##args);
> +#define isicom_paranoia_check(a, b, c) __isicom_paranoia_check((a), (b), (c))
> +#else
> +#define pr_deb(str, ...)
> +#define isicom_paranoia_check(a, b, c) 0
> +#endif

This doesn't look like "pci probe changes"  In fact, a lot of other
changes in this patch don't look like them either...

Care to split it up even more?

thanks,

greg k-h
