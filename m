Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVANQzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVANQzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVANQzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:55:07 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:24737 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261999AbVANQzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:55:01 -0500
Date: Fri, 14 Jan 2005 08:52:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <20050114043944.GB41559@muc.de>
Message-ID: <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
References: <41E5AFE6.6000509@yahoo.com.au> <20050112153033.6e2e4c6e.akpm@osdl.org>
 <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2005, Andi Kleen wrote:

> > I think this is not necessary. Most IA32 processors do 64
> > bit operations in an atomic way in the same way as IA64. We can cut out
> > all the stuff we put in to simulate 64 bit atomicity for i386 PAE mode if
> > we just use convince the compiler to use 64 bit fetches and stores. 486
>
> That would mean either cmpxchg8 (slow) or using MMX/SSE (even slower
> because you would need to save FPU stable and disable
> exceptions).

It strange that the instruction set does not contain some simple 64bit
store or load and the FPU state seems to be complex to manage...sigh.

Looked at  arch/i386/lib/mmx.c. It avoids the mmx ops in an interrupt
context but the rest of the prep for mmx only saves the fpu state if its
in use. So that code would only be used rarely. The mmx 64 bit
instructions seem to be quite fast according to the manual. Double the
cycles than the 32 bit instructions on Pentium M (somewhat higher on Pentium 4).

One could simply do a movq.

