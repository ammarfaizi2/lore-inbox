Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUATBnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUATBmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:42:45 -0500
Received: from colin2.muc.de ([193.149.48.15]:62736 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265191AbUATBjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:39:11 -0500
Date: 20 Jan 2004 02:39:45 +0100
Date: Tue, 20 Jan 2004 02:39:45 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modernize i386 string.h
Message-ID: <20040120013945.GA76524@colin2.muc.de>
References: <20040118200919.GA26573@averell> <20040120004954.GA3545@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120004954.GA3545@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 04:49:54PM -0800, Richard Henderson wrote:
> On Sun, Jan 18, 2004 at 09:09:19PM +0100, Andi Kleen wrote:
> > +#define __HAVE_ARCH_MEMCPY 1
> > +extern void *__memcpy(void *to, const void *from, size_t len); 
> > +#define memcpy(dst,src,len) \
> > +	({ size_t __len = (len);				\
> > +	   void *__ret;						\
> > +	   if (__builtin_constant_p(len) && __len >= 128)	\
> > +		 __ret = __memcpy((dst),(src),__len);		\
> > +	   else							\
> > +		 __ret = __builtin_memcpy((dst),(src),__len);	\
> > +	   __ret; }) 
> 
> Why not just __builtin_memcpy?  Or indeed, why bother defining
> anything at all, since the compiler will infer __builtin_memcpy
> from the external symbol memcpy.

I was considering that when I moved the code over from x86-64.

On x86-64 (in gcc 3.1 timeframe) I did it originally this way 
because memcpy didn't have this "use external for big copies" logic.
I wasn't sure if gcc 3.3 handles it now correctly. If you can
confirm that it does I will happily remove it.

-Andi
