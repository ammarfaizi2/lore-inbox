Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318980AbSHMRqr>; Tue, 13 Aug 2002 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318982AbSHMRqr>; Tue, 13 Aug 2002 13:46:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12187 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318980AbSHMRqq>;
	Tue, 13 Aug 2002 13:46:46 -0400
Date: Tue, 13 Aug 2002 19:50:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208130834320.5192-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208131944280.5298-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> It may be small, but it's crap, unless you can explain to me why glibc
> cannot just cannot just catch the death signal in the master thread and
> be done with it (and do all maintenance in the master).

we dont really want any signal overhead, and we also dont want any extra
context-switching to the 'master thread'. And there's no master thread
anymore either.

the pthreads API provides sensible ways to just get rid of a helper thread
without *any* handshaking or notification done after exit with any of the
other threads - the thread has finished its work and is gone forever.

the fundamental problem is getting rid of the stack atomically, it's a
catch-22. A thread can be interrupted by a signal on the last instruction
it executes, it can be ptrace debugged, etc. And something must notify
about completion once the stack is 100% unused.

(i'll add any other, userspace-only solution to the code if there's any
that has equivalent performance - i couldnt find any other solution so
far.)

	Ingo

