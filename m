Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274505AbRJJDeO>; Tue, 9 Oct 2001 23:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274509AbRJJDeE>; Tue, 9 Oct 2001 23:34:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:28430 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S274505AbRJJDdv>;
	Tue, 9 Oct 2001 23:33:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15299.49574.450686.706920@cargo.ozlabs.ibm.com>
Date: Wed, 10 Oct 2001 13:33:58 +1000 (EST)
To: Richard Henderson <rth@twiddle.net>
Cc: Paul McKenney <Paul.McKenney@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <20011009100023.A27427@twiddle.net>
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>
	<20011009100023.A27427@twiddle.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson writes:

> I am suggesting that the lock-free algorithms should add the
> read barriers, and that failure to do so indicates that they
> are incomplete.  If nothing else, it documents where the real
> dependancies are.

Please, let's not go adding rmb's in places where there is already an
ordering forced by a data dependency - that will hurt performance
unnecessarily on x86, ppc, sparc, ia64, etc.

It seems to me that there are two viable alternatives:

1. Define an rmbdd() which is a no-op on all architectures except for
   alpha, where it is an rmb.  Richard can then have the job of
   finding all the places where an rmbdd is needed, which sounds like
   one of the smellier labors of Hercules to me. :)  

2. Use Paul McKenney's scheme.

I personally don't really mind which gets chosen.  Scheme 1 will
result in intermittent hard-to-find bugs on alpha (since the vast
majority of kernel hackers will not understand where or why rmbdd's
are required), but if Richard prefers that to scheme 2, it's his call
IMHO.

Regards,
Paul.
