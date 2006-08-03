Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWHCEta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWHCEta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWHCEta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:49:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932265AbWHCEt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:49:29 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 06:49:11 +0200
User-Agent: KMail/1.9.3
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <200608030445.38189.ak@suse.de> <Pine.LNX.4.64.0608022125320.26980@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608022125320.26980@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030649.11452.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 06:27, Christoph Lameter wrote:
> On Thu, 3 Aug 2006, Andi Kleen wrote:
> 
> > 
> > > Thats a good goal but what about the rest of us who have to maintain 
> > > additional forms of bit operations for all architectures. How much is this 
> > > burden?
> > 
> > I don't think it's that big an issue because most architectures either
> > use always locked bitops already or don't need them because they don't do
> > SMP.
> 
> Those architectures that always use locked bitops or dont need them would 
> not need to be modified if we put this in a special fail. I think this is 
> a i386 speciality here?

i386/x86-64

They could do a single line #include for asm-generic that defines them
to the normal bitops.


> 
> Those operations are only needed for special xen driver and not for 
> regular kernel code!

The Xen driver will be "regular" kernel code.

> > So it will be fine with just a asm-generic header that defines them
> > to the normal bitops. Not much burden.
> 
> asm-generic/xen-bitops.h asm-i386/xen-bitops.h is even less of a burden 
> and would only require a 
> 
> #include <asm/xen-bitops.h>
> 
> for those special xen drivers.

Well there might be reasons someone else uses this in the future too.
It's also not exactly Linux style - normally we try to add generic
facilities.

-Andi
