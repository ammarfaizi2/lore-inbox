Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVG2RtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVG2RtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVG2RtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:49:18 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:14347 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262678AbVG2RtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:49:16 -0400
Date: Fri, 29 Jul 2005 13:49:04 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
In-Reply-To: <Pine.LNX.4.58.0507291022500.3307@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0507291347450.886@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
 <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
 <20050728213543.6264ca60.akpm@osdl.org> <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
 <Pine.LNX.4.58.0507291022500.3307@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Linus Torvalds wrote:

> Thanks. Just out of interest, does this patch fix it instead?

Indeed it does, thanks Linus!

-cp

> ----
> diff --git a/include/asm-i386/bitops.h b/include/asm-i386/bitops.h
> --- a/include/asm-i386/bitops.h
> +++ b/include/asm-i386/bitops.h
> @@ -335,14 +335,13 @@ static inline unsigned long __ffs(unsign
>  static inline int find_first_bit(const unsigned long *addr, unsigned size)
>  {
>  	int x = 0;
> -	do {
> -		if (*addr)
> -			return __ffs(*addr) + x;
> -		addr++;
> -		if (x >= size)
> -			break;
> +
> +	while (x < size) {
> +		unsigned long val = *addr++;
> +		if (val)
> +			return __ffs(val) + x;
>  		x += (sizeof(*addr)<<3);
> -	} while (1);
> +	}
>  	return x;
>  }
>  
> 

-- 
"Democracy can learn some things from Communism; for example,
   when a Communist politician is through, he is through."
                        -- Unknown
