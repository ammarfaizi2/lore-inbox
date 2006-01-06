Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWAFGm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWAFGm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWAFGm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:42:56 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:49066 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932649AbWAFGm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:42:56 -0500
Message-ID: <43BE1168.1090706@cosmosbay.com>
Date: Fri, 06 Jan 2006 07:42:48 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: Fix bug in int_sqrt() for 64 bit longs
References: <43BDFC8B.9020805@bigpond.net.au>
In-Reply-To: <43BDFC8B.9020805@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams a écrit :
> The implementation of int_sqrt() assumes that longs have 32 bits.  On 
> systems that have 64 bit longs this will result in gross errors when the 
> argument to the function is greater than 2^32 - 1 on such systems. I 
> doubt whether any such use is currently made of int_sqrt() but the 
> attached patch fixes the problem anyway.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: GIT-warnings/lib/int_sqrt.c
> ===================================================================
> --- GIT-warnings.orig/lib/int_sqrt.c	2005-10-25 13:55:22.000000000 +1000
> +++ GIT-warnings/lib/int_sqrt.c	2006-01-06 14:29:19.000000000 +1100
> @@ -15,7 +15,7 @@ unsigned long int_sqrt(unsigned long x)
>  	op = x;
>  	res = 0;
>  
> -	one = 1 << 30;
> +	one = 1 << (BITS_PER_LONG - 2);
>  	while (one > op)
>  		one >>= 2;
>  

Are you sure it works ?

I would have writen :

one = 1L << (BITS_PER_LONG - 2);

Eric
