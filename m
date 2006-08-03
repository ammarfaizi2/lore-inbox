Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWHCFjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWHCFjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWHCFjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:39:19 -0400
Received: from ns1.suse.de ([195.135.220.2]:1773 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932270AbWHCFjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:39:18 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 07:39:13 +0200
User-Agent: KMail/1.9.3
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <200608030725.13713.ak@suse.de> <Pine.LNX.4.64.0608022227210.27356@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608022227210.27356@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030739.13334.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 07:32, Christoph Lameter wrote:
> On Thu, 3 Aug 2006, Andi Kleen wrote:
> 
> > > As far as I can tell from this conversation there are special "Xen" 
> > > drivers that need this not the rest of the system.
> > 
> > Yes, but in general when a driver that runs on multiple architectures
> > (including IA64 btw) needs something architecture specific we usually
> > add it to asm, not add ifdefs.
> 
> I still wonder why you are so focused on ifdefs. Why would we need those?

Because the Xen drivers will run on a couple of architectures, including
IA64 and PPC.

If IA64 or PPC didn't implement at least wrappers for the sync ops
then they would all need special ifdefs to handle this.

> 
> > > What possible use could there be to someone else?
> > 
> > e.g. for other hypervisors or possibly for special hardware access
> > (e.g. I could imagine it being used for some kind of cluster interconnect)
> > I remember Alan was using a similar hack in his EDAC drivers because
> > it was the only way to clear ECC errors. 
> 
> Maybe the best thing would be to have proper atomic ops in UP mode on 
> i386? The current way of just dropping the lock bit is the source of the 
> troubles.

It's a huge performance difference.
 
> > Just adding a single line #include for a wrapper asm-generic surely isn't
> > a undue burden for the other architectures, and it will save some
> > mess in the Xen drivers.
> 
> Just adding a single line #include <asm/xen-bitops.h> to drivers that need 
> this functionality is not an undue burden for the drivers that support 
> Xen. They have to use special _xxx bitops anyways.

Ok it could be put into a separate file (although with a neutral name)

But you would still need to add that to IA64, PPC etc. too, so it 
would only avoid adding a single to the other architectures.
-Andi

 
