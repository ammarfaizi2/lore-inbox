Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271927AbTGRW5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271930AbTGRW5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:57:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30914
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271927AbTGRW50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:57:26 -0400
Date: Sat, 19 Jul 2003 01:12:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718231230.GA19045@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org> <20030718222750.GL3928@dualathlon.random> <20030718224824.GP15452@holomorphy.com> <20030718225328.GQ3928@dualathlon.random> <20030718230431.GQ15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718230431.GQ15452@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 04:04:31PM -0700, William Lee Irwin III wrote:
> On Sat, Jul 19, 2003 at 12:53:28AM +0200, Andrea Arcangeli wrote:
> > I tend to think the creation/destruction will be the most noticeable
> > performance difference in practice. allocating 42G in a single block
> > will take a bit of time ;). I'm not necessairly worse or unacceptable,
> > but it's different. And I feel I've to retain the bigpages= API (as an
> > API not as in implementation) anyways. Furthmore I'm unsure if hugtlbfs
> > is relaxed like the shm-largpeage patch is, I mean, it should be
> > possible to mmap the stuff with 4k granularty too, or stuff could break
> > due that change of API too.
> 
> I've just not gotten feedback about creation and destruction; I get the
> impression it's an uncommon operation.

It's uncommon of course. A 42G allocated all at once, may take a while
and 48G works flawlessy at peak performance w/o 4:4.  I support as much
as 64G all in a single shmfs file backed by bigpages (and it won't run
out of memory with a 64G box either, even with the 3:1 mapping)

> The alignment etc. considerations are bits I probably can't get merged. =(

so the apps will need changes and a kernel API way to know the hardware
page size provided by hugetlbfs (though they could probe for it with
many tries).

> Most of the work I did was trying to get the preexisting semantics into
> more standard-looking API's, e.g. vfs ops and standard-ish sysv shm.

yes.

Andrea
