Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933542AbWK1AJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933542AbWK1AJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 19:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933563AbWK1AJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 19:09:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933542AbWK1AJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 19:09:48 -0500
Date: Mon, 27 Nov 2006 16:08:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: [PATCH] spi: check platform_device_register_simple() error
Message-Id: <20061127160855.297667fa.akpm@osdl.org>
In-Reply-To: <20061127050915.GH1231@APFDCB5C>
References: <20061127050915.GH1231@APFDCB5C>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 14:09:15 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This patch checks the return value of platform_device_register_simple().
> 
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> ---
>  drivers/spi/spi_butterfly.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: work-fault-inject/drivers/spi/spi_butterfly.c
> ===================================================================
> --- work-fault-inject.orig/drivers/spi/spi_butterfly.c
> +++ work-fault-inject/drivers/spi/spi_butterfly.c
> @@ -250,6 +250,8 @@ static void butterfly_attach(struct parp
>  	 * setting up a platform device like this is an ugly kluge...
>  	 */
>  	pdev = platform_device_register_simple("butterfly", -1, NULL, 0);
> +	if (IS_ERR(pdev))
> +		return;

It'd be nice to at least print some (non-debug) message rather than simply
mysteriously failing.

It'd be nicer if parport_driver.attach() didn't return void.  Ho hum.
