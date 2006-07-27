Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWG0IM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWG0IM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWG0IM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:12:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750868AbWG0IM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:12:27 -0400
Date: Thu, 27 Jul 2006 01:12:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: a.p.zijlstra@chello.nl, linux-mm@kvack.org, torvalds@osdl.org,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use-once cleanup
Message-Id: <20060727011204.87033366.akpm@osdl.org>
In-Reply-To: <44C86FB9.6090709@redhat.com>
References: <1153168829.31891.89.camel@lappy>
	<44C86FB9.6090709@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 03:48:09 -0400
Rik van Riel <riel@redhat.com> wrote:

> Peter Zijlstra wrote:
> > Hi,
> > 
> > This is yet another implementation of the PG_useonce cleanup spoken of
> > during the VM summit.
> 
> After getting bitten by rsync yet again, I guess it's time to insist
> that this patch gets merged...
> 
> Andrew, could you merge this?  Pretty please? ;)
> 

Guys, this is a performance patch, right?

One which has no published performance testing results, right?

It would be somewhat odd to merge it under these circumstances.

And this applies to all of these
hey-this-is-cool-but-i-didnt-bother-testing-it MM patches which people are
throwing around.  This stuff is *hard*.  It has a bad tendency to cause
nasty problems which only become known months after the code is merged.

I shouldn't have to describe all this, but

- Identify the workloads which it's supposed to improve, set up tests,
  run tests, publish results.

- Identify the workloads which it's expected to damage, set up tests, run
  tests, publish results.

- Identify workloads which aren't expected to be impacted, make a good
  effort at demonstrating that they are not impacted.

- Perform stability/stress testing, publish results.

Writing the code is about 5% of the effort for this sort of thing.

Yes, we can toss it in the tree and see what happens.  But it tends to be
the case that unless someone does targetted testing such as the above,
regressions simply aren't noticed for long periods of time.  <wonders which
schmuck gets to do the legwork when people report problems>

Just the (unchangelogged) changes to the when-to-call-mark_page_accessed()
logic are a big deal.  Probably these should be a separate patch -
separately changelogged, separately tested, separately justified.

Performance testing is *everything* for this sort of patch and afaict none
has been done, so it's as if it hadn't been written, no?
