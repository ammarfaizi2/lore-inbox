Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWHCFdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWHCFdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWHCFdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:33:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35993 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932271AbWHCFdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:33:11 -0400
Date: Wed, 2 Aug 2006 22:32:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608030725.13713.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608022227210.27356@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <200608030649.11452.ak@suse.de>
 <Pine.LNX.4.64.0608022213530.26980@schroedinger.engr.sgi.com>
 <200608030725.13713.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Andi Kleen wrote:

> > As far as I can tell from this conversation there are special "Xen" 
> > drivers that need this not the rest of the system.
> 
> Yes, but in general when a driver that runs on multiple architectures
> (including IA64 btw) needs something architecture specific we usually
> add it to asm, not add ifdefs.

I still wonder why you are so focused on ifdefs. Why would we need those?

> > What possible use could there be to someone else?
> 
> e.g. for other hypervisors or possibly for special hardware access
> (e.g. I could imagine it being used for some kind of cluster interconnect)
> I remember Alan was using a similar hack in his EDAC drivers because
> it was the only way to clear ECC errors. 

Maybe the best thing would be to have proper atomic ops in UP mode on 
i386? The current way of just dropping the lock bit is the source of the 
troubles.

> > The "atomic" ops lock/unlock crap exists only for i386 as far as I can 
> > tell. As you said most architectures either always use atomic ops or 
> > never. The lock/unlock atomic ops are i386 specific material that 
> > better stay contained. Its arch specific and not generic.
> 
> Well we have our share of weird hacks for IA64 too in generic code.

But we all try to contain them. Here we have i386 hacks multiplying 
all over the system.

> Just adding a single line #include for a wrapper asm-generic surely isn't
> a undue burden for the other architectures, and it will save some
> mess in the Xen drivers.

Just adding a single line #include <asm/xen-bitops.h> to drivers that need 
this functionality is not an undue burden for the drivers that support 
Xen. They have to use special _xxx bitops anyways.

