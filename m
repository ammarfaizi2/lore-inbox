Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVATHjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVATHjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVATHjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:39:18 -0500
Received: from postman4.arcor-online.net ([151.189.20.158]:36331 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261858AbVATHjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:39:14 -0500
Date: Thu, 20 Jan 2005 08:39:11 +0100
From: Juergen Quade <quade@hnsr.de>
To: Daniel Caujolle-Bert <segfault@club-internet.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alps touchpad probing failure
Message-ID: <20050120073911.GA13979@hsnr.de>
References: <200501200024.01963.segfault@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200501200024.01963.segfault@club-internet.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 12:23:58AM +0100, Daniel Caujolle-Bert wrote:
> Hi,
> 
>  With 2.6.11-rc1 bk6 and bk7 (didn't tried with < bk6), my alps touchpad is no 
> more correctly probed, it's recognised as a standard PS/2 mouse.
>  So, with this trivial two line patch, everything is working again.
> 
> Cheers.

I have had the same problems...
Now solved ...

Thanks for the patch,

         Juergen.
> -- 
> 73's de Daniel "Der Schreckliche", F1RMB.
> 
>              -=- Daniel Caujolle-Bert -=- segfault@club-internet.fr -=-
>                         -=- http://naboo.homelinux.org -=-

> --- linux-2.6.11-rc1/drivers/input/mouse/alps.c	2005-01-19 19:43:36.000000000 +0100
> +++ linux/drivers/input/mouse/alps.c	2005-01-19 19:34:32.000000000 +0100
> @@ -194,6 +194,12 @@
>  	int i;
>  
>  	/*
> +	 * Let's clean the stuff.
> +	 */
> +	if(psmouse_reset(psmouse) < 0)
> +	  printk(KERN_ERR "alps reset failed\n");
> +
> +	/*
>  	 * First try "E6 report".
>  	 * ALPS should return 0x00,0x00,0x0a or 0x00,0x00,0x64
>  	 */
