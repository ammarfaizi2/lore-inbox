Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271879AbRIDCcF>; Mon, 3 Sep 2001 22:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271881AbRIDCbz>; Mon, 3 Sep 2001 22:31:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7248 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271880AbRIDCbk>; Mon, 3 Sep 2001 22:31:40 -0400
Date: Tue, 4 Sep 2001 04:31:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Richard Henderson <rth@twiddle.net>, David Mosberger <davidm@hpl.hp.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
Message-ID: <20010904043151.H699@athlon.random>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com> <20010903131436.A16069@twiddle.net> <15251.59286.154267.431231@napali.hpl.hp.com> <20010903134125.B16069@twiddle.net> <15252.13330.652765.959658@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15252.13330.652765.959658@cargo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Sep 04, 2001 at 11:53:22AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 11:53:22AM +1000, Paul Mackerras wrote:
> For alpha, the thing that my patch does that might hurt is the change
> from flush_icache_page to flush_icache_range in kernel/ptrace.c.  Any
> comment on that?

For the alpha such change will imply a performance penablity (will throw
away the whole icache, not only the one belonging to the ptraced task).

We cannot change flush_icache_range to bump the asn because there's no
vma in the flush_icache_range API (flush_icache_range in short is for
the kernel side, like with vmalloc and kernel modules where a
vma/mm/tsk wouldn't make sense anyways).

what's the point of such change? The whole point of the patch is to work
with pages not with virtual addresses so you can do the bitflag
bookeeping on the page structure, so I don't see why would you want to
do the opposite change there.

Andrea
