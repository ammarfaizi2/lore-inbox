Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291743AbSBHTFe>; Fri, 8 Feb 2002 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291746AbSBHTFZ>; Fri, 8 Feb 2002 14:05:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:6388 "EHLO spit.local")
	by vger.kernel.org with ESMTP id <S291743AbSBHTFO>;
	Fri, 8 Feb 2002 14:05:14 -0500
Message-ID: <3C64213D.6070808@linux-m68k.org>
Date: Fri, 08 Feb 2002 20:04:29 +0100
From: Roman Zippel <zippel@linux-m68k.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: wli@holomorphy.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <20020207234555.N17426@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Troy Benjegerdes wrote:

> +#else /* USE_SLOW_64BIT_DIVIDES */
> +		/*
> +		 * Nasty ugly generic C 64 bit divide on 32 bit machine
> +		 * No one seems to want to take credit for this
> +		 */
> +		unsigned long low, low2, high;
> +		low  = (t) & 0xffffffff;
> +		high = (t) >> 32;
> +		res   = high % base;
> +		high  = high / base;
> +		low2  = low >> 16;
> +		low2 += res << 16;
> +		res   = low2 % base;
> +		low2  = low2 / base;
> +		low   = low & 0xffff;
> +		low  += res << 16;
> +		res   = low  % base;
> +		low   = low  / base;
> +		t = low  + ((long long)low2 << 16) +
> +			((long long) high << 32);


IMO this is large enough to put under lib/..., the rest could also be 
put into asm-generic, from where the archs could include it, this would 
avoid this:

 > +#ifdef __USE_ASM
 > +/* yeah, this is a mess, and leaves out m68k.... */
 > +# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) || 
defined(CONFIG_MIPS)
 > +#  define __USE_ASM__
 > +# endif
 > +#endif

bye, Roman

