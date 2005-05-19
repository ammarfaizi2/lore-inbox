Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVESBFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVESBFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVESBE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:04:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65262 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262431AbVESBET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:04:19 -0400
Message-ID: <428BE5F9.6070100@mvista.com>
Date: Wed, 18 May 2005 18:03:53 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@lovecn.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] time_after_eq fix
References: <20050518224415.GA5768@lovecn.org>
In-Reply-To: <20050518224415.GA5768@lovecn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hello,
> 
> The two macros time_after and time_after_eq were added to do wrapping
> correctly, but only time_after does it the right way, time_after_eq has
> been wrong since the very beginning(v2.1.127, 07-Nov-1998).  Now this
> patch fixes it.

I may be especially dense today, but could you give an example where your change 
actually gives a result different from what exists?

george
-- 
> 
> And I don't agree with the the original code comment. I don't think this
> is gcc's fault.  If it is "a good compiler" or "a really good compiler",
> trying to be smarter than human, it wouldn't still be a C compiler.
> So I'd like it be removed.
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
> ---
> 
>  jiffies.h |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff -pruN 2.6.12-rc4-mm2/include/linux/jiffies.h 2.6.12-rc4-mm2-cy/include/linux/jiffies.h
> --- 2.6.12-rc4-mm2/include/linux/jiffies.h	2005-03-03 17:12:13.000000000 +0800
> +++ 2.6.12-rc4-mm2-cy/include/linux/jiffies.h	2005-05-19 05:32:52.000000000 +0800
> @@ -102,9 +102,7 @@ static inline u64 get_jiffies_64(void)
>   *
>   * time_after(a,b) returns true if the time a is after time b.
>   *
> - * Do this with "<0" and ">=0" to only test the sign of the result. A
> - * good compiler would generate better code (and a really good compiler
> - * wouldn't care). Gcc is currently neither.
> + * Do this with "<0" and "<=0" to only test the sign of the result.
>   */
>  #define time_after(a,b)		\
>  	(typecheck(unsigned long, a) && \
> @@ -115,7 +113,7 @@ static inline u64 get_jiffies_64(void)
>  #define time_after_eq(a,b)	\
>  	(typecheck(unsigned long, a) && \
>  	 typecheck(unsigned long, b) && \
> -	 ((long)(a) - (long)(b) >= 0))
> +	 ((long)(b) - (long)(a) <= 0))
>  #define time_before_eq(a,b)	time_after_eq(b,a)
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
