Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSIEWQa>; Thu, 5 Sep 2002 18:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSIEWQ3>; Thu, 5 Sep 2002 18:16:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1167 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318358AbSIEWQ1>;
	Thu, 5 Sep 2002 18:16:27 -0400
Date: Fri, 6 Sep 2002 00:25:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905221558.GA12837@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209060021360.14643-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> Right - let me rephrase.  Tasks which are either:
>   - untraced, normal
>   - traced, but traced _by their parent_
> are on the sibling/children list.

hm, why the distinction along whether the debugger == real parent? What
wrong can happen if we always move traced tasks to the ptrace list? The
task will be both in the ptrace list and in the parent's child list, and 
everything should work as expected. This looks a more symmetric and 
simpler thing to me.

> > this splitup of the lists makes it possible for the debugger to do a wait4
> > that will get events from the debugged task, and for the debugged task to
> > also be available to the real parent.
> 
> Great.  I'm not exactly sure on how this works right now: sys_wait4 only
> iterates over ->children, with the exception of the special code in
> TASK_ZOMBIE.  I'm not quite sure when events from a traced process get
> to the normal parent of that process, or when they're supposed to.

i'm not sure about this either. What happens if an (untraced) parent has
traced and untraced children, and does a wait4. Would it confuse the
debugger if the parent could get one of the traced tasks as a result in
wait4? And how does the debugger solve this problem?

	Ingo

