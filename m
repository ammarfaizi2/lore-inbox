Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268277AbTBMUFO>; Thu, 13 Feb 2003 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268280AbTBMUFO>; Thu, 13 Feb 2003 15:05:14 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34958 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268277AbTBMUFN>; Thu, 13 Feb 2003 15:05:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 13 Feb 2003 12:22:06 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Linus Torvalds wrote:

> It's a generic "synchronous signal delivery" method, and it uses a
> perfectly regular file descriptor to deliver an arbitrary set of signals
> that are pending.
>
> It adds one new system call:
>
> 	fd = sigfd(sigset_t * mask, unsigned long flags);
>
> which creates a file descriptor that is associated with the particular
> thread that created it, and the particular signal mask that the user was
> interested in. That file descriptor can be passed around all the normal
> ways: it can be dup()'ed, given to somebody else with a AF_UNIX socket,
> and obviously read() and select()/poll()'ed upon.

That's really nice, I like file-based interfaces. No plan to have a way to
change the sig-mask ? Close and reopen ?
What do you think about having timers through a file interface ?



> Any real use would also probably be a select() or poll() loop.

And sice it supports ->poll(), epoll.




- Davide

