Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281343AbRKLMeg>; Mon, 12 Nov 2001 07:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281362AbRKLMe0>; Mon, 12 Nov 2001 07:34:26 -0500
Received: from main.sonytel.be ([195.0.45.167]:35277 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S281343AbRKLMeN>;
	Mon, 12 Nov 2001 07:34:13 -0500
Date: Mon, 12 Nov 2001 13:32:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hgafb oopses
In-Reply-To: <Pine.LNX.4.40.0111121325480.8974-100000@drama.koli>
Message-ID: <Pine.GSO.4.21.0111121331290.11251-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Bakonyi Ferenc wrote:
> On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
> > Sorry... Anyway, the old code was broken too, since it wasn't portable.
>
> Is it portable now? Can you test it on non-i386?

Unfortunately not. I don't have HGA hardware.

All I can do is read the code and comment :-)

> > > The patch below is against 2.4.15-pre1. It resolves the ISA address
> > > confusion, replaces scr_{read|write} functions with isa_{read|write},
> > > and elimiates a cosmetic compiler warning about suggested parens.
>
> > But it does some other Bad Things(TM): putting ISA memory _adresses_ and
> > _16_bit_ values in _unsigned_chars_ is not good for your health...
>
> There is no mercy for my brain-damage, patch follows.
>
> --- linux-2.4.15-pre3/drivers/video/hgafb.c	Mon Nov 12 13:16:32 2001
> +++ linux/drivers/video/hgafb.c	Mon Nov 12 13:15:56 2001
> @@ -312,8 +312,8 @@
>  static int __init hga_card_detect(void)
>  {
>  	int count=0;
> -	unsigned char p, p_save;
> -	unsigned char q, q_save;
> +	unsigned long p, q;
> +	unsigned short p_save, q_save;
>
>  	hga_vram_base = 0xb0000;
>  	hga_vram_len  = 0x08000;

Thanks, that looks better!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

