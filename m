Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVALQkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVALQkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVALQkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:40:17 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62081 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261241AbVALQkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:40:07 -0500
Date: Wed, 12 Jan 2005 08:39:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, ak@muc.de,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <20050112014235.7095dcf4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de>
 <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
 <41E4BCBE.2010001@yahoo.com.au> <20050112014235.7095dcf4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Andrew Morton wrote:

> My general take is that these patches address a single workload on
> exceedingly rare and expensive machines.  If they adversely affect common
> and cheap machines via code complexity, memory footprint or via runtime
> impact then it would be pretty hard to justify their inclusion.

The future is in higher and higher SMP counts since the chase for the
higher clock frequency has ended. We will increasingly see multi-core
cpus etc. Machines with higher CPU counts are becoming common in business.
Of course SGI uses much higher CPU counts and our supercomputer
applications would benefit most from this patch.

I thought this patch was already approved by Linus?

> Do we have measurements of the negative and/or positive impact on smaller
> machines?

Here is a measurement of 256M allocation on a 2 way SMP machine 2x
PIII-500Mhz:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0  10    1    0.005s      0.016s   0.002s 54357.280  52261.895
  0  10    2    0.008s      0.019s   0.002s 43112.368  42463.566

With patch:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0  10    1    0.005s      0.016s   0.002s 54357.280  53439.357
  0  10    2    0.008s      0.018s   0.002s 44650.831  44202.412

So only a very minor improvements for old machines (this one from ~ 98).
