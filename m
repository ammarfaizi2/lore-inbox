Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbTCOVkh>; Sat, 15 Mar 2003 16:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbTCOVkh>; Sat, 15 Mar 2003 16:40:37 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:54729 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261578AbTCOVkf>;
	Sat, 15 Mar 2003 16:40:35 -0500
Date: Sat, 15 Mar 2003 22:51:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bitmaps/bitops
In-Reply-To: <33987.4.64.238.61.1047762573.squirrel@www.osdl.org>
Message-ID: <Pine.GSO.4.21.0303152249410.17014-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, Randy.Dunlap wrote:
> Not picking on this code, but as an example:
> 
> drivers/ieee1394/ieee1394_transactions.c, line 152 (in 2.5.64),
> uses:  test_and_set_bit(bit_number, tp->pool),
> 
> where tp->pool is declared by using a DECLARE_BITMAP(), like so:
> struct hpsb_tlabel_pool {
> 	DECLARE_BITMAP(pool, 64);
> 
> That makes sense (at least to me), but gcc complains about the
> type of <pool> when used in test_and_set_bit():
>   drivers/ieee1394/ieee1394_transactions.c:152: warning: passing arg 2 of
> `test_and_set_bit' from incompatible pointer type
> 
> Is this an error, a bug, a nuisance, or just another "ignore gcc 2.96"
> problem?
> 
> For reference, DECLARE_BITMAP() generates an array of unsigned longs:
> #define DECLARE_BITMAP(name,bits) \
> 	unsigned long name[BITS_TO_LONGS(bits)]
> but the prototype for test_and_set_bit() depends on $(ARCH), and it's
> not consistent, with the second arg (bitmap address) being one of:
>   volatile void *
>   void *
>   volatile unsigned long *
> 
> 
> If there's (kernel) surgery required here, unless it's trivial, I think
> that I'd leave it for early 2.7.

Bitops operate on long. Architectures for which it really matters have used
`unsigned long *' in there function signatures since quite some time.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

