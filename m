Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSIEWFj>; Thu, 5 Sep 2002 18:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSIEWEM>; Thu, 5 Sep 2002 18:04:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34445 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318283AbSIEWDl>;
	Thu, 5 Sep 2002 18:03:41 -0400
Date: Fri, 6 Sep 2002 00:10:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <Pine.LNX.4.44.0209060010070.11798-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > tsk->children: tsk's children, which are either untraced or traced by
> > 	tsk.  They have p->parent == p->real_parent == tsk.
> > 	Chained in p->sibling.
> 
> no - the way i wrote it originally was that only untraced children should
> be on the tsk->children list. Traced tasks will be on the debugger's
> ->children list, plus will be on the real parent's ->ptrace_children list.

i cant see how a ->children list that includes all children (traced and
untraced) can be useful. In fact it can be harmful: the debugger needs the
traced children to be on his own child-list, ie. there's a conflict of use
on the ->sibling list field. The ->ptrace_list entry is supposed to help
this situation - obviously use of ->ptrace_list and ->sibling has to be
mutually exclusive, no two parents can have the same task linked over
->sibling.

	Ingo


