Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUDEQJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUDEQJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:09:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55966
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262953AbUDEQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:09:01 -0400
Date: Mon, 5 Apr 2004 18:08:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040405160859.GE2234@dualathlon.random>
References: <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405131113.A5094@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 01:11:13PM +0100, Christoph Hellwig wrote:
> On Mon, Apr 05, 2004 at 10:59:12AM +0100, Christoph Hellwig wrote:
> > On Sat, Apr 03, 2004 at 07:02:58PM +0200, Andrea Arcangeli wrote:
> > > can you try this potential fix too? (maybe you want to try this first
> > > thing)
> > > 
> > > this is from Hugh's anobjramp patches.
> > > 
> > > I merged it once, then I got a crash report, so I backed it out since it
> > > was working anyways, but it was due a merging error that it didn't work
> > > correctly, the below version should be fine and it seems really needed.
> > > 
> > > I'll upload a new kernel with this applied.
> > 
> > Still fails with 2.6.5-aa3 which seems to have this one applied.
> 
> Disabling compound pages unconditionally gets it working again.

This is weird, it sounds like something is reusing page->private for
slab pages in ppc, how that can be possible?

Can you also double check that this is not reproducible on x86 just in
case?

can you try again with compound on and the debugging patch I posted that
replicates page->private into page->mapping to verify it's only
page->private being corrupt?

thanks for the help.
