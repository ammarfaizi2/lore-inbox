Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVANRBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVANRBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVANRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:01:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24249 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262021AbVANRBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:01:03 -0500
Date: Fri, 14 Jan 2005 08:57:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview II
In-Reply-To: <20050114111121.GA81555@muc.de>
Message-ID: <Pine.LNX.4.58.0501140855530.27382@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de> <m14qhkr4sd.fsf_-_@muc.de>
 <1105678742.5402.109.camel@npiggin-nld.site> <20050114104732.GB72915@muc.de>
 <41E7A58C.5010805@yahoo.com.au> <20050114111121.GA81555@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Andi Kleen wrote:

> > Are you sure the cmpxchg8b need a lock prefix? Sure it does to
>
> If you want it to be atomic on SMP then yes.
>
> > get the proper "atomic cmpxchg" semantics, but what about a
> > simple 64-bit store... If it boils down to 8 byte load, 8 byte
>
> A 64bit store with a 64bit store instruction is atomic. But
> to do that on 32bit x86 you need SSE/MMX (not an option in the kernel)
> or cmpxchg8
>
> > store on the memory bus, and that store is atomic, then maybe
> > a lock isn't needed at all?
>
> More complex operations than store or load are not atomic without
> LOCK (and not all operations can have a lock prefix). There are a few
> instructions with implicit lock. If you want the gory details read
> chapter 7 in the IA32 Software Developer's Manual Volume 3.

It needs a lock prefix. Volume 2 of the IA32 manual states on page 150
regarding cmpxchg (Note that the atomicity mentioned here seems to apply
to the complete instruction not the 64 bit fetches and stores):


This instruction can be used with a LOCK prefix to allow the instruction
to be executed atomically. To simplify the interface to the processor's
bus, the destination operand receives a write cycle without regard to the
result of the comparison. The destination operand is written back ifthe
comparison fails; otherwise, the source operand is written into the
destination. (The processor never produces a locked read without also
producing a locked write.)
