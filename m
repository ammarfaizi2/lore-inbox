Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbULNX2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbULNX2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbULNX0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:26:14 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:8546 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261745AbULNXYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:24:47 -0500
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Brent Casavant <bcasavan@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20041214191348.GA27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com>
	 <9250000.1103050790@flay>  <20041214191348.GA27225@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 10:24:39 +1100
Message-Id: <1103066679.5420.33.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 20:13 +0100, Andi Kleen wrote:
> On Tue, Dec 14, 2004 at 10:59:50AM -0800, Martin J. Bligh wrote:
> > > NUMA systems running current Linux kernels suffer from substantial
> > > inequities in the amount of memory allocated from each NUMA node
> > > during boot.  In particular, several large hashes are allocated
> > > using alloc_bootmem, and as such are allocated contiguously from
> > > a single node each.
> > 
> > Yup, makes a lot of sense to me to stripe these, for the caches that
> 
> I originally was a bit worried about the TLB usage, but it doesn't
> seem to be a too big issue (hopefully the benchmarks weren't too
> micro though)
> 

I wonder if you could have an indirection table for the hash, which
may allow you to allocate the hash memory from discontinuous, per
node chunks? Wouldn't the extra pointer chase be a similar cost to
incurring TLB misses when using the vmalloc scheme?

That _may_ help with relocating hashes for hotplug as well (although
I expect the hard part may be synchronising access).

Probably too ugly. Just an idea though.


