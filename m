Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275759AbRJJNli>; Wed, 10 Oct 2001 09:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275765AbRJJNl2>; Wed, 10 Oct 2001 09:41:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18700 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S275759AbRJJNlR>; Wed, 10 Oct 2001 09:41:17 -0400
Date: Wed, 10 Oct 2001 15:41:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Paul McKenney <Paul.McKenney@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, Jay.Estabrook@compaq.com,
        Peter Rival <frival@zk3.dec.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010154111.R726@athlon.random>
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com> <20011010040502.A726@athlon.random> <20011010172431.A6468@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010172431.A6468@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Wed, Oct 10, 2001 at 05:24:31PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 05:24:31PM +0400, Ivan Kokshaysky wrote:
> On Wed, Oct 10, 2001 at 04:05:02AM +0200, Andrea Arcangeli wrote:
> > So before changing any code, I would prefer to double check with the
> > current alpha architects that the read dependency really isn't enough to
> > enforce read ordering without the need of rmb also on the beleeding edge
> > ev6/ev67/etc.. cores. So potentially as worse we'd need to redefine
> > wmb() as wmbdd() (and friends) only for EV5+SMP compiles of the kernel,
> > but we wouldn't be affected with any recent hardware compiling for
> > EV6/EV67.  Jay, Peter, comments?
> 
> 21264 Compiler Writer's Guide [appendix C] explicitly says that the
> second load cannot issue if its address depends on a result of previous
> load until that result is available. I refuse to believe that it isn't

Fine, btw I also recall to have read something on those lines, and not
even in the 21264 manual but in the alpha reference manual that would
apply to all the chips but I didn't find it with a short lookup. Thanks
for checking!

> true for older alphas, especially because they are strictly in-order
> machines, unlike ev6.

Yes, it sounds strange. However According to Paul this would not be the
cpu but a cache coherency issue. rmb() would enforce the cache coherency
etc... so maybe the issue is related to old SMP motherboard etc... not
even to the cpus ... dunno. But as said it sounded very strange that
also new chips and new boards have such a weird reodering trouble.

> I suspect some confusion here - probably that architect meant loads
> to independent addresses. Of course, in this case mb() is required
> to assure ordering.
> 
> Ivan.


Andrea
