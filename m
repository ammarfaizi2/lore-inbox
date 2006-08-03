Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWHCQuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWHCQuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWHCQuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:50:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8853 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932085AbWHCQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:50:18 -0400
Date: Thu, 3 Aug 2006 09:49:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608030802.44391.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608030943110.29745@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <200608030739.13334.ak@suse.de>
 <Pine.LNX.4.64.0608022252270.27488@schroedinger.engr.sgi.com>
 <200608030802.44391.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Andi Kleen wrote:

> On Thursday 03 August 2006 07:54, Christoph Lameter wrote:
> > On Thu, 3 Aug 2006, Andi Kleen wrote:
> > 
> > > > I still wonder why you are so focused on ifdefs. Why would we need those?
> > > 
> > > Because the Xen drivers will run on a couple of architectures, including
> > > IA64 and PPC.
> > > 
> > > If IA64 or PPC didn't implement at least wrappers for the sync ops
> > > then they would all need special ifdefs to handle this.
> > 
> > No they would just need to do an #include <xen-bitops.h>
> 
> If IA64 and PPC64 wouldn't have xen-bitops.h (which you seem to argue 
> for) then they would need ifdefs.

An include <asm/xen-bitops.h> would need to fall back to asm-generic if
there is no file in asm-arch/xen-bitops.h. I thought we had such a 
mechanism?

> You mean into asm-generic/bitops.h? Then it would need ifdefs
> to handle the i386/x86-64 case.

No. Into asm-generic/xen-bitops.h.
