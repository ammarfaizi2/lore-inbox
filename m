Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVLaVYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVLaVYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVLaVYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 16:24:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61197 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751241AbVLaVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 16:24:42 -0500
Date: Sat, 31 Dec 2005 22:24:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
Message-ID: <20051231212440.GO3811@stusta.de>
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> <adazmmmc9hl.fsf@cisco.com> <1135780804.1527.82.camel@serpentine.pathscale.com> <20051228145114.GL3356@waste.org> <20051230234628.GB3811@stusta.de> <20051230234400.GM3356@waste.org> <Pine.LNX.4.64.0512301559160.3249@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512301559160.3249@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 04:23:46PM -0800, Linus Torvalds wrote:
>...
> > > Where's the problem with the __HAVE_ARCH_* mechanism?
>...
> And no, I don't like the __HAVE_ARCH_xxx mechanisms at all. They are 
> pointless, and hard to follow. If an architecture wants to use a generic 
> mechanism, it should do one of the following (or a combination):
> 
>  - use the config file mechanism, and use
> 
> 	obj-$(CONFIG_GENERIC_FOO) += generic-foo.c
> 
>    in a Makefile to link in the generic version.
> 
>    Examples: CONFIG_RWSEM_GENERIC_SPINLOCK.
> 
>  - just include the generic header from its own header, eg just do a
> 
> 	#include <asm-generic/div64.h>
> 
>    or similar.
> 
> Now, the latter in particular is very easy to follow: if you look into the 
> <asm/div64.h> file and see that it just includes <asm-generic/div64.h>, 
> it's very obvious what is going on and where to find the real 
> implementation. You never have to wonder what the indirection means. 
>...
> Now, the CONFIG_GENERIC_FOO thing is a bit less obvious, and you may have 
> to know about that config option in order to realize that a particular 
> architecture is using a generic library routine, but at least with those 
> Kconfig options, the language to describe them is clean these days, and 
> it's _the_ standard way to express configuration information. So it may be 
> a bit subtler and more indirect, but once you get used to it, it too is 
> very clean.
>...

OK, this I don't have any problem with.

I'm not yet fully convinced that __HAVE_ARCH_xxx is really that bad, but 
your proposed solution doesn't have the problems I had in mind.

What is OK:
  obj-$(CONFIG_GENERIC_FOO) += generic-foo.o

What is not OK:
  lib-y += generic-foo.o

The latter has the following disadvantages:
- it's non-obvious whether the object actually gets included in the 
  kernel
- if the contents of generic-foo.o is only used in modules, 
  generic-foo.o is _not_ included in the kernel resulting in an
  obvious breakage

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

