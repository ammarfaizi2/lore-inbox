Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTBUGzH>; Fri, 21 Feb 2003 01:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTBUGzH>; Fri, 21 Feb 2003 01:55:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2538 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267187AbTBUGzG>;
	Fri, 21 Feb 2003 01:55:06 -0500
Date: Fri, 21 Feb 2003 08:05:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <zwane@holomorphy.com>, <cw@f00f.org>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <20030220224205.GD29983@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0302210803520.2115-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, William Lee Irwin III wrote:

> >> 1: We're calling mmdrop() under spin_lock_irq(&rq->lock).  But mmdrop
> >>    calls vfree(), which calls smp_call_function().  
> 
> On Thu, Feb 20, 2003 at 11:04:41PM +0100, Ingo Molnar wrote:
> > this has been fixed in the -F3 scheduler patch.
> 
> Not quite. It leaks mm's because schedule_tail() isn't cleaning
> up rq->prev_mm.

hm, this i think was a forward-porting oversight. Anyway, now the separate
patch is in, and it's better that way, the fix was unrelated to the main
things -F3 does.

	Ingo

