Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUILFIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUILFIo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUILFIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:08:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24023 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268447AbUILFIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:08:34 -0400
Date: Sun, 12 Sep 2004 01:13:07 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       anton@samba.org, jun.nakajima@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
In-Reply-To: <20040911220003.0e9061ad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
 <20040911220003.0e9061ad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
> >
> > The following patch introduces cpu_lock_yield which allows architectures 
> >  to possibly yield processor resources during lock contention.
> 
> err.. Haven't you just invented a really sucky semaphore?

Wait up.. didn't _you_ create that __preempt_spin_lock thing!? ;)

> > The original 
> >  requirement stems from Paul's requirement on PPC64 LPAR systems to yield 
> >  the processor to the hypervisor instead of spinning.
> 
> Maybe Paul needs to use a semaphore.
> 
> 
> Now, maybe Paul has tied himself into sufficiently tangly locking knots
> that in some circumstances he needs to spin on the lock and cannot schedule
> away.  But he can still use a semaphore and spin on down_trylock.
> 
> Confused by all of this.

Well currently it just enables preempt and spins like a mad man until the 
lock is free. The idea is to allow preempt to get some scheduling done 
during the spin.. But! if you accept this patch today, you get the 
i386 version which will allow your processor to halt until a write to the 
lock occurs whilst allowing interrupts to also trigger the preempt 
scheduling, much easier on the caches.

	Zwane
