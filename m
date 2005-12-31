Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVLaOxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVLaOxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVLaOxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:53:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1738 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964970AbVLaOxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:53:36 -0500
Date: Sat, 31 Dec 2005 09:53:11 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>
Subject: Re: [PATCH 1/9] clockpro-nonresident.patch
In-Reply-To: <1136022886.17853.18.camel@twins>
Message-ID: <Pine.LNX.4.63.0512310951210.27198@cuia.boston.redhat.com>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> 
 <20051230224222.765.32499.sendpatchset@twins.localnet>  <20051231011324.GB4913@dmt.cnet>
 <1136022886.17853.18.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005, Peter Zijlstra wrote:

> > > +/*
> > > + * For interactive workloads, we remember about as many non-resident pages
> > > + * as we have actual memory pages.  For server workloads with large inter-
> > > + * reference distances we could benefit from remembering more. 
> > > + */
> > 
> > This comment is bogus. Interactive or server loads have nothing to do
> > with the inter reference distance. To the contrary, interactive loads
> > have a higher chance to contain large inter reference distances, and
> > many common server loads have strong locality.
> > 
> > <snip>
> 
> Happy to drop it, Rik?

Sorry, but the comment is accurate.

For interactive workloads you want to forget interreference
distances between two updatedbs, even if mozilla didn't get
used all weekend.

OTOH, on NFS servers, or other systems with large interreference
distances, you may _need_ to remember a larger set of non-resident
pages in order to find the pages that are the hottest.

In those workloads, the shortest inter-reference distance might
still be larger than the size of memory...

-- 
All Rights Reversed
