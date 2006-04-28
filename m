Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWD1G3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWD1G3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWD1G3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:29:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:55197 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030269AbWD1G3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:29:37 -0400
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] x86/PAE: Fix pte_clear for the >4GB RAM case
Date: Fri, 28 Apr 2006 08:29:28 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, zach@vmware.com,
       torvalds@osdl.org
References: <200604272001.k3RK1dmX007637@hera.kernel.org> <200604280808.44496.ak@suse.de> <20060428062704.GH2909@sorel.sous-sol.org>
In-Reply-To: <20060428062704.GH2909@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604280829.29164.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 08:27, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > On Friday 28 April 2006 07:23, Chris Wright wrote:
> > > * Andi Kleen (ak@suse.de) wrote:
> > > > > +static inline void pmd_clear(pmd_t *pmd)
> > > > > +{
> > > > > +	u32 *tmp = (u32 *)pmd;
> > > > > +	*tmp = 0;
> > > > > +	smp_wmb();
> > > > > +	*(tmp + 1) = 0;
> > > > > +}
> > > > 
> > > > I think that's still wrong - it should be wmb() not smp_wmb because this
> > > > problem can happen on a UP kernel already.
> > > 
> > > I thought the barrier is to keep compiler from reordering not processor.
> > 
> > Yes, but with smp_wmb() it will go away on UP. And even on UP the
> > CPU is free to speculate.
> 
> I must be confused.  Doesn't that become a barrier() on UP?

No it was me who was confused sorry. Somehow i thought it was defined
away for !SMP

(which would make sense because why would you want a compile barrier
for a barrier that is only needed on SMP?) 

-Andi
