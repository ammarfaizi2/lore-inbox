Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293601AbSCKWrz>; Mon, 11 Mar 2002 17:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSCKWrp>; Mon, 11 Mar 2002 17:47:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293574AbSCKWq4>; Mon, 11 Mar 2002 17:46:56 -0500
Date: Mon, 11 Mar 2002 14:45:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <frankeh@watson.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16jYnr-0003T7-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0203111441120.17864-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Mar 2002, Rusty Russell wrote:
> > 
> > So I would suggest making the size (and thus alignment check) of locks at
> > least 8 bytes (and preferably 16). That makes it slightly harder to put
> > locks on the stack, but gcc does support stack alignment, even if the code
> > sucks right now.
> 
> Actually, I disagree.
> 
> 1) We've left wiggle room in the second arg to sys_futex() to add rwsems
>    later if required.
> 2) Someone needs to implement them and prove they are superior to the
>    pure userspace solution.

You've convinced me.

Considering how long people argued about dubious cycle measurements on the 
rwsem implementation, and where the crrent one actually uses a spinlock 
for exclusion on the fast path, the kernel lock really probably doesn't 
need to be expanded, and as there is provable overhead to the expansion, 
I'll just agree with you.

Applied.

		Linus

