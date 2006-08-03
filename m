Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWHCFyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWHCFyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWHCFyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:54:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57014 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750778AbWHCFya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:54:30 -0400
Date: Wed, 2 Aug 2006 22:54:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608030739.13334.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608022252270.27488@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <200608030725.13713.ak@suse.de>
 <Pine.LNX.4.64.0608022227210.27356@schroedinger.engr.sgi.com>
 <200608030739.13334.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Andi Kleen wrote:

> > I still wonder why you are so focused on ifdefs. Why would we need those?
> 
> Because the Xen drivers will run on a couple of architectures, including
> IA64 and PPC.
> 
> If IA64 or PPC didn't implement at least wrappers for the sync ops
> then they would all need special ifdefs to handle this.

No they would just need to do an #include <xen-bitops.h>

> > Maybe the best thing would be to have proper atomic ops in UP mode on 
> > i386? The current way of just dropping the lock bit is the source of the 
> > troubles.
> 
> It's a huge performance difference.

I understand but why dont we use regular ops explicitly 
instead of hacking the atomic ops. Then we would not have unhack them now.

> > Just adding a single line #include <asm/xen-bitops.h> to drivers that need 
> > this functionality is not an undue burden for the drivers that support 
> > Xen. They have to use special _xxx bitops anyways.
> 
> Ok it could be put into a separate file (although with a neutral name)
> 
> But you would still need to add that to IA64, PPC etc. too, so it 
> would only avoid adding a single to the other architectures.

Could we not just add one fallback definition to asm-generic?

