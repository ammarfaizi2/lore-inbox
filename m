Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272717AbRISTqq>; Wed, 19 Sep 2001 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272897AbRISTq0>; Wed, 19 Sep 2001 15:46:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272717AbRISTqS>; Wed, 19 Sep 2001 15:46:18 -0400
Subject: Re: Linux 2.4.10-pre12
To: Geert.Uytterhoeven@sonycom.com (Geert Uytterhoeven)
Date: Wed, 19 Sep 2001 20:51:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Development),
        linux-m68k@lists.linux-m68k.org (Linux/m68k)
In-Reply-To: <Pine.GSO.4.21.0109190851450.14079-100000@mullein.sonytel.be> from "Geert Uytterhoeven" at Sep 19, 2001 08:54:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jnN7-0003hs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   - There should be a test for a failed kmalloc()
>   - sun3fb_init_fb() returns void (it returns int in the m68k tree)
> 
> diff -u --recursive --new-file v2.4.9/linux/drivers/video/sun3fb.c linux/drivers/video/sun3fb.c
> --- v2.4.9/linux/drivers/video/sun3fb.c	Thu Apr 26 22:17:27 2001
> +++ linux/drivers/video/sun3fb.c	Mon Sep 17 22:52:35 2001
> @@ -586,9 +586,11 @@
>  	fb->cursor.hwsize.fbx = 32;
>  	fb->cursor.hwsize.fby = 32;
>  	
> -	if (depth > 1 && !fb->color_map)
> +	if (depth > 1 && !fb->color_map) {
>  		fb->color_map = kmalloc(256 * 3, GFP_ATOMIC);
> -		
> +		return -ENOMEM;
> +	}
> +			

its a weird corruption of the patch that I had. Im not quite sure what
has happened there. Lower down there is a random -ENODEV without a return
too.

I'll dig out the originals and send Linus something sane
