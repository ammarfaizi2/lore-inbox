Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272859AbRISSpn>; Wed, 19 Sep 2001 14:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274138AbRISSpe>; Wed, 19 Sep 2001 14:45:34 -0400
Received: from [195.223.140.107] ([195.223.140.107]:3824 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274136AbRISSp1>;
	Wed, 19 Sep 2001 14:45:27 -0400
Date: Wed, 19 Sep 2001 20:45:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010919204546.K720@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random> <20010919141656.A5021@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919141656.A5021@redhat.com>; from bcrl@redhat.com on Wed, Sep 19, 2001 at 02:16:56PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 02:16:56PM -0400, Benjamin LaHaise wrote:
> I don't know about you, but I'm mildly concerned that copyright attributions 
> vanished.

can you be more precise? which copyright attribution? my rwsem are
written totally from scratch, they doesn't share anything with the
previous code, it is just a code replacement. As far I can tell deleted
some file, and with it also its headers but that seems not to infinge
any copyright, I didn't removed only the copyright attribution. If I
removed only the copyright attribution please let me know of course,
that would been a silly mistake.

To be pedantic the only idea I shared with the old code (but that's just
the idea, not the implementation, so AFIK only a patent on such idea
could protect it from its free usage usage) is to return the rwsem again
from rwsem_wake and friends to avoid saving it in the asm slow path, and
I written that:

/*
 * We return the semaphore itself from the C functions so we can pass it
 * in %eax via regparm and we don't need to declare %eax clobbered by C.
 * This is mostly for x86 but maybe other archs can make a use of it
 * too.
 * Idea is from David Howells <dhowells@redhat.com>.
 */

And the xadd version is scheduled for removal anyways soon btw (David
just dropped it in its implementation).

Andrea
