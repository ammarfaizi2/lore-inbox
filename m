Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbUB1BFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUB1BFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:05:51 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59402 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263233AbUB1BFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:05:50 -0500
Date: Sat, 28 Feb 2004 01:05:47 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix VT mode change vs. fbcon
In-Reply-To: <1077923222.23344.50.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402280059590.2216-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- 1.34/drivers/char/vt_ioctl.c	Wed Feb 25 21:31:13 2004
> +++ edited/drivers/char/vt_ioctl.c	Fri Feb 27 17:27:21 2004
> @@ -497,7 +497,7 @@
>  		 */
>  		acquire_console_sem();
>  		if (arg == KD_TEXT)
> -			unblank_screen();
> +			do_unblank_screen(1);
>  		else
>  			do_blank_screen(1);
>  		release_console_sem();
> @@ -1103,7 +1103,7 @@
>  	if (old_vc_mode != vt_cons[new_console]->vc_mode)
>  	{
>  		if (vt_cons[new_console]->vc_mode == KD_TEXT)
> -			unblank_screen();
> +			do_unblank_screen(1);
>  		else
>  			do_blank_screen(1);
>  	}
> @@ -1138,7 +1138,7 @@
>  			if (old_vc_mode != vt_cons[new_console]->vc_mode)
>  			{
>  				if (vt_cons[new_console]->vc_mode == KD_TEXT)
> -					unblank_screen();
> +					do_unblank_screen(1);
>  				else
>  					do_blank_screen(1);
>  			}

How about calling resize_screen in vt.c instead in this function. This way 
fbcon could reset the hardware state :-) 


