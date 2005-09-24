Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVIXKxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVIXKxg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 06:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVIXKxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 06:53:36 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27093 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932156AbVIXKxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 06:53:35 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Make kzalloc a macro
Date: Sat, 24 Sep 2005 13:52:54 +0300
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, ioe-lkml@rameria.dem,
       linux-kernel@vger.kernel.org
References: <4333A109.2000908@yahoo.com.au> <2cd57c9005092302174e0f657e@mail.gmail.com> <Pine.LNX.4.62.0509230857190.22086@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509230857190.22086@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241352.54426.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 18:58, Christoph Lameter wrote:
> How about this patch making kzalloc a macro?
> 
> ---
> 
> Make kzalloc a macro and use __GFP_ZERO for zeroed slab allocations
> 
> kzalloc is right now a function call. The optimization that the kmalloc macro
> provides does not work for kzalloc invocations. kmalloc also determines the
> slab to use at compile time and fails the compilation if the size is too big.
> kzalloc cannot do not.
> 
>  
> -extern void *kzalloc(size_t, unsigned int __nocast);
> +#define kzalloc(__size, __flags) kmalloc(__size, (__flags) | __GFP_ZERO)

Why macro and not an inline function?

> +static inline void *obj_checkout(kmem_cache_t *cachep, unsigned int __nocast flags, void *objp)
> +{
> +	if (likely(objp)) {
> +		objp = cache_alloc_debugcheck_after(cachep, flags, objp,
> +					__builtin_return_address(0));
> +		if (unlikely(flags & __GFP_ZERO))

Why unlikely?

> +			memset(objp, 0, obj_reallen(cachep));
> +		else
> +			prefetchw(objp);
> +	}
> +	return objp;
> +}
--
vda
