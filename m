Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVELW0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVELW0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVELW0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:26:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55305 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262157AbVELW0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:26:18 -0400
Date: Fri, 13 May 2005 00:26:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
Subject: Re: [-mm patch] mm.h: fix page_zone compile error
Message-ID: <20050512222616.GD3603@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org> <20050512214258.GC3603@stusta.de> <1115935777.21206.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115935777.21206.11.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 03:09:37PM -0700, Dave Hansen wrote:
> On Thu, 2005-05-12 at 23:42 +0200, Adrian Bunk wrote:
> > On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.12-rc3-mm3:
> > >...
> > > +sparsemem-memory-model.patch
> > >...
> > >  More sparsemem stuff
> > >...
> >
> > This causes the following compile error with gcc 3.4 on i386:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      mm/hugetlb.o
> > mm/hugetlb.c: In function `enqueue_huge_page':
> > include/linux/mm.h:500: sorry, unimplemented: inlining failed in call to 
> > 'page_zone': function not considered for inlining
> > mm/hugetlb.c:486: sorry, unimplemented: called from here
> > make[1]: *** [mm/hugetlb.o] Error 1
> > make: *** [mm] Error 2
> 
> Any idea what actually causes that?
> 
> BTW, it doesn't seem to happen with gcc 2.95.  Can you send me
> your .config?  I'll double-check.

You won't see this error with gcc < 3.4 .

The kernel redefines "inline" to __attribute__((always_inline)).
That's why gcc 3.4 (correctly) aborts the compilation if it can't inline 
it.

gcc 3.4 isn't able to inline a function that wasn't defined before the 
first usage with -fno-unit-at-a-time (and we are currently giving this 
flag on i386).
That's the reason why a function prototype for a "static inline" 
function doesn't help you.

I can send you my .config if these explanations weren't enough.

> -- Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

