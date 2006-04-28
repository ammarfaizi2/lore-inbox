Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWD1GIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWD1GIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWD1GIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:08:47 -0400
Received: from mail.suse.de ([195.135.220.2]:55969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965198AbWD1GIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:08:46 -0400
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] x86/PAE: Fix pte_clear for the >4GB RAM case
Date: Fri, 28 Apr 2006 08:08:44 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, zach@vmware.com,
       torvalds@osdl.org
References: <200604272001.k3RK1dmX007637@hera.kernel.org> <p73mze66zx8.fsf@bragg.suse.de> <20060428052328.GA4409@sorel.sous-sol.org>
In-Reply-To: <20060428052328.GA4409@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604280808.44496.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 07:23, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > > +static inline void pmd_clear(pmd_t *pmd)
> > > +{
> > > +	u32 *tmp = (u32 *)pmd;
> > > +	*tmp = 0;
> > > +	smp_wmb();
> > > +	*(tmp + 1) = 0;
> > > +}
> > 
> > I think that's still wrong - it should be wmb() not smp_wmb because this
> > problem can happen on a UP kernel already.
> 
> I thought the barrier is to keep compiler from reordering not processor.

Yes, but with smp_wmb() it will go away on UP. And even on UP the
CPU is free to speculate.

-Andi
