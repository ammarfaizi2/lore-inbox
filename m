Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSKLHtb>; Tue, 12 Nov 2002 02:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSKLHta>; Tue, 12 Nov 2002 02:49:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53215 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266292AbSKLHta>;
	Tue, 12 Nov 2002 02:49:30 -0500
Date: Tue, 12 Nov 2002 10:11:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, <linux-kernel@vger.kernel.org>
Subject: Re: Users locking memory using futexes
In-Reply-To: <20021112052113.GA12452@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211121000280.5877-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Nov 2002, Jamie Lokier wrote:

> It would be nice if the futex waitqueues could be re-hashed against swap
> entries when pages are swapped out, somehow, but this sounds hard.

yes it sounds hard (and somewhat expensive). The simple solution would be
to hash against the pte address, which is an invariant over swapout - but
that breaks inter-process futexes. The hard way would be to rehash the
futex at the pte address upon swapout, and rehash it with the new physical
page upon swapin. The pte chain case has to be careful, and rehashing
should only be done when the physical page is truly unmapped even in the
last process context.

but this should indeed solve the page lockdown problem.

	Ingo

