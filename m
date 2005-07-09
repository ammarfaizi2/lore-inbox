Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVGIMKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVGIMKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVGIMKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:10:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28555 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261353AbVGIMKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:10:48 -0400
Date: Sat, 9 Jul 2005 14:10:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [48/48] Suspend2 2.1.9.8 for 2.6.12: 624-filewriter.patch
Message-ID: <20050709121037.GF1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164443920@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164443920@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/*
> + * sacrifice some compression quality in favour of compression speed.
> + * (roughly 1-2% worse compression for large blocks and
> + * 9-10% for small, redundant, blocks and >>20% better speed in both cases)
> + * In short: enable this for binary data, disable this for text data.
> + */
> +#define ULTRA_FAST 1
> +
> +#define STRICT_ALIGN 0
> +#define USE_MEMCPY 1
> +#define INIT_HTAB 0

Ugly, ugly, ugly. Pick one set of options and use them.

> +/*
> + * don't play with this unless you benchmark!
> + * decompression is not dependent on the hash function
> + * the hashing function might seem strange, just believe me
> + * it works ;)
> + */
> +#define FRST(p) (((p[0]) << 8) + p[1])
> +#define NEXT(v,p) (((v) << 8) + p[2])

Dnt wrt mcr nms lk ths!

> +	if (ctx->first_call) {
> +		ctx->first_call = 0;
> +	}
> +#if INIT_HTAB
> +# if USE_MEMCPY
> +    memset (htab, 0, sizeof (htab));
> +# else
> +    for (hslot = htab; hslot < htab + HSIZE; hslot++)
> +      *hslot++ = ip;
> +# endif
> +#endif


Eh? Use_memcpy and then it memsets?

BTW if it is "contributed code", you may want original contributor to
push it, so that you don't have to do all the lindenting/cleaning/etc
yourself.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
