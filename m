Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S133012AbRDXKST>; Tue, 24 Apr 2001 06:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S133093AbRDXKSJ>; Tue, 24 Apr 2001 06:18:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14416 "EHLO penguin.e-mind.com") by vger.kernel.org with ESMTP id <S133012AbRDXKR7>; Tue, 24 Apr 2001 06:17:59 -0400
Date: Tue, 24 Apr 2001 12:17:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424121747.A1682@athlon.random>
References: <20010424065633.A16845@athlon.random> <5927.988102571@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5927.988102571@warthog.cambridge.redhat.com>; from dhowells@warthog.cambridge.redhat.com on Tue, Apr 24, 2001 at 09:56:11AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 09:56:11AM +0100, David Howells wrote:
> | +			     : "+m" (sem->count), "+a" (sem)
				     ^^^^^^^^^^ I think you were comenting on
					        the +m not +a ok
> 
> >From what I've been told, you're lucky here... you avoid a pipeline stall

I see what you meant here and no, I'm not lucky, I thought about that. gcc
2.95.* seems smart enough to produce (%%eax) that you hardcoded when the sem is
not a constant (I'm not clobbering another register, if it does it's stupid and
I consider this a compiler mistake). I tried with a variable pointer and gcc
as I expected generated the (%%eax) but instead when it's a constant like in
the bench my way it avoids to stall the pipeline by using the constant address
for the locked incl, exactly as you said and that's probably why I beat you on
the down read fast path too.  (I also benchmarked with a variable semaphore and
it was running a little slower)

Andrea
