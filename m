Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVL1Orq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVL1Orq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVL1Orq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:47:46 -0500
Received: from mx.pathscale.com ([64.160.42.68]:19885 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964828AbVL1Orp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:47:45 -0500
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org
In-Reply-To: <20051228035231.GA3356@waste.org>
References: <patchbomb.1135726914@eng-12.pathscale.com>
	 <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
	 <20051228035231.GA3356@waste.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 28 Dec 2005 06:47:42 -0800
Message-Id: <1135781263.1527.89.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 21:52 -0600, Matt Mackall wrote:
> On Tue, Dec 27, 2005 at 03:41:55PM -0800, Bryan O'Sullivan wrote:
> > +/*
> > + * MMIO copy routines.  These are guaranteed to operate in units denoted
> > + * by their names.  This style of operation is required by some devices.
> > + */
> 
> Using kdoc style for new code is nice.

OK, will do.

> > +extern void fastcall __memcpy_toio32(volatile void __iomem *to, const void *from, size_t count);
> > +
> 
> Minor rant: extern is always redundant for function prototypes in C.

I know.  My intent was to keep the prototype consistent with the
prevailing style of other declarations in that same routine.  If you
think that cleanliness is more important, I'll be happy to change it.

> Suspicious use of volatile - writel is doing the actual write, this
> function never does a dereference.

Yeah.  I lost the plot there a bit.  I'll remove the volatiles.

>  As you've already got private
> copies of the pointers already in s and d, it's perfectily reasonable
> and idiomatic to do:
> 
> 	while (--count >= 0)
> 		__raw_writel(*s++, d++);

But pointer arithmetic is undefined on void pointers.  gcc lets you do
it, but it treats sizeof(void) as 1, which gives entirely the wrong
results in this case.

> And as you appear to be using the __raw.. version to avoid repeated
> mb()s, you probably ought to tack one on at the end.

Well spotted, thanks.

	<b

