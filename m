Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSCIBUz>; Fri, 8 Mar 2002 20:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSCIBUp>; Fri, 8 Mar 2002 20:20:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292289AbSCIBUf>; Fri, 8 Mar 2002 20:20:35 -0500
Date: Fri, 8 Mar 2002 17:20:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: <frankeh@watson.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <3C894D87.FF70DD12@mvista.com>
Message-ID: <Pine.LNX.4.33.0203081713300.5071-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Mar 2002, george anzinger wrote:
> 
> Uh, just the pid would do.  Maybe reserve a bit to indicate
> contention, but surly one word would be enough.

Not really.

The pid would mean that anybody who gets a lock would have to have its pid
available (remember the fast-path is what we really care about), but
there's also a fundamental race between getting the lock and writing the
pid to the second word of the lock that you just won't avoid.

And that's assuming you only use the semaphores for pure mutual exclusion. 
That is the normal behaviour, but some people use semaphores for other 
things (ie "N people can be active inside this region" where N != 1).

And then you have to realize that doing the same for readers in a rwlock 
is even worse.

In short, it just cannot be done quickly and simply, and for many cases it 
cannot be done at all.

		Linus

