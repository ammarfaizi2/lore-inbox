Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSIEWEF>; Thu, 5 Sep 2002 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318275AbSIEWDZ>; Thu, 5 Sep 2002 18:03:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18573 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318268AbSIEWCU>;
	Thu, 5 Sep 2002 18:02:20 -0400
Date: Fri, 6 Sep 2002 00:09:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <Pine.LNX.4.44.0209060009280.11747-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> There's definitely still something wrong... let me just run through my
> understanding of these lists, to make sure we're on the same page.
> 
> tsk->children: tsk's children, which are either untraced or traced by
> 	tsk.  They have p->parent == p->real_parent == tsk.
> 	Chained in p->sibling.

no - the way i wrote it originally was that only untraced children should
be on the tsk->children list. Traced tasks will be on the debugger's
->children list, plus will be on the real parent's ->ptrace_children list.

> tsk->ptrace_children: tsk's children, which are traced by some other
> 	process.  They have p->real_parent == tsk and p->parent != tsk.
> 	Chained in p->ptrace_list.

yes. This means that the sum of the two lists gives the real, total set of
children.

this splitup of the lists makes it possible for the debugger to do a wait4
that will get events from the debugged task, and for the debugged task to
also be available to the real parent.

is this really what we want?

(note that the meaning of the lists is not necesserily cleanly expressed
via the code, all deviations are most likely bugs.)

	Ingo


