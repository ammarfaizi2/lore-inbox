Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281272AbRKLM3g>; Mon, 12 Nov 2001 07:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281287AbRKLM3R>; Mon, 12 Nov 2001 07:29:17 -0500
Received: from drama.obuda.kando.hu ([193.224.41.14]:65217 "EHLO drama.koli")
	by vger.kernel.org with ESMTP id <S281272AbRKLM3G>;
	Mon, 12 Nov 2001 07:29:06 -0500
Date: Mon, 12 Nov 2001 13:28:22 +0100 (CET)
From: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
X-X-Sender: fero@drama.koli
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hgafb oopses
Message-ID: <Pine.LNX.4.40.0111121325480.8974-100000@drama.koli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi!

On Mon, 12 Nov 2001, Geert Uytterhoeven wrote:
>
> Sorry... Anyway, the old code was broken too, since it wasn't portable.
>

Is it portable now? Can you test it on non-i386?

> > The patch below is against 2.4.15-pre1. It resolves the ISA address
> > confusion, replaces scr_{read|write} functions with isa_{read|write},
> > and elimiates a cosmetic compiler warning about suggested parens.

> But it does some other Bad Things(TM): putting ISA memory _adresses_ and
> _16_bit_ values in _unsigned_chars_ is not good for your health...

There is no mercy for my brain-damage, patch follows.

Regards:
	Ferenc Bakonyi


--- linux-2.4.15-pre3/drivers/video/hgafb.c	Mon Nov 12 13:16:32 2001
+++ linux/drivers/video/hgafb.c	Mon Nov 12 13:15:56 2001
@@ -312,8 +312,8 @@
 static int __init hga_card_detect(void)
 {
 	int count=0;
-	unsigned char p, p_save;
-	unsigned char q, q_save;
+	unsigned long p, q;
+	unsigned short p_save, q_save;

 	hga_vram_base = 0xb0000;
 	hga_vram_len  = 0x08000;

