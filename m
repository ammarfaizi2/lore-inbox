Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUDHRKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDHRKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:10:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37293
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262080AbUDHRKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:10:18 -0400
Date: Thu, 8 Apr 2004 19:10:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408171017.GJ31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain> <1081435237.1885.144.camel@mulgrave> <20040408151415.GB31667@dualathlon.random> <1081438124.2105.207.camel@mulgrave> <20040408153412.GD31667@dualathlon.random> <1081439244.2165.236.camel@mulgrave> <20040408161610.GF31667@dualathlon.random> <1081441791.2105.295.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081441791.2105.295.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 11:29:50AM -0500, James Bottomley wrote:
> On Thu, 2004-04-08 at 11:16, Andrea Arcangeli wrote:
> > softirq tasklets would be unsafe too, oh well, if you take it really
> > from irq context (irq/softirq/tasklet) then just a spinlock isn't
> > enough, it'd need to be an irq safe lock or whatever similar plus you
> > must be sure to never generate exceptions triggering the call inside the
> > critical section. sounds like we need some per-arch abstraction to cover
		      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > this, we for sure don't want an irq spinlock for this, then we can as
> > well leave the semaphore for all archs but parisc.
> 
> Erm, well, I think this is a global problem.  All VI archs have to use
> the flush_ APIs in cachetlb.txt to ensure coherence.  It's just that
> sparc seems to have some nice cache manipulation instructions that
> relieve it of the necessity of traversing the mappings.
> 
> Why don't we want an irq safe spinlock?  As Hugh said, we'd abstract it
> so as to be a nop on PI archs.

I said above per-arch abstraction, a per-arch abstraction isn't an irq
safe spinlock, we cannot add an irq safe spinlock there, it'd be too bad
for all the common archs that don't need to walk those lists (actually
trees in my -aa tree) from irq context.

if you implement the locking abstraction with an irq safe spinlock it's
your own business then.
