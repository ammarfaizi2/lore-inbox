Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTFVIuh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTFVIuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:50:37 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:48070 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264091AbTFVIuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:50:35 -0400
Date: Sun, 22 Jun 2003 11:04:33 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
       Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Permit big console scrolls
In-Reply-To: <200306210621.h5L6LbUo011422@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0306221102430.869-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1381, 2003/06/20 22:14:31-07:00, akpm@digeo.com
> 
> 	[PATCH] Permit big console scrolls
> 	
> 	From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
> 	
> 	Changes the new console scrolling ioctl to permit distances greater than
> 	+127/-128.
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1380  -> 1.1381 
> #	   drivers/char/vt.c	1.52    -> 1.53   
> #
> 
>  vt.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
> --- a/drivers/char/vt.c	Fri Jun 20 23:21:41 2003
> +++ b/drivers/char/vt.c	Fri Jun 20 23:21:41 2003
> @@ -75,6 +75,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/types.h>
>  #include <linux/sched.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> @@ -2279,7 +2280,7 @@
>  			ret = fg_console;
>  			break;
>  		case TIOCL_SCROLLCONSOLE:
> -			if (get_user(lines, (char *)arg+1)) {
						    ^^^^^
> +			if (get_user(lines, (s32 *)((char *)arg+4))) {
							    ^^^^^
>  				ret = -EFAULT;
>  			} else {
>  				scrollfront(lines);

Why was the `arg+1' changed to `arg+4'? Do we really want to skip 12 bytes?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

