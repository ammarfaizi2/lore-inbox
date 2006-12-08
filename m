Return-Path: <linux-kernel-owner+w=401wt.eu-S1426163AbWLHThl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426163AbWLHThl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426167AbWLHThk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:37:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54053 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426163AbWLHThj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:37:39 -0500
Date: Fri, 8 Dec 2006 11:35:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208190403.GH31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612081130110.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com>
 <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org> <20061208190403.GH31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, Russell King wrote:
>
> Yes you can.  Well, you can on ARM at least.  Between the load exclusive
> you can do anything you like until you hit the store exclusive.  If you
> haven't touched the location (with anything other than another load
> exclusive) and no other CPU has issued a load exclusive, your store
> exclusive succeeds.

Is that actually true?

Almost all LL/SC implementations have granularity rules, where "touch the 
location" is not a byte-granular thing, but actually ends up being 
something like "touch the same cachline".

They also often have _other_ rules like: "the cacheline has to stay in the 
L1 in exclusive state" etc. Which means that in a direct-mapped L1 cache, 
you can't even load anything that might be in the same way, because it 
would cause a cache eviction that invalidates the SC.

It's possible that ARM has really strong LL/SC, but quite frankly, that 
sounds unlikely. I've never heard of anybody ever _architecturally_ saying 
that they support that strong requirements, even if certain micro- 
architectures might actually support stronger semantics than the ones 
guaranteed by the architectural rules.

			Linus
