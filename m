Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVCIXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVCIXQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVCIXQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:16:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34949 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262536AbVCIXGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:06:40 -0500
Date: Wed, 9 Mar 2005 15:06:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [1/4]: pte_cmpxchg and
 CONFIG_ATOMIC_TABLE_OPS
In-Reply-To: <m1y8cwv2yl.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0503091503140.30604@schroedinger.engr.sgi.com>
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
 <20050309201329.29721.1860.sendpatchset@schroedinger.engr.sgi.com>
 <m1y8cwv2yl.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
> >
> > Atomic operations may be enabled in the kernel configuration on
> > i386, ia64 and x86_64 if a suitable CPU is configured in SMP mode.
> > Generic atomic definitions for ptep_xchg and ptep_cmpxchg
> > have been provided based on the existing xchg() and cmpxchg() functions
> > that already work atomically on many platforms. It is very
>
> I'm curious - do you have any micro benchmarks on i386 or x86-64 systems
> about the difference between spin_lock(ptl) access; spin_unlock(ptl);
> and cmpxchg ?

There is a benchmark for UP on
http://oss.sgi.com/projects/page_fault_performance.

> cmpxchg can be quite slow, with bad luck it could be slower than
> the spinlocks.

Spinlocks also require atomic operations like a lock decb on i386 in order
to acquire the locks. And the page_table_lock is acquired two
times in the page fault handler. In order for this to be faster

2*spinlock acquisition and release would have to be faster than a cmpxchg.

> A P4 would be good to benchmark this because it seems to be the worst
> case.

The numbers on the webpage are for an AMD64. But I can try
to get some testing done on a P4 too.
