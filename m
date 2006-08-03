Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWHCE2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWHCE2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWHCE2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:28:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65165 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932344AbWHCE2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:28:07 -0400
Date: Wed, 2 Aug 2006 21:27:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608030445.38189.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608022125320.26980@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <44D144EC.3000205@goop.org>
 <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
 <200608030445.38189.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Andi Kleen wrote:

> 
> > Thats a good goal but what about the rest of us who have to maintain 
> > additional forms of bit operations for all architectures. How much is this 
> > burden?
> 
> I don't think it's that big an issue because most architectures either
> use always locked bitops already or don't need them because they don't do
> SMP.

Those architectures that always use locked bitops or dont need them would 
not need to be modified if we put this in a special fail. I think this is 
a i386 speciality here?

Those operations are only needed for special xen driver and not for 
regular kernel code!

> So it will be fine with just a asm-generic header that defines them
> to the normal bitops. Not much burden.

asm-generic/xen-bitops.h asm-i386/xen-bitops.h is even less of a burden 
and would only require a 

#include <asm/xen-bitops.h>

for those special xen drivers.


