Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSIEWaF>; Thu, 5 Sep 2002 18:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318711AbSIEWaE>; Thu, 5 Sep 2002 18:30:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16784 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318710AbSIEWaD>;
	Thu, 5 Sep 2002 18:30:03 -0400
Date: Fri, 6 Sep 2002 00:39:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905222947.GA13667@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209060036100.17495-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> If we want to do this then we'd need to fix up every ptrace
> implementation in every architecture to call the appropriate function;
> it's a separate problem.

which code relies on having debugged children only in the ->children list
and not in the ->ptrace_children list?

> > i'm not sure about this either. What happens if an (untraced) parent has
> > traced and untraced children, and does a wait4. Would it confuse the
> > debugger if the parent could get one of the traced tasks as a result in
> > wait4? And how does the debugger solve this problem?
> 
> Well, it seems to me that when a traced task has an event, it should be
> reported first to the debugger - for signals this happens in do_signal -
> and then possibly to the normal parent.  But I'm not sure if this
> actually happens right now or not.  Worth investigating some more.

it just cannot happen. There are only two kinds of events passed via
wait4: tracing related and exit related. An exiting task is not traced
anymore. And two tasks cannot trace the same task - so it can never happen
that wait4 wants to look at ->ptrace_children for events.

	Ingo

