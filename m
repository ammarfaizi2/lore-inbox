Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUL2CAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUL2CAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUL2B7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:59:52 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:39433 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261296AbUL2B7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:59:41 -0500
Message-ID: <41D2104D.3010406@conectiva.com.br>
Date: Wed, 29 Dec 2004 00:02:53 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Small patch below adds loglevels to a few printk's in net/ipv4/route.c
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-orig/net/ipv4/route.c linux-2.6.10/net/ipv4/route.c
> --- linux-2.6.10-orig/net/ipv4/route.c	2004-12-24 22:35:40.000000000 +0100
> +++ linux-2.6.10/net/ipv4/route.c	2004-12-29 02:55:03.000000000 +0100
> @@ -889,8 +889,8 @@ restart:
>  		printk(KERN_DEBUG "rt_cache @%02x: %u.%u.%u.%u", hash,
>  		       NIPQUAD(rt->rt_dst));
>  		for (trt = rt->u.rt_next; trt; trt = trt->u.rt_next)
> -			printk(" . %u.%u.%u.%u", NIPQUAD(trt->rt_dst));
> -		printk("\n");
> +			printk(KERN_DEBUG " . %u.%u.%u.%u", NIPQUAD(trt->rt_dst));
> +		printk(KERN_DEBUG "\n");
>  	}
>  #endif
>  	rt_hash_table[hash].chain = rt;
> @@ -1802,11 +1802,11 @@ martian_source:
>  			unsigned char *p = skb->mac.raw;
>  			printk(KERN_WARNING "ll header: ");
>  			for (i = 0; i < dev->hard_header_len; i++, p++) {
> -				printk("%02x", *p);
> +				printk(KERN_WARNING "%02x", *p);
>  				if (i < (dev->hard_header_len - 1))
>  					printk(":");
>  			}
> -			printk("\n");
> +			printk(KERN_WARNING "\n");


Are you sure the output is much improved? ;)

- Arnaldo
