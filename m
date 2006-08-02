Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWHBAsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWHBAsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWHBAsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 20:48:10 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:31658 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750878AbWHBAsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 20:48:09 -0400
Subject: Re: [PATCH 8 of 13] Add a bootparameter to reserve high linear
	address space for hypervisors
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Ian Pratt <ian.pratt@xensource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <200608012347.20556.ak@suse.de>
References: <0adfc39039c79e4f4121.1154462446@ezr>
	 <200608012347.20556.ak@suse.de>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:48:04 +1000
Message-Id: <1154479684.2570.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 23:47 +0200, Andi Kleen wrote:
>  > +		/*
> > +		 * reservedtop=size reserves a hole at the top of the kernel
> > +		 * address space which a hypervisor can load into later.
> > +		 * Needed for dynamically loaded hypervisors, so relocating
> > +		 * the fixmap can be done before paging initialization.
> > +		 * This hole must be a multiple of 4M.
> > +		 */
> > +		else if (!memcmp(from, "reservedtop=", 12)) {
> > +			unsigned long reserved = memparse(from+12, &from);
> > +			reserved &= ~0x3fffff;
> > +			set_fixaddr_top(-reserved);
> > +		}
> 
> You need to add a dummy __setup for it, otherwise it will end up in
> init's environments or be warned about.

Ewww, it's not the only one.  This whole function should be replaced
with a whole heap of early_param()s and a call to parse_early_param().

I only implemented parse_early_param two years ago; maybe it is time for
i386 to use it...

I'll create a patch,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

