Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319051AbSHMSEu>; Tue, 13 Aug 2002 14:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319055AbSHMSEu>; Tue, 13 Aug 2002 14:04:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30937 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319051AbSHMSEV>;
	Tue, 13 Aug 2002 14:04:21 -0400
Date: Tue, 13 Aug 2002 20:08:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131057390.9145-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132004190.5990-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> If you want to do this, you can do it at _clone_ time, by extending on
> the notion of "when I die, tell the parent using signal X" and making
> that notion be a more generic "when I die, do X", where "X" migh include
> updating some parent tables instead of sending a signal.
> 
> But the magic "exit_write()" has to die.

think about it - we have the *very same* problem in kernel-space, and we
had it for years. People wanted to get rid of parent notification in
helper processes for ages. A thread cannot free its own stack. We now can
do it only with very special care and atomicity. The same thing cannot be
done by user-space, because it has no 'atomic change and sys_exit()'
operation at its hands. This capability is that the syscall provides -
perhaps it should be called 'exit_atomic()' instead?

(we got rid of all signal passing in the main fabric of pthreads - and
that's done rightfully so. Futexes are used for message passing and
eventing.)

	Ingo

