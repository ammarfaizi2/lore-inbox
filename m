Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271940AbTGRWmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271919AbTGRWjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:39:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33729
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271923AbTGRWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:38:24 -0400
Date: Sat, 19 Jul 2003 00:53:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718225328.GQ3928@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org> <20030718222750.GL3928@dualathlon.random> <20030718224824.GP15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718224824.GP15452@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 03:48:24PM -0700, William Lee Irwin III wrote:
> On Sat, Jul 19, 2003 at 12:27:50AM +0200, Andrea Arcangeli wrote:
> > bigpages= is a documented API that has to be used in production, so I
> > can easily add the hugetlbfs API but I guess I've to keep this one
> > anyways. I also would need to verify the performance of hugetlbfs before
> > suggesting migrating to it, for example I don't want
> > preallocation/prefaulting (IIRC hugetlbfs preallocates everything). I
> > also like the single huge array of page pointers, that is very hardwired
> > but optimal for those workloads.
> 
> Most of the complaints I've gotten are about lack of support for mixed
> PSE and non-PSE mappings, not preallocation or performance (generally
> its usage doesn't involve creation/destruction cycle performance
> requirements, and most of the time they intend to use 100% of the memory).
> 
> It's basically too stupid and operating on too small a data set to
> screw up performance-wise apart from creation/destruction, which is not
> intended to be performant (and will never be; it blits oversized areas).
> 
> I wouldn't mind hearing of what you believe is missing, so long as it's
> within the constraints of what's mergeable. =(

I tend to think the creation/destruction will be the most noticeable
performance difference in practice. allocating 42G in a single block
will take a bit of time ;). I'm not necessairly worse or unacceptable,
but it's different. And I feel I've to retain the bigpages= API (as an
API not as in implementation) anyways. Furthmore I'm unsure if hugtlbfs
is relaxed like the shm-largpeage patch is, I mean, it should be
possible to mmap the stuff with 4k granularty too, or stuff could break
due that change of API too.

Andrea
