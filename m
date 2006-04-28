Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWD1G11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWD1G11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWD1G11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:27:27 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27010 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1030271AbWD1G11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:27:27 -0400
Date: Thu, 27 Apr 2006 23:27:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zach@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] x86/PAE: Fix pte_clear for the >4GB RAM case
Message-ID: <20060428062704.GH2909@sorel.sous-sol.org>
References: <200604272001.k3RK1dmX007637@hera.kernel.org> <p73mze66zx8.fsf@bragg.suse.de> <20060428052328.GA4409@sorel.sous-sol.org> <200604280808.44496.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604280808.44496.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Friday 28 April 2006 07:23, Chris Wright wrote:
> > * Andi Kleen (ak@suse.de) wrote:
> > > > +static inline void pmd_clear(pmd_t *pmd)
> > > > +{
> > > > +	u32 *tmp = (u32 *)pmd;
> > > > +	*tmp = 0;
> > > > +	smp_wmb();
> > > > +	*(tmp + 1) = 0;
> > > > +}
> > > 
> > > I think that's still wrong - it should be wmb() not smp_wmb because this
> > > problem can happen on a UP kernel already.
> > 
> > I thought the barrier is to keep compiler from reordering not processor.
> 
> Yes, but with smp_wmb() it will go away on UP. And even on UP the
> CPU is free to speculate.

I must be confused.  Doesn't that become a barrier() on UP?
