Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVCJJdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVCJJdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVCJJdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:33:43 -0500
Received: from witte.sonytel.be ([80.88.33.193]:57230 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262475AbVCJJdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:33:40 -0500
Date: Thu, 10 Mar 2005 10:33:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Mackall <mpm@selenic.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: Create new rol32/ror32 bitops
In-Reply-To: <200503082005.j28K5lBp028415@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0503101032500.9286@numbat.sonytel.be>
References: <200503082005.j28K5lBp028415@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Linux Kernel Mailing List wrote:
> --- a/include/linux/bitops.h	2005-03-08 12:05:59 -08:00
> +++ b/include/linux/bitops.h	2005-03-08 12:05:59 -08:00
> @@ -134,4 +134,26 @@
>  	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
>  }
>  
> +/*
> + * rol32 - rotate a 32-bit value left
> + *
> + * @word: value to rotate
> + * @shift: bits to roll
> + */
> +static inline __u32 rol32(__u32 word, int shift)
                                         ^^^
> +{
> +	return (word << shift) | (word >> (32 - shift));
> +}
> +
> +/*
> + * ror32 - rotate a 32-bit value right
> + *
> + * @word: value to rotate
> + * @shift: bits to roll
> + */
> +static inline __u32 ror32(__u32 word, int shift)
                                         ^^^
> +{
> +	return (word >> shift) | (word << (32 - shift));
> +}
> +
>  #endif

`unsigned int', while we're at it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
