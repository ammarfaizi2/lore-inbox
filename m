Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSLQGfe>; Tue, 17 Dec 2002 01:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSLQGfe>; Tue, 17 Dec 2002 01:35:34 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:26006 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S264748AbSLQGfd>; Tue, 17 Dec 2002 01:35:33 -0500
Date: Mon, 16 Dec 2002 22:43:30 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       "" <linux-kernel@vger.kernel.org>, "" <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Linus Torvalds wrote:

> It's not as good as a pure user-mode solution using tsc could be, but
> we've seen the kinds of complexities that has with multi-CPU systems, and
> they are so painful that I suspect the sysenter approach is a lot more
> palatable even if it doesn't allow for the absolute best theoretical
> numbers.

don't many of the multi-CPU problems with tsc go away because you've got a
per-cpu physical page for the vsyscall?

i.e. per-cpu tsc epoch and scaling can be set on that page.

the only trouble i know of is what happens when an interrupt occurs and
the task is rescheduled on another cpu... in theory you could test %eip
against 0xfffffxxx and "rollback" (or complete) any incomplete
gettimeofday call prior to saving a task's state.  but i bet that test is
undesirable on all interrupt paths.

-dean

