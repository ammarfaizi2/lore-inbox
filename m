Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281028AbRKCT4c>; Sat, 3 Nov 2001 14:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281029AbRKCT4V>; Sat, 3 Nov 2001 14:56:21 -0500
Received: from are.twiddle.net ([64.81.246.98]:4794 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S281028AbRKCT4H>;
	Sat, 3 Nov 2001 14:56:07 -0500
Date: Sat, 3 Nov 2001 11:55:56 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Juergen Doelle <jdoelle@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Pls apply this spinlock patch to the kernel
Message-ID: <20011103115556.A5984@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Juergen Doelle <jdoelle@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E15yG7P-0003Kb-00@the-village.bc.nu> <Pine.LNX.4.33.0110290930540.8904-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110290930540.8904-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 29, 2001 at 09:32:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 09:32:52AM -0800, Linus Torvalds wrote:
> On Mon, 29 Oct 2001, Alan Cox wrote:
> > spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
> > cache_line_pad;
> >
> > where cache_line_pad is an asm(".align") - I would assume that is
> > sufficient - Linus ?

The "cache_line_pad" is useless.  The __attribute__((aligned(N)))
is completely sufficient.

> Gcc won't guarantee that it puts different variables adjacently - the
> linker (or even the compiler) can move things around to make them fit
> better. Which is why it would be better to use the separate section trick.

Separate sections are also not needed.  While you can't guarantee
adjacency, the object file *does* record the required alignment 
and that must be honored by the linker.

Now, separate sections do make sense for minimizing accumulated 
padding, but that is a separate issue.


r~
