Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUATAyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUATAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:52:16 -0500
Received: from are.twiddle.net ([64.81.246.98]:1171 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S265370AbUATAuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:50:03 -0500
Date: Mon, 19 Jan 2004 16:49:54 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modernize i386 string.h
Message-ID: <20040120004954.GA3545@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@muc.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040118200919.GA26573@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118200919.GA26573@averell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 09:09:19PM +0100, Andi Kleen wrote:
> +#define __HAVE_ARCH_MEMCPY 1
> +extern void *__memcpy(void *to, const void *from, size_t len); 
> +#define memcpy(dst,src,len) \
> +	({ size_t __len = (len);				\
> +	   void *__ret;						\
> +	   if (__builtin_constant_p(len) && __len >= 128)	\
> +		 __ret = __memcpy((dst),(src),__len);		\
> +	   else							\
> +		 __ret = __builtin_memcpy((dst),(src),__len);	\
> +	   __ret; }) 

Why not just __builtin_memcpy?  Or indeed, why bother defining
anything at all, since the compiler will infer __builtin_memcpy
from the external symbol memcpy.


r~
