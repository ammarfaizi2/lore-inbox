Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274209AbRISWHT>; Wed, 19 Sep 2001 18:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274207AbRISWHN>; Wed, 19 Sep 2001 18:07:13 -0400
Received: from [195.223.140.107] ([195.223.140.107]:17149 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274206AbRISWHA>;
	Wed, 19 Sep 2001 18:07:00 -0400
Date: Thu, 20 Sep 2001 00:07:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920000715.V720@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random> <20010919141656.A5021@redhat.com> <20010919204546.K720@athlon.random> <20010919171404.A5932@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919171404.A5932@redhat.com>; from bcrl@redhat.com on Wed, Sep 19, 2001 at 05:14:04PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 05:14:04PM -0400, Benjamin LaHaise wrote:
> On Wed, Sep 19, 2001 at 08:45:46PM +0200, Andrea Arcangeli wrote:
> > To be pedantic the only idea I shared with the old code (but that's just
> > the idea, not the implementation, so AFIK only a patent on such idea
> > could protect it from its free usage usage) is to return the rwsem again
> > from rwsem_wake and friends to avoid saving it in the asm slow path, and
> > I written that:
> 
> Your patch moved a bunch of code into asm-i386/rwsem_xchgadd.h.  That 
> code was derived from the spinlock code by me into the first rwsems, 
> then David reworked bits of it, as wel as you.  But there is no 
> copyright on that file indicating this heritage.  If you look at 
> how strict commercial copyright control can be, even copying a 
> single line of code mentally by retyping it can still mandate the 
> copyright legacy.  I'm sure it's just an oversight, but it's 
> probably one we *all* need to be reminded of every now and again.

I recall I wrote such code without copying anything, I certainly copied
the way of doing things (pushl dx,cx and save ax via returning it in the
slow path) as I wrote in the comment, but not the code itself. Infact at
first i was probably also pushing eax, and even now that I use the same
logic the two versions should be slightly different. and I think mine
has a race this is why I'm not using such code and with the unfair thing
such code is scheduled for removal since it's unfixable.  really it
sounds like too me too I cut and pasted the static inline void
__down_read(struct rw_semaphore *sem) declarations, since I tend to left
a space between "*" and the variable name but not always.

Andrea
