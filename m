Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272793AbRITCHQ>; Wed, 19 Sep 2001 22:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274010AbRITCG4>; Wed, 19 Sep 2001 22:06:56 -0400
Received: from [195.223.140.107] ([195.223.140.107]:32757 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S272793AbRITCGr>;
	Wed, 19 Sep 2001 22:06:47 -0400
Date: Thu, 20 Sep 2001 04:07:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920040702.J720@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random> <006c01c14137$95c580c0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006c01c14137$95c580c0$010411ac@local>; from manfred@colorfullife.com on Wed, Sep 19, 2001 at 08:19:09PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:19:09PM +0200, Manfred Spraul wrote:
> > if we go generic then I strongly recommend my version of the generic
> > semaphores is _much_ faster (and cleaner) than this one (it even
> allows
> > more than 2^31 concurrent readers on 64 bit archs ;).
> >
> Andrea,
> 
> implementing recursive semaphores is trivial, but do you have any idea
> how to fix the latency problem?

yes, one solution to the latency problem without writing the
ugly code would be simply to add a per-process counter to pass to a
modified rwsem api, then to hide the trickery in a mm_down_read macro.
such way it will be recursive _and_ fair.

Andrea
