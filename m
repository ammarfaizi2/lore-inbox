Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275716AbRJJNZ2>; Wed, 10 Oct 2001 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275719AbRJJNZS>; Wed, 10 Oct 2001 09:25:18 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:54025 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S275716AbRJJNZI>; Wed, 10 Oct 2001 09:25:08 -0400
Date: Wed, 10 Oct 2001 17:24:31 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Paul McKenney <Paul.McKenney@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, Jay.Estabrook@compaq.com,
        Peter Rival <frival@zk3.dec.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010172431.A6468@jurassic.park.msu.ru>
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com> <20011010040502.A726@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011010040502.A726@athlon.random>; from andrea@suse.de on Wed, Oct 10, 2001 at 04:05:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 04:05:02AM +0200, Andrea Arcangeli wrote:
> So before changing any code, I would prefer to double check with the
> current alpha architects that the read dependency really isn't enough to
> enforce read ordering without the need of rmb also on the beleeding edge
> ev6/ev67/etc.. cores. So potentially as worse we'd need to redefine
> wmb() as wmbdd() (and friends) only for EV5+SMP compiles of the kernel,
> but we wouldn't be affected with any recent hardware compiling for
> EV6/EV67.  Jay, Peter, comments?

21264 Compiler Writer's Guide [appendix C] explicitly says that the
second load cannot issue if its address depends on a result of previous
load until that result is available. I refuse to believe that it isn't
true for older alphas, especially because they are strictly in-order
machines, unlike ev6.

I suspect some confusion here - probably that architect meant loads
to independent addresses. Of course, in this case mb() is required
to assure ordering.

Ivan.
