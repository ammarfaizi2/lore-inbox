Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTHXKtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 06:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTHXKtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 06:49:31 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:25066 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263107AbTHXKt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 06:49:29 -0400
Date: Sun, 24 Aug 2003 12:49:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 2.6.0-test4 IDE warning
In-Reply-To: <200308231705.h7NH5Ai6024024@harpo.it.uu.se>
Message-ID: <Pine.GSO.4.21.0308241248130.14076-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003, Mikael Pettersson wrote:
> Compiling IDE in 2.6.0-test4 with CONFIG_BLK_DEV_IDEDMA=n results in:
> 
>   gcc -Wp,-MD,drivers/ide/.ide-lib.o.d -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i486 -Iinclude/asm-i386/mach-default -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i486 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_lib -DKBUILD_MODNAME=ide_lib -c -o drivers/ide/ide-lib.o drivers/ide/ide-lib.c
> drivers/ide/ide-lib.c: In function `ide_rate_filter':
> drivers/ide/ide-lib.c:173: warning: comparison of distinct pointer types lacks a cast
> 
> This is because the type-checking min() macro is applied to a u8
> variable and an int constant, resulting in a type mismatch. Fix below.

Alan rejected this a while ago. He said he'd more like the speed parameter
become an int, but that that would require more changes.

> (CONFIG_BLK_DEV_IDEDMA=n is what one gets on an old PCI-less 486.)
> 
> /Mikael
> 
> --- linux-2.6.0-test4/drivers/ide/ide-lib.c.~1~	2003-08-09 11:54:06.000000000 +0200
> +++ linux-2.6.0-test4/drivers/ide/ide-lib.c	2003-08-23 18:43:52.000000000 +0200
> @@ -170,7 +170,7 @@
>  		BUG();
>  	return min(speed, speed_max[mode]);
>  #else /* !CONFIG_BLK_DEV_IDEDMA */
> -	return min(speed, XFER_PIO_4);
> +	return min(speed, (u8)XFER_PIO_4);
>  #endif /* CONFIG_BLK_DEV_IDEDMA */
>  }
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

