Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUGISlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUGISlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUGISlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:41:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12224 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265212AbUGISk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:40:57 -0400
Date: Fri, 9 Jul 2004 20:40:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040709184050.GR28324@fs.tum.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qohrdel.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 06:51:46AM +0200, Andi Kleen wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> writes:
> 
> I think a better solution would be to apply the appended patch 
> 
> And then just mark the function you know needs to be inlined
> as __always_inline__. I did this on x86-64 for some functions
> too that need to be always inlined (although using the attribute
> directly because all x86-64 compilers support it)
> 
> The rationale is that the inlining algorithm in gcc 3.4+ is quite
> a lot better and actually eliminates some not-so-great inlining
> we had in the past and makes the kernel a bit smaller.

Making the kernel a bit smaller is a small improvement.

Runtime errors caused with gcc 3.4 are IMHO much worse than such a small 
improvement or three dozen compile errors with gcc 3.4 .

The effect of your patch with gcc 3.4 would be nearly:
  Ignore all old inlines and add something new that does what inline
  did before.

Wouldn't it be a better solution if you would audit the existing inlines 
in the kernel for abuse of inline and fix those instead?

> -Andi
> 
> P.S.: compiler.h seems to be not "gcc 4.0 safe". Probably that needs
> to be fixed too.
>...

My copy of compiler.h says:

<--  snip  -->

#if __GNUC__ > 3
# include <linux/compiler-gcc+.h>       /* catch-all for GCC 4, 5, etc. */

<--  snip  -->

What exactly is wrong with this?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

