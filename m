Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRJUSQD>; Sun, 21 Oct 2001 14:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276507AbRJUSPx>; Sun, 21 Oct 2001 14:15:53 -0400
Received: from zero.tech9.net ([209.61.188.187]:29459 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S276505AbRJUSPp>;
	Sun, 21 Oct 2001 14:15:45 -0400
Subject: Re: [PATCH] updated preempt-kernel
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Colin Phipps <cph@cph.demon.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3BD2E89C.78D757A2@zip.com.au>
In-Reply-To: <1003562833.862.65.camel@phantasy>,
	<1003562833.862.65.camel@phantasy> <20011021120539.A1197@cph.demon.co.uk> 
	<3BD2E89C.78D757A2@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 21 Oct 2001 14:16:18 -0400
Message-Id: <1003688179.1085.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-21 at 11:24, Andrew Morton wrote:
> This one has been reported before.

Colin, can you try Andrew's patch and report back?  This problem has
been reported before -- its a tty bug that preempt (and SMP I wager)
just aggravate.  I have a patch that I know fixes it, but Andrew's is
_much_ simpler.  I will send you that if this fails.  Please let me
know.

> --- linux-2.4.12-ac3/drivers/char/console.c	Mon Oct 15 16:04:23 2001
> +++ ac/drivers/char/console.c	Sun Oct 21 08:19:42 2001
> @@ -2387,9 +2387,15 @@ static void con_flush_chars(struct tty_s
>  		return;
>  
>  	pm_access(pm_con);
> -	acquire_console_sem();
> -	set_cursor(vt->vc_num);
> -	release_console_sem();
> +	if (vt) {
> +		/*
> +		 * If we raced with con_close(), `vt' may be null.
> +		 * Hence this bandaid.   - akpm
> +		 */
> +		acquire_console_sem();
> +		set_cursor(vt->vc_num);
> +		release_console_sem();
> +	}
>  }
>  
>  /*

	Robert Love

