Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSLAKiF>; Sun, 1 Dec 2002 05:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSLAKiF>; Sun, 1 Dec 2002 05:38:05 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:18442 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S261599AbSLAKiF>; Sun, 1 Dec 2002 05:38:05 -0500
Date: Sun, 1 Dec 2002 21:45:02 +1100
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 double PCI unregistration with pcigame
Message-ID: <20021201104502.GA19773@gondor.apana.org.au>
References: <20021201044019.GA965@gondor.apana.org.au> <20021201110808.B14392@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201110808.B14392@ucw.cz>
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 11:08:08AM +0100, Vojtech Pavlik wrote:
>
> I think the proper solution would be:

This wouldn't work since trident.o requires pcigame.o to work even
though the latter may not discover any devices on its own.  That's
why that comment is there.

> diff -u -r1.1.1.7 pcigame.c
> --- drivers/char/joystick/pcigame.c   28 Nov 2002 23:53:12 -0000 1.1.1.7
> +++ drivers/char/joystick/pcigame.c   1 Dec 2002 02:32:08 -0000
> 
> @@ -195,7 +195,7 @@
> 
>  int __init pcigame_init(void)
>  {
> -     pci_module_init(&pcigame_driver);
> -     /* Needed by other modules */
> -     return 0;
> +     return pci_module_init(&pcigame_driver);
>  }
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
