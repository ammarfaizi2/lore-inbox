Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVAYVPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVAYVPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVAYVOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:14:10 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24336 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262148AbVAYVDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:03:11 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
Date: Tue, 25 Jan 2005 23:02:55 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <2.314297600@selenic.com>
In-Reply-To: <2.314297600@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252302.55038.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 23:41, Matt Mackall wrote:
> --- rnd2.orig/include/linux/bitops.h	2005-01-19 22:57:54.000000000 -0800
> +++ rnd2/include/linux/bitops.h	2005-01-20 09:20:24.641660815 -0800
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
> +{
> +	return (word >> shift) | (word << (32 - shift));
> +}
> +
>  #endif

gcc generates surprisingly good assembly for this,
I coudn't beat it for 32bit rotations. Cool!

So you are absolutely right here with not trying
to asm optimize it.

OTOH 64bit gcc rol is worse.
--
vda

