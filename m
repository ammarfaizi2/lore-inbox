Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWCaJnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWCaJnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCaJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:43:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59912 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751300AbWCaJnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:43:17 -0500
Date: Fri, 31 Mar 2006 11:43:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
Message-ID: <20060331094315.GB3893@stusta.de>
References: <4426515B.5040307@tlinx.org> <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr> <20060326100639.GE4053@stusta.de> <4427BCCC.4080506@tlinx.org> <4427CE4D.5010109@grupopie.com> <442C4ECF.3080505@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442C4ECF.3080505@tlinx.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 01:34:07PM -0800, Linda Walsh wrote:
>...
> If I "doubled" my stack back to 8K, that would lower the "random
> probability" of hitting a stack limit, but right now, it seems like
> amount of stack "needed" is nearly guesswork.  Sigh.  Having my
> kernel fairly static and minimalistic (no unused modules; no loadable
> modules, etc) I might only "need" 3K.

Things like unused modules or loadable module support should have more 
or less zero impact on stack usage.

> 1) It would be nice if a "stack usage" option could be turned on
> that would do some sort of run-time bounds checking that could
> display the max-stack used "so far" in "/proc".

The -rt kernel contains something like this.

> 2) How difficult would it be to place kernel stack in a "pageable" pool 
> where the limit of valid data in a 4K page is only 3.5K - then
> when a kernel routine tries to exceed the stack boundary, it takes a
> page fault where a "note" could be logged that more stack was "needed",
> then automatically map another 4K page into the stack and return to
> interrupted routine.
> 
> It sounds a bit strange -- the kernel having to call another part of
> the kernel to handle a pagefault within the kernel, but perhaps there
> could be another level of "partitioning" w/in kernel space that would
> allow the non-paging part of the kernel to be paged in/out in a similar
> way to user code. 
>...

This has been discussed to death, and the consensus was that code 
resulting in a too high stack usage should be fixed.

If you find any stack problems with 4k stacks and the automatically 
enabled unit-at-a-time when using gcc 4.x in kernel 2.6.16-mm2, please 
send a bug report.

Regarding unit-at-a-time with gcc 3.x, it works most time for most 
people, but it's completely unsupported. If you want to use 
unit-at-a-time on i386, please use gcc 4.x.

> -l

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

