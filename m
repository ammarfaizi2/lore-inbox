Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbSKLRde>; Tue, 12 Nov 2002 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266628AbSKLRde>; Tue, 12 Nov 2002 12:33:34 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:43225 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266627AbSKLRdd>;
	Tue, 12 Nov 2002 12:33:33 -0500
Date: Tue, 12 Nov 2002 17:40:11 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: Users locking memory using futexes
Message-ID: <20021112174011.GB14034@bjl1.asuk.net>
References: <20021112052113.GA12452@bjl1.asuk.net> <Pine.LNX.4.44.0211121000280.5877-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211121000280.5877-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > It would be nice if the futex waitqueues could be re-hashed against swap
> > entries when pages are swapped out, somehow, but this sounds hard.
> 
> yes it sounds hard (and somewhat expensive). The simple solution would be
> to hash against the pte address, which is an invariant over swapout - but
> that breaks inter-process futexes. The hard way would be to rehash the
> futex at the pte address upon swapout, and rehash it with the new physical
> page upon swapin. The pte chain case has to be careful, and rehashing
> should only be done when the physical page is truly unmapped even in the
> last process context.

Can't it be hashed against (address space, offset) for shared
mappings, and against (mm, pte address) for private mappings?

-- Jamie
