Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311123AbSCHVDo>; Fri, 8 Mar 2002 16:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311124AbSCHVDe>; Fri, 8 Mar 2002 16:03:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32781 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311123AbSCHVDX>; Fri, 8 Mar 2002 16:03:23 -0500
Date: Fri, 8 Mar 2002 13:02:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020308202836.7D8163FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.33.0203081258070.1412-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Mar 2002, Hubertus Franke wrote:
> 
> But what about compatibility with i368, no cmpxchg or cmpxchg8b
> Can't we have to types and infer from the op in the kernel what 
> the correct size in user space is.

I think the next step should be to map in one page of kernel code in a 
user-readable location, and just do it there.

It's not just 386 vs later due to cmpxchg. It's also the simple issue of
UP vs SMP - a UP system still wants to do locking, but it doesn't need the
lock prefix. And that lock prefix makes a _huge_ difference
performance-wise.

So my suggestion is: ignore i386 for now (no _relevant_ SMP boxes exist
anyway), and plan on solving the problem with a separate library page 
before 2.6.x gets released.

			Linus

