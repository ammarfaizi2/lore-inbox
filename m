Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268476AbUILFch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbUILFch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268479AbUILFcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:32:36 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61656 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268476AbUILF3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:29:16 -0400
Date: Sun, 12 Sep 2004 01:33:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org, jun.nakajima@intel.com,
       ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
In-Reply-To: <4143D16F.30500@yahoo.com.au>
Message-ID: <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
 <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
 <4143D16F.30500@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Nick Piggin wrote:

> > Well currently it just enables preempt and spins like a mad man until the 
> > lock is free. The idea is to allow preempt to get some scheduling done 
> > during the spin.. But! if you accept this patch today, you get the 
> > i386 version which will allow your processor to halt until a write to the 
> > lock occurs whilst allowing interrupts to also trigger the preempt 
> > scheduling, much easier on the caches.
> > 
> 
> That's the idea though isn't it? If your locks are significantly more
> expensive than a context switch and associated cache trashing, use a
> semaphore, hypervisor or no.
> 
> I presume the hypervisor switch much incur the same sorts of costs as
> a context switch?

In the PPC64 and P4/HT case the spinning on a lock is a bad utilisation of 
the execution resources and that's what we're really trying to avoid, not 
necessarily cache thrashing from a context switch.

	Zwane

