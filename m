Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRJJCFR>; Tue, 9 Oct 2001 22:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJJCFB>; Tue, 9 Oct 2001 22:05:01 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44313 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273881AbRJJCEj>; Tue, 9 Oct 2001 22:04:39 -0400
Date: Wed, 10 Oct 2001 04:05:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, Jay.Estabrook@compaq.com,
        Peter Rival <frival@zk3.dec.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010040502.A726@athlon.random>
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>; from Paul.McKenney@us.ibm.com on Tue, Oct 09, 2001 at 08:45:15AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:45:15AM -0700, Paul McKenney wrote:
> Please see the example above.  I do believe that my algorithms are
> reliably forcing proper read ordering using IPIs, just in an different
> way.  Please note that I have discussed this algorithm with Alpha
> architects, who believe that it is sound.

The IPI way is certainly safe.

The point here is that it is suprisingly that alpha needs this IPI
unlike all other architectures. So while the IPI is certainly safe we
wouldn't expect it to be necessary on alpha either.

Now my only worry is that when you worked on this years ago with the
alpha architects there were old chips, old caches and old machines (ev5
maybe?).

So before changing any code, I would prefer to double check with the
current alpha architects that the read dependency really isn't enough to
enforce read ordering without the need of rmb also on the beleeding edge
ev6/ev67/etc.. cores. So potentially as worse we'd need to redefine
wmb() as wmbdd() (and friends) only for EV5+SMP compiles of the kernel,
but we wouldn't be affected with any recent hardware compiling for
EV6/EV67.  Jay, Peter, comments?

Andrea
