Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUGHUxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUGHUxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUGHUxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 16:53:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30403 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265042AbUGHUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 16:52:34 -0400
Date: Thu, 8 Jul 2004 22:52:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjanv@redhat.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040708205225.GI28324@fs.tum.de>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708120719.GS21264@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 08:07:19AM -0400, Jakub Jelinek wrote:
> On Thu, Jul 08, 2004 at 09:46:39PM +1000, Nigel Cunningham wrote:
> > In response to a user report that suspend2 was broken when compiled with
> > gcc 3.4, I upgraded my compiler to 3.4.1-0.1mdk. I've found that the
> > restore_processor_context, defined as follows:
> > 
> > static inline void restore_processor_context(void)
> > 
> > doesn't get inlined. GCC doesn't complain when compiling the file, and
> > so far as I can see, there's no reason for it not to inline the routine.
> 
> Try passing -Winline, it will tell you when a function marked inline is not
> actually inlined.
> Presence of inline keyword is not a guarantee the function will not be
> inlined, it is a hint to the compiler.
> GCC 3.4 is much bettern than earlier 3.x GCCs in actually inlining functions
> marked as inline, but there are still cases when it decides not to inline
> for various reasons.  E.g. in C++ world, lots of things are inline, yet
> honoring that everywhere would mean very inefficient huge programs.
> If a function relies for correctness on being inlined, then it should use
> inline __attribute__((always_inline)).

include/linux/compiler-gcc3.h says:

<--  snip  -->

#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
# define inline         __inline__ __attribute__((always_inline))
# define __inline__     __inline__ __attribute__((always_inline))
# define __inline       __inline__ __attribute__((always_inline))
#endif

<--  snip  -->


@Arjan:
This was added as part of your
  [PATCH] ia32: 4Kb stacks (and irqstacks) patch
What's the recommended solution for Nigel's problem?


> 	Jakub

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

