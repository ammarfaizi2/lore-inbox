Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUHVVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUHVVuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUHVVuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:50:12 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64471 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267354AbUHVVtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:49:18 -0400
Date: Sun, 22 Aug 2004 17:53:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Keith Owens <kaos@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
In-Reply-To: <Pine.LNX.4.58.0408221318060.17766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408221740090.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408221318060.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Linus Torvalds wrote:

> On Sat, 21 Aug 2004, Zwane Mwaikambo wrote:
> >
> > Pulled from the -tiny tree, the focus of this patch is for reduced kernel
> > image size but in the process we benefit from improved cache performance
> > since it's possible for the common text to be present in cache. This is
> > probably more of a win on shared cache multiprocessor systems like
> > P4/Xeon HT. It's been benchmarked with bonnie++ on 2x and 4x PIII (my
> > ideal target would be a 4x+ logical cpu Xeon).
>
> I _really_ think that if we're going to make spinlocks be out-of-line,
> then we need to out-of-line the preemption code too.

Good point, Bill saw a lot of extra saving by moving the preemption code
out of line too.

> And at that point I'm more than happy to just make it unconditional,
> assuming the profiling thing (which was my only worry) has been verified.

With the readprofile and oprofile changes it's still not that easy to
determine which locks are being contended as the samples generally are
being charged to the function the lock is being contended in. So some
investigation has to be done when looking at profiles. This could be
remedied by making the valid PC range include data or, preferably, moving
spinlock variables into a special section. That way we can simply
report back the lock word during sampling.

> And I suspect that the all-C version is pretty much equivalent to the
> assembler one, if you use FASTCALL() to make gcc at least use register
> argument passing conventions. The advantage is much clearer code, I'd say.

Yes i agree there and it would probably allow for better optimisation by
gcc during call setup.

Thanks,
	Zwane
