Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVANLL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVANLL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 06:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVANLL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 06:11:27 -0500
Received: from colin2.muc.de ([193.149.48.15]:50436 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261954AbVANLLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 06:11:22 -0500
Date: 14 Jan 2005 12:11:21 +0100
Date: Fri, 14 Jan 2005 12:11:21 +0100
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: clameter@sgi.com, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview II
Message-ID: <20050114111121.GA81555@muc.de>
References: <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com> <20050114043944.GB41559@muc.de> <m14qhkr4sd.fsf_-_@muc.de> <1105678742.5402.109.camel@npiggin-nld.site> <20050114104732.GB72915@muc.de> <41E7A58C.5010805@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E7A58C.5010805@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 09:57:16PM +1100, Nick Piggin wrote:
> Andi Kleen wrote:
> >>I have a question for the x86 gurus. We're currently using the lock
> >>prefix for set_64bit. This will lock the bus for the RMW cycle, but
> >>is it a prerequisite for the atomic 64-bit store? Even on UP?
> >
> >
> >An atomic 64bit store doesn't need a lock prefix. A cmpxchg will
> >need to though.
> 
> Are you sure the cmpxchg8b need a lock prefix? Sure it does to

If you want it to be atomic on SMP then yes.

> get the proper "atomic cmpxchg" semantics, but what about a
> simple 64-bit store... If it boils down to 8 byte load, 8 byte

A 64bit store with a 64bit store instruction is atomic. But 
to do that on 32bit x86 you need SSE/MMX (not an option in the kernel)
or cmpxchg8 

> store on the memory bus, and that store is atomic, then maybe
> a lock isn't needed at all?

More complex operations than store or load are not atomic without
LOCK (and not all operations can have a lock prefix). There are a few 
instructions with implicit lock. If you want the gory details read 
chapter 7 in the IA32 Software Developer's Manual Volume 3.

-Andi

