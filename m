Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319063AbSHSWbU>; Mon, 19 Aug 2002 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSHSWbU>; Mon, 19 Aug 2002 18:31:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27079 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319063AbSHSWbT>;
	Mon, 19 Aug 2002 18:31:19 -0400
Date: Tue, 20 Aug 2002 00:36:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <100750000.1029793342@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0208200035250.5286-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Dave McCracken wrote:

> > No, you only need to make debugged children slightly pecial in wait4(), in
> > that the parent must never see their state, only the fact that they are
> > there (as if they were still running, in short, regardless of their _real_
> > state)
> 
> So does that mean we need something like a 'count of children stolen by
> debuggers' in the task struct that wait4() can check?

in fact we have this already, almost:

	if (!list_empty(&current->ptrace_children))

then block (or return -EAGAIN). Instead of the current -ENOCHLD.

	Ingo

