Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274041AbRISMtx>; Wed, 19 Sep 2001 08:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274042AbRISMtn>; Wed, 19 Sep 2001 08:49:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8539 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274041AbRISMtf>; Wed, 19 Sep 2001 08:49:35 -0400
Date: Wed, 19 Sep 2001 14:49:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010919144947.Q720@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <9326.1000893117@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9326.1000893117@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, Sep 19, 2001 at 10:51:57AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 10:51:57AM +0100, David Howells wrote:
> 
> Looking through the do_page_fault(), I noticed there's a race in expand stack
> because expand_stack() expects the caller to have the mm-sem write-locked.
> 
> I've attached a patch that might fix it appropriately. Alternatively, it may
> be worth applying Andrea's 00_silent-stack-overflow-10 patch which fixes this
> and something else too.

Yep, it's here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre11aa1/00_silent-stack-overflow-10

I also added the documentation on the locking on top of expand_stack.

My patch also enforced a gap of one page (sysctl configurable in
with page granularity) between a growsdown vma and its previous vma, so
that we can more easily trap stack overflows on the heap. (such part
isn't related to the race fix but it was controversial but since it's
quite useful too I didn't splitted it out :)

Andrea
