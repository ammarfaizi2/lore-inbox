Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSCVBWm>; Thu, 21 Mar 2002 20:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312609AbSCVBWc>; Thu, 21 Mar 2002 20:22:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2354 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312604AbSCVBWQ>; Thu, 21 Mar 2002 20:22:16 -0500
Date: Fri, 22 Mar 2002 02:20:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Christoph Hellwig <hch@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020322022056.C16801@dualathlon.random>
In-Reply-To: <127930000.1016651345@flay> <20020320212341.M4268@dualathlon.random> <20020320203520.A2003@infradead.org> <20020320223425.P4268@dualathlon.random> <20020320214607.A6363@infradead.org> <20020320230002.A16801@dualathlon.random> <20020321234943.GC785@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 03:49:43PM -0800, William Lee Irwin III wrote:
> On Wed, Mar 20, 2002 at 11:00:02PM +0100, Andrea Arcangeli wrote:
> > Thet's another bit yes, but we'll need 200000 tasks to overflow the
> > lowmem (ignoring the fact the lowmem is shared also for the other lowmem
> > data structures) and there's the PID limit of 64k tasks. So I don't see
> > it as a major thing. Anyways if we really wanted to put the stack [and
> > task structure of course] in highmem, we could do that in two additional
> > entries after the user stack together with the two entries for the
> > pagecache and pagetable persistent kmaps. I think we can officially call
> > that area the "userfixmap" or "per-process-fixmap" (no matter if it's in
> > user or kernel space).  But it is much faster to keep the kernel stack
> > always in 4M global tlbs, thus I don't think we need to change that in
> > 2.5.  (also USB was used to do dma in the kernel stack, not sure if they
> > changed it recently)
> 
> Another (perhaps obvious) pitfall is stack-allocated storage used for
> components of globally-mapped structures. The premier example of this
> is probably waitqueues. To keep them working, dynamic allocation of
> globally-mapped storage or per-task static allocation thereof is
> required as a substitute.

Agreed, good point (in theory task struct could go there, I'm not
suggesting that of course, but stack has to remain visible to all MM for
such reason).

Andrea
