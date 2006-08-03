Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWHCFZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWHCFZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWHCFZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:25:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6870 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932262AbWHCFZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:25:23 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 07:25:13 +0200
User-Agent: KMail/1.9.3
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <200608030649.11452.ak@suse.de> <Pine.LNX.4.64.0608022213530.26980@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608022213530.26980@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030725.13713.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As far as I can tell from this conversation there are special "Xen" 
> drivers that need this not the rest of the system.

Yes, but in general when a driver that runs on multiple architectures
(including IA64 btw) needs something architecture specific we usually
add it to asm, not add ifdefs.
 
> > > for those special xen drivers.
> > 
> > Well there might be reasons someone else uses this in the future too.
> > It's also not exactly Linux style - normally we try to add generic
> > facilities.
> 
> What possible use could there be to someone else?

e.g. for other hypervisors or possibly for special hardware access
(e.g. I could imagine it being used for some kind of cluster interconnect)
I remember Alan was using a similar hack in his EDAC drivers because
it was the only way to clear ECC errors. 

> The "atomic" ops lock/unlock crap exists only for i386 as far as I can 
> tell. As you said most architectures either always use atomic ops or 
> never. The lock/unlock atomic ops are i386 specific material that 
> better stay contained. Its arch specific and not generic.

Well we have our share of weird hacks for IA64 too in generic code.

Just adding a single line #include for a wrapper asm-generic surely isn't
a undue burden for the other architectures, and it will save some
mess in the Xen drivers.

-Andi
