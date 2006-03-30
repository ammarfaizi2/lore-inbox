Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWC3W0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWC3W0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWC3W0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:26:54 -0500
Received: from palrel12.hp.com ([156.153.255.237]:26258 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1750756AbWC3W0y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:26:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Thu, 30 Mar 2006 14:26:46 -0800
Message-ID: <65953E8166311641A685BDF71D865826A23E97@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fix unlock_buffer() to work the same way as bit_unlock()
Thread-Index: AcZULbz1S9WzriXNQjWRnolM9PfyiQAGqB0g
From: "Boehm, Hans" <hans.boehm@hp.com>
To: "Christoph Lameter" <clameter@sgi.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 30 Mar 2006 22:26:46.0843 (UTC) FILETIME=[07E4F8B0:01C65449]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christoph Lameter 
> On Thu, 30 Mar 2006, Nick Piggin wrote:
> 
> > Zoltan Menyhart wrote:
> > 
> > > However, I do not think your implementation would be 
> efficient due 
> > > to selecting the ordering mode at run time:
> > > 
> > > > +    switch (mode) {
> > > > +    case MODE_NONE :
> > > > +    case MODE_ACQUIRE :
> > > > +        return cmpxchg_acq(m, old, new);
> > > > +    case MODE_FENCE :
> > > > +        smp_mb();
> > > > +        /* Fall through */
> > > > +    case MODE_RELEASE :
> > > > +        return cmpxchg_rel(m, old, new);
> > > 
> > 
> > BTW. Isn't MODE_FENCE wrong? Seems like a read or write 
> could be moved 
> > above cmpxchg_rel?
> 
> Hmmm.... We should call this MODE_BARRIER I guess...
>  
I arrived at the conclusion that "fence" is a better term, at least in
user-level code.  "Barrier" seems to generate confusion with
"pthread_barrier_wait" and similar constructs, which are a different
kind of beast.

Hans
