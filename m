Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSG1SCp>; Sun, 28 Jul 2002 14:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSG1SCp>; Sun, 28 Jul 2002 14:02:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49495 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316996AbSG1SCn>; Sun, 28 Jul 2002 14:02:43 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of  PAGE_{CACHE_,}{MASK,ALIGN}
References: <E17YRp5-0006H6-00@storm.christs.cam.ac.uk>
	<3D42D706.9899A4A0@zip.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2002 11:53:55 -0600
In-Reply-To: <3D42D706.9899A4A0@zip.com.au>
Message-ID: <m11y9nivrg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Anton Altaparmakov wrote:
> > 
> > Linus,
> > 
> > This patch introduces 64-bit versions of PAGE_{CACHE_,}MASK and
> > PAGE_{CACHE_,}ALIGN:
> >         PAGE_{CACHE_,}MASK_LL and PAGE_{CACHE_,}ALIGN_LL.
> > 
> > These are needed when 64-bit values are worked with on 32-bit
> > architectures, otherwise the high 32-bits are destroyed.
> > 
> > ...
> >  #define PAGE_SIZE      (1UL << PAGE_SHIFT)
> >  #define PAGE_MASK      (~(PAGE_SIZE-1))
> > +#define PAGE_MASK_LL   (~(u64)(PAGE_SIZE-1))
> 
> The problem here is that we've explicitly forced the
> PAGE_foo type to unsigned long.
> 
> If we instead take the "UL" out of PAGE_SIZE altogether,
> the compiler can then promote the type of PAGE_SIZE and PAGE_MASK
> to the widest type being used in the expression (ie: long long)
> and everything should work.
> 
> Which seems to be a much cleaner solution, if it works.
> 
> Will it work?

I don't quite see the point of this work.

There is exactly one operation that must be done in 64bit.
if (my64bitval > max) {
        return -E2BIG;
}
After that the value can be broken into, an index/offset pair.
Which is how the data is used in the page cache.


Eric
