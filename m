Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318160AbSHBE31>; Fri, 2 Aug 2002 00:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318167AbSHBE31>; Fri, 2 Aug 2002 00:29:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50948 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318160AbSHBE30>; Fri, 2 Aug 2002 00:29:26 -0400
Date: Thu, 1 Aug 2002 21:32:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: large page patch
In-Reply-To: <20020801.211357.93822733.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0208012128110.1857-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, David S. Miller wrote:
>    
>    Of course, if you can actually measure it, that would be
>    interesting.  Naive math gives you a guess for the order of
>    magnitude effect, but nothing beats real numbers ;)
> 
> The SYSV folks actually did have a buddy allocator a long time ago and
> they did implement lazy coalescing because is supposedly improved
> performance.

I bet that is mainly because of CPU scalability, and being able to avoid
touching the buddy lists from multiple CPU's - the same reason _we_ have
the per-CPU front-ends on various allocators.

I doubt it is because buddy matters past the 4MB mark. I just can't see 
how you can avoid the naive math which says that it should be 1/512th as 
common to coalesce to 4MB as it is to coalesce to 8kB. 

Walking the buddy bitmaps for a few levels (ie up to order 3 or 4) is
probably quite common, and it's likely to be bad from a SMP cache
standpoint (touching a few bits with what must be fairly random patterns). 
So avoiding the buddy with a simple front-end is likely to win you 
something, without actually being meaningful at the MAX_ORDER point.

		Linus

