Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVBBDQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVBBDQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVBBDPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:15:30 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:50053 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262250AbVBBDJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:09:44 -0500
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock
	in handle_mm_fault
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <Pine.LNX.4.58.0502011843570.6511@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au>
	 <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
	 <41E5BC60.3090309@yahoo.com.au>
	 <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
	 <20050113031807.GA97340@muc.de>
	 <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
	 <20050113180205.GA17600@muc.de>
	 <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
	 <20050114043944.GB41559@muc.de>
	 <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
	 <20050114170140.GB4634@muc.de>
	 <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
	 <41FF00CE.8060904@yahoo.com.au>
	 <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
	 <1107304296.5131.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.58.0502011718240.5549@schroedinger.engr.sgi.com>
	 <1107308498.5131.28.camel@npiggin-nld.site>
	 <Pine.LNX.4.58.0502011843570.6511@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 14:09:37 +1100
Message-Id: <1107313778.5131.32.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 18:49 -0800, Christoph Lameter wrote:
> On Wed, 2 Feb 2005, Nick Piggin wrote:
> 
> > Well yeah, but the interesting case is when that isn't a lock ;)
> >
> > I'm not saying what you've got is no good. I'm sure it would be fine
> > for testing. And if it happens that we can do the "page_count doesn't
> > mean anything after it has reached zero and been freed. Nor will it
> > necessarily be zero when a new page is allocated" thing without many
> > problems, then this may be a fine way to do it.
> >
> > I was just pointing out this could be a problem without putting a
> > lot of thought into it...
> 
> Surely we need to do this the right way. Do we really need to
> use page_cache_get()? Is anything relying on page_count == 2 of
> the old_page?
> 
> I mean we could just speculatively copy, risk copying crap and
> discard that later when we find that the pte has changed. This would
> simplify the function:
> 

I think this may be the better approach. Anyone else?


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
