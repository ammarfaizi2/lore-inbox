Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRJ2Rnw>; Mon, 29 Oct 2001 12:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbRJ2Rnm>; Mon, 29 Oct 2001 12:43:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62738 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276628AbRJ2Rne>; Mon, 29 Oct 2001 12:43:34 -0500
Date: Mon, 29 Oct 2001 09:32:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Juergen Doelle <jdoelle@de.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Pls apply this spinlock patch to the kernel
In-Reply-To: <E15yG7P-0003Kb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110290930540.8904-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Alan Cox wrote:
>
> So why not just add a macro for aligning then do
>
> spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
> cache_line_pad;
>
> where cache_line_pad is an asm(".align") - I would assume that is
> sufficient - Linus ?

Gcc won't guarantee that it puts different variables adjacently - the
linker (or even the compiler) can move things around to make them fit
better. Which is why it would be better to use the separate section trick.

(The union trick Juergen uses obviously also works around this, but
requires that the _users_ be aware of what kind of lock it is, which I
don't particularly like - then you can't just change the lock, you have to
change the users too).

		Linus

