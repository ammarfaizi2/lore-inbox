Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWCaD2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWCaD2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCaD2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:28:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38355 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751234AbWCaD2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:28:12 -0500
Date: Thu, 30 Mar 2006 19:28:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <442C7B51.1060203@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0603301921550.3145@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
 <442C7B51.1060203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Nick Piggin wrote:

> This has acquire and release, instead of the generic kernel
> memory barriers rmb and wmb. As such, I don't think it would
> get merged.

Right. From the earlier conversation I had the impression that this is 
what you wanted.
 
> > Note that the current semantics for bitops IA64 are broken. Both
> > smp_mb__after/before_clear_bit are now set to full memory barriers
> > to compensate which may affect performance.
> 
> I think you should fight the fights you can win and get a 90%
> solution ;) at any rate you do need to fix the existing routines
> unless you plan to audit all callers...
> 
> First, fix up ia64 in 2.6-head, this means fixing test_and_set_bit
> and friends, smp_mb__*_clear_bit, and all the atomic operations that
> both modify and return a value.
> 
> Then add test_and_set_bit_lock / clear_bit_unlock, and apply them
> to a couple of critical places like page lock and buffer lock.
> 
> Is this being planned?

That sounds like a long and tedious route to draw out the pain for a 
couple of years and add loads of additional macro definitions all over the 
header files. I'd really like a solution that allows a gradual 
simplification of the macros and that has clear semantics.

So far it seems that I have not even been able to find the definitions for 
the proper behavior of memory barriers.

