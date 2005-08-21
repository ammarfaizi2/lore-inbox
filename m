Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVHUVFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVHUVFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVHUVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:04:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52936 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751096AbVHUVE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:04:57 -0400
Date: Sun, 21 Aug 2005 21:54:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka Enberg <penberg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] kcalloc(): INT_MAX -> ULONG_MAX
Message-ID: <20050821195434.GC5726@stusta.de>
References: <20050820193237.GG3615@stusta.de> <84144f0205082112477979b053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f0205082112477979b053@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 10:47:13PM +0300, Pekka Enberg wrote:
> On 8/20/05, Adrian Bunk <bunk@stusta.de> wrote:
> > This change could (at least in theory) allow a compiler better
> > optimization (especially in the n=1 case).
> > 
> > The practical effect seems to be nearly zero:
> >     text           data     bss      dec            hex filename
> > 25617207        5850138 1827016 33294361        1fc0819 vmlinux-old
> > 25617191        5850138 1827016 33294345        1fc0809 vmlinux-patched
> > 
> > Is there any reason against this patch?
> 
> Looks ok to me.
> 
> On 8/20/05, Adrian Bunk <bunk@stusta.de> wrote:
> >  static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> >  {
> > -       if (n != 0 && size > INT_MAX / n)
> > +       if (n != 0 && size > ULONG_MAX / n)
> 
> You'll probably get even better code if you change the above to:
> 
>     if (size != 0 && n > ULONG_MAX / size)
> 
> Reason being that size is virtually always a constant so the compiler
> can evaluate the division at compile-time.

I doubt this would make any difference.

And besides, except in some rare cases, the second argument is a 
sizeof(foo) whose size is already known at compile time.

>                                   Pekka

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

