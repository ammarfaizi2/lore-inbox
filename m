Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290309AbSAPAvr>; Tue, 15 Jan 2002 19:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290308AbSAPAvj>; Tue, 15 Jan 2002 19:51:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33201 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290313AbSAPAv0>;
	Tue, 15 Jan 2002 19:51:26 -0500
Date: Wed, 16 Jan 2002 03:48:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
In-Reply-To: <20020116004452.7C241CCB54@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33.0201160343230.30495-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Ed Tomlinson wrote:

> OK I3 also works fine with respect to my nice test. [...]

good!

> Watching with top 's 0.3' I can see them lose priority in the 3-10
> seconds it takes them to setup.  This is not that critical if they are
> the only thing trying to run.  If you have another (not niced) task
> eating cpu (like a kernel compile)  then intactive startup time
> suffers.  Startup time is wait time that _is_ noticed by users.

well, the kernel needs some 'proof' that a task is interactive, before it
gives it special attention.

the scheduler will give newly started up tasks some credit (if the parent
is interactive), but if they take too long to start up then there is
nothing it can do but to penalize them.

> Is there some way we could tell the scheduler or the scheduler could
> learn that a given _program_ is usually interactive so it should wait
> at bit (10 seconds on my box would work) before starting to increase
> its priority numbers?

there is a way: renicing. Either use nice +19 on the compilation job or
use nice -5 on the 'known good' tasks. Perhaps we should allow a nice
decrease of up to -5 from the default level - and things like KDE or Gnome
could renice interactive tasks, while things like compilation jobs would
run on the default priority.

	Ingo

