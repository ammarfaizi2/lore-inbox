Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbTCGKxh>; Fri, 7 Mar 2003 05:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbTCGKxh>; Fri, 7 Mar 2003 05:53:37 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:8175 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261488AbTCGKxg>;
	Fri, 7 Mar 2003 05:53:36 -0500
Date: Fri, 7 Mar 2003 12:03:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove spare cast
In-Reply-To: <200303070214.h272Ehp22067@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0303071201510.13981-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1068.10.40, 2003/03/06 17:44:05-08:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] remove spare cast
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1068.10.39 -> 1.1068.10.40
> #	drivers/ide/ide-lib.c	1.6     -> 1.7    
> #
> 
>  ide-lib.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
> --- a/drivers/ide/ide-lib.c	Thu Mar  6 18:14:45 2003
> +++ b/drivers/ide/ide-lib.c	Thu Mar  6 18:14:45 2003
> @@ -171,7 +171,7 @@
>  		BUG();
>  	return min(speed, speed_max[mode]);
>  #else /* !CONFIG_BLK_DEV_IDEDMA */
> -	return min(speed, (u8)XFER_PIO_4);
> +	return min(speed, XFER_PIO_4);
>  #endif /* CONFIG_BLK_DEV_IDEDMA */

This reintroduces the following warning (with gcc-2.95.2 and gcc-3.2)

| drivers/ide/ide-lib.c:174: warning: comparison of distinct pointer types
| lacks a cast

which the cast was supposed to kill.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

