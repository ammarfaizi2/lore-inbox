Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318950AbSHSReW>; Mon, 19 Aug 2002 13:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSHSReW>; Mon, 19 Aug 2002 13:34:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318950AbSHSReW>; Mon, 19 Aug 2002 13:34:22 -0400
Date: Mon, 19 Aug 2002 10:42:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <Pine.LNX.4.44.0208191254220.11609-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208191036040.11842-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. This looks good, but I wonder if the real problem isn't really that 
our ptrace approach has always been kind of flaky.

Basically, we started with the notion that only parents can trace their 
children, so no reparenting was ever needed. Then PTRACE_ATTACH came 
along, and we did the reparenting, and I think _that_ is where we made our 
big mistake. 

We sh ould just have made a separate "tsk->tracer" pointer, instead of 
continuing with the perverted "my parent is my tracer" logic. We shouldn't 
really re-write the parent/child relationship just because we're being 
traced.

I'd be happy to apply this patch (well, your fixed version), but I think 
I'd prefer even more to make the whole reparenting go away, and keep the 
child list valid all through the lifetime of a process.  How painful could 
that be? 

		Linus

