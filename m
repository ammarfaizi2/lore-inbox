Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUILFrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUILFrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268483AbUILFrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:47:05 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:62681 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268482AbUILFq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:46:59 -0400
Date: Sun, 12 Sep 2004 01:51:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org, jun.nakajima@intel.com,
       ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
In-Reply-To: <4143D491.6070006@yahoo.com.au>
Message-ID: <Pine.LNX.4.53.0409120146020.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
 <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
 <4143D16F.30500@yahoo.com.au> <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com>
 <4143D491.6070006@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Nick Piggin wrote:

> Zwane Mwaikambo wrote:
> > On Sun, 12 Sep 2004, Nick Piggin wrote:
> 
> >>I presume the hypervisor switch much incur the same sorts of costs as
> >>a context switch?
> > 
> > In the PPC64 and P4/HT case the spinning on a lock is a bad utilisation of 
> > the execution resources and that's what we're really trying to avoid, not 
> > necessarily cache thrashing from a context switch.
> 
> But isn't yielding to the hypervisor and thus causing it to schedule
> something else basically the same as a context switch? (I don't know
> anything about POWER).

Yielding processor to the hypervisor allows it to schedule the physical 
processor for execution time on a different logical partition. The 
scheduling in this case is at the hardware/firmware level.

> If yes, then shouldn't your lock be a blocking lock anyway?

We just happen to allow preemption since we know we're at an upper level 
lock, so we may as well not disable preemption during contention. It 
wouldn't be as straightforward to switch to a blocking lock.

	Zwane
