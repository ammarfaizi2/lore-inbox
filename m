Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318817AbSG0U3d>; Sat, 27 Jul 2002 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318819AbSG0U3d>; Sat, 27 Jul 2002 16:29:33 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:50611 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S318817AbSG0U3c>;
	Sat, 27 Jul 2002 16:29:32 -0400
Subject: Re: [PATCH] turn vesa framebuffer off at boot 2.4.18
From: Bongani <bonganilinux@mweb.co.za>
To: ptb@it.uc3m.es
Cc: kraxel@goldbach.in-berlin.de, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200207271956.g6RJurv08967@oboe.it.uc3m.es>
References: <200207271956.g6RJurv08967@oboe.it.uc3m.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 27 Jul 2002 22:36:28 +0200
Message-Id: <1027802189.2551.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you areusing lilo the remove the line
vga=788 (NOTE: this number might be different)
or replace it by vga=normal (IIRC)
the other option is to add the vga=normal on the boot param

On Sat, 2002-07-27 at 21:56, Peter T. Breuer wrote:
> 
> I use the same kernel everywhere but when vesa framebuffer is compiled
> into the kernel the text mode console on my laptop doesn't show the
> bottom few lines of the screen.
> 
> So I wanted to turn it off at boot ..  but there didn't seem to be a way
> :-(.  Hence I added the boot param
> 
>      video=vesa:off
> 
> Apologies if it was possible some other way. I believe I've heard
> of some distros providing FB and NONFB kernels. I didn't stop to
> investigate beyond reading the Documentation/fb/*.txt.
> 
> This patch is against the pre-2.4.18 kernel code I had handy.
> Sorry if it needs to be more recent. I don't have another 120M
> to spare for a newer source just now ...
> 
> It works.
> 
> 
> --- vesafb.c.orig	Sat Jul 27 21:42:39 2002
> +++ vesafb.c	Sat Jul 27 21:10:39 2002
> @@ -98,6 +98,7 @@
>  
>  static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
>  static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
> +static int             disable    = 0;  /* added by P. Breuer ptb@it.uc3m.es */
>  static unsigned short  *pmi_base  = 0;
>  static void            (*pmi_start)(void);
>  static void            (*pmi_pal)(void);
> @@ -462,6 +463,8 @@
>  		
>  		if (! strcmp(this_opt, "inverse"))
>  			inverse=1;
> +		else if (! strcmp(this_opt, "off"))
> +			disable=1;
>  		else if (! strcmp(this_opt, "redraw"))
>  			ypan=0;
>  		else if (! strcmp(this_opt, "ypan"))
> @@ -504,6 +507,12 @@
>  int __init vesafb_init(void)
>  {
>  	int i,j;
> +
> +        if (disable) {
> +		printk(KERN_INFO
> +		       "vesafb: aborted on user req (disable)\n");
> +                return -EINVAL;
> +        }
>  
>  	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
>  		return -ENXIO;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


