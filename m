Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSLAKDL>; Sun, 1 Dec 2002 05:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSLAKDL>; Sun, 1 Dec 2002 05:03:11 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:61595 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261582AbSLAKDK>;
	Sun, 1 Dec 2002 05:03:10 -0500
Date: Sun, 1 Dec 2002 11:08:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: vojtech@suse.cz, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 double PCI unregistration with pcigame
Message-ID: <20021201110808.B14392@ucw.cz>
References: <20021201044019.GA965@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021201044019.GA965@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Sun, Dec 01, 2002 at 03:40:19PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 03:40:19PM +1100, Herbert Xu wrote:

> pcigame.c calls pci_unregister_driver() a second time when it is unloaded
> without finding any devices.

I think the proper solution would be:

diff -u -r1.1.1.7 pcigame.c
--- drivers/char/joystick/pcigame.c   28 Nov 2002 23:53:12 -0000 1.1.1.7
+++ drivers/char/joystick/pcigame.c   1 Dec 2002 02:32:08 -0000

@@ -195,7 +195,7 @@

 int __init pcigame_init(void)
 {
-     pci_module_init(&pcigame_driver);
-     /* Needed by other modules */
-     return 0;
+     return pci_module_init(&pcigame_driver);
 }


> -- 
> Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
> Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

> Index: drivers/char/joystick/pcigame.c
> ===================================================================
> RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/char/joystick/pcigame.c,v
> retrieving revision 1.1.1.7
> diff -u -r1.1.1.7 pcigame.c
> --- drivers/char/joystick/pcigame.c	28 Nov 2002 23:53:12 -0000	1.1.1.7
> +++ drivers/char/joystick/pcigame.c	1 Dec 2002 02:32:08 -0000
> @@ -195,7 +195,7 @@
>  
>  int __init pcigame_init(void)
>  {
> -	pci_module_init(&pcigame_driver);
> +	pci_register_driver(&pcigame_driver);
>  	/* Needed by other modules */
>  	return 0;
>  }


-- 
Vojtech Pavlik
SuSE Labs
