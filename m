Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319095AbSHMSSe>; Tue, 13 Aug 2002 14:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319097AbSHMSSd>; Tue, 13 Aug 2002 14:18:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16030 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319095AbSHMSSL>;
	Tue, 13 Aug 2002 14:18:11 -0400
Date: Tue, 13 Aug 2002 20:22:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131112270.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132015530.6362-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> If the parent wants to get notified on child death, it should damn well
> get notified on child death. Not "in case the child exists politely".

yes i agree. If the parent wants that, then it does not specify the
CLONE_DETACHED flag when creating the child thread. It is the parent that
specifies this flag and it has the freedom to decide whether it wants
signal based notification or not.

if CLONE_DETACHED is not specified upon creation then *no matter what the
child thread does* - both sys_exit() and sys_exit_free() notify the
parent. It's not a matter of politeness.

> We don't depend on processes calling "exit()" to clean up all the stuff
> they left behind. The VM gets cleaned up even for bad processes.

We'd be more than happy to do this cleanup in userspace, but how do you
free a stack which might as well be used by a debugger or a signal handler
right before executing the final "int $0x80" instruction?

should every signal handler start with code that tries to figure out
whether the stack is still valid (by calling gettid() and comparing it
with the TID written into a special offset on the stack)? Should the
exiting thread mask all signals before freeing the stack and calling
sys_exit()?

	Ingo

