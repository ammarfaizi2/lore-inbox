Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310114AbSCKONt>; Mon, 11 Mar 2002 09:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310115AbSCKONj>; Mon, 11 Mar 2002 09:13:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:18380 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310114AbSCKON1>; Mon, 11 Mar 2002 09:13:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Mon, 11 Mar 2002 09:14:17 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203081802540.5197-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203081802540.5197-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020311141315.D7BEE3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 09:12 pm, Linus Torvalds wrote:
> On Fri, 8 Mar 2002, Hubertus Franke wrote:
> > > The point being that the difference between a "decl" and a "lock ; 
> > > decl" is about 1:12 or so in performance.
> >
> > I am no expert in architecture, but if its done through the cache
> > coherency mechanism, the overhead shouldn't be 12:1. You simply mark the
> > cache line as part of you instruction to avoid a cache line transfer. How
> > can that be 12 times slower.  .. Ready to be educated....
>
> A lock in a SMP system also needs to synchronize the instruction stream,
> and not let stores move "out" from the locked region.
>
> On a UP system, this all happens automatically (well, getting it to happen
> right is obviously one of the big issues in an out-of-order CPU core, but
> it's a very fundamental part of the core, so it's "free" in the sense that
> if it isn't done, the CPU simply doesn't work).
>
> On SMP, it's a memory barrier. This is why a "lock ; decl" is more
> expensive than a "decl" - it's the implied memory ordering constraints (on
> other architectures they are explicit). On an intel CPU, this basically
> means that the pipeline is drained, so a locked instruction takes roughly
> 12 cycles on a PPro core (AMD's K7 core seems to be rather more graceful
> about this one). I haven't timed a P4 lately, I think it's worse.
>
> Other architectures do the memory ordering explicitly, and some are
> better, some are worse. But it always costs you _something_.
>
> 		Linus


Sure, not contending that. Right now I think our focus should be to get the
right functionality out and address people's concerns.
Improvements, as you suggested, are orthogonal and can always be put
in later.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
