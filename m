Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318642AbSHPRdu>; Fri, 16 Aug 2002 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318649AbSHPRdu>; Fri, 16 Aug 2002 13:33:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39043 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318642AbSHPRdt>;
	Fri, 16 Aug 2002 13:33:49 -0400
Date: Fri, 16 Aug 2002 19:38:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <Pine.LNX.4.44.0208161033090.3193-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208161932320.23414-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Linus Torvalds wrote:

> > having looked at threading libraries i can tell you that any library
> > writer who cares about performance would use a futex for exit
> > notification.
> 
> Oh, good. If it turns out that even pthreads wants the futex, [...]

yes, pthreads used a futex for this ever since. This is what i was arguing
for all along, and this is why pthreads does not want any SIGCHLD
internally, ever. This is why i sent the patch that ended up being
CLONE_DETACHED. No signal notification is needed, everything can be done
via futexes. And all the 'unsafe exit' arguments are bogus...

merging futex release into exit() removes one more extra syscall, and
removes the need for having a thread-state-usage spinlock (of sorts). So
from the pthreads point of view the interface couldnt be nicer.

> [...] let's just do it that way. Pls send in a patch once you have
> something tested ready, ok?

okay.

	Ingo

