Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSDWSYX>; Tue, 23 Apr 2002 14:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315301AbSDWSYW>; Tue, 23 Apr 2002 14:24:22 -0400
Received: from zero.tech9.net ([209.61.188.187]:62482 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315300AbSDWSYV>;
	Tue, 23 Apr 2002 14:24:21 -0400
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204231813080.20614-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 14:24:23 -0400
Message-Id: <1019586264.2045.139.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 12:14, Ingo Molnar wrote:

> hm, perhaps it was only my own internal version then.
> 
> in any case, you can use the find_first_zero_bit() library function i
> added for exactly this purpose. Any problems with that? It wont be the
> fastest option, but it will do.

Err find_first_bit ?

I guess that will work but your hand-coded version is so much faster :)

I would need to abstract sched_find_first_bit into a generic function
that also accepted a size argument.  Something like:

Rename sched_find_first_bit to _sched_find_first_bit, and

#if MAX_RT_PRIO < 120 && MAX_RT_PRIO > 99
#define sched_find_first_bit(b, size)	_sched_find_first_bit(b)
#else
#define sched_find_first_bit(b, size)	find_first_bit(b, size)
#endif

We can let MAX_RT_PRIO go up 120 since the bitmap is actually 160, not
140, size 5*32=160.

Look good?

	Robert Love

