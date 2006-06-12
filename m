Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWFLRzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFLRzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWFLRzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:55:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29452 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750720AbWFLRzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:55:11 -0400
Date: Mon, 12 Jun 2006 19:55:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
Message-ID: <20060612175509.GC30587@stusta.de>
References: <200606121317_MC3-1-C23A-4F2D@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606121317_MC3-1-C23A-4F2D@compuserve.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 01:14:34PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <448C85B7.1010902@labri.fr>
> 
> On Sun, 11 Jun 2006 23:05:59 +0200, Emmanuel Fleury wrote:
> 
> > > Looking at the generated code, it seems the compiler just makes dumb
> > > choices and tends to recompute current_thread_info() in unlikely code
> > > paths even when there is no register pressure.  4.0.2 makes better
> > > choices.
> >
> > What size with gcc 4.1.2 ? (just curiosity)
> 
> The 3.3 vs 4.0 comparisons were with two different configs, so only
> relative gain/loss with asm vs. C could be compared.
> 
> I downloaded gcc 4.1.1 and compared to 4.0.2 with the exact same config,
> since I was curious how much better it might be overall.
> 
> gcc 4.0.2:
>    text	   data	    bss	    dec	    hex	filename
> 3645212	 555556	 312024	4512792	 44dc18	2.6.17-rc6-nb-C/vmlinux
> 3647276	 555556	 312024	4514856	 44e428	2.6.17-rc6-nb-asm/vmlinux
>   -2064
> 
> gcc 4.1.1:
>    text	   data	    bss	    dec	    hex	filename
> 3614686	 520416	 311672	4446774	 43da36	2.6.17-rc6-nb-C/vmlinux
> 3616942	 520416	 311672	4449030	 43e306	2.6.17-rc6-nb-asm/vmlinux
>   -2256
> 
> Kernel code starts out ~30K bytes smaller with gcc 4.1 and using C
> for current_thread_info() helps even more than with 4.0.  Nice...
> 
> Maybe a patch that enables C code for gcc 4.0+ would work, since
> on 3.3 the asm code is better?


No.

gcc 3.3 is still supported, and it's important that the kernel runs 
correctly when compiled with this compiler (implying workarounds for 
compiler bugs).

But for best performance, people should always use the latest gcc.
(And if there was a case where usage of the latest gcc would give a 
 worse performance, that would be a bug in gcc and/or the kernel that
 should be reported.)

So unless there's a _really_ significant regression with older gcc 
versions, adding #ifdef's for such micro optimizations is not worth it.


> Chuck


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

