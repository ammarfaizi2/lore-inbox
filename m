Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271547AbSISQak>; Thu, 19 Sep 2002 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271557AbSISQak>; Thu, 19 Sep 2002 12:30:40 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:43497 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S271547AbSISQaj>;
	Thu, 19 Sep 2002 12:30:39 -0400
Date: Thu, 19 Sep 2002 18:35:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Message-ID: <20020919163542.GA14951@win.tue.nl>
References: <20020919105940.GJ28202@holomorphy.com> <Pine.LNX.4.44.0209190809020.3759-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209190809020.3759-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 08:12:31AM -0700, Linus Torvalds wrote:

> However, what I worry about is that there may not (will not) be a 1:1
> session<->tty thing. In particular, when somebody creates a new session 
> with "setsid()", that does not remove the tty from processes that used to 
> hold it, I think (this is all from memory, so I might be wrong).
> 
> Which means that if the tty is going away, it has to be removed from _all_ 
> tasks, not just from the one session that happened to be the most recent 
> one.

[POSIX 1003.1-2001]

Controlling Terminal

A terminal that is associated with a session. Each session may have
at most one controlling terminal associated with it, and a controlling
terminal is associated with exactly one session.
Certain input sequences from the controlling terminal cause signals
to be sent to all processes in the process group associated with
the controlling terminal. 

The Controlling Terminal

A terminal may belong to a process as its controlling terminal.
Each process of a session that has a controlling terminal has the same
controlling terminal. A terminal may be the controlling terminal
for at most one session. If a session leader has no controlling terminal,
and opens a terminal device file that is not already associated with a
session without using the O_NOCTTY option, it is implementation-defined
whether the terminal becomes the controlling terminal of the session leader.
If a process which is not a session leader opens a terminal file, or
the O_NOCTTY option is used on open(), then that terminal shall not become
the controlling terminal of the calling process. When a controlling terminal
becomes associated with a session, its foreground process group shall be set
to the process group of the session leader.

The controlling terminal is inherited by a child process during a fork()
function call. A process relinquishes its controlling terminal when it creates
a new session with the setsid() function; other processes remaining in the
old session that had this terminal as their controlling terminal continue
to have it. Upon the close of the last file descriptor in the system
(whether or not it is in the current session) associated with the controlling
terminal, it is unspecified whether all processes that had that terminal
as their controlling terminal cease to have any controlling terminal.
A process does not relinquish its controlling terminal simply by closing all
of its file descriptors associated with the controlling terminal if other
processes continue to have it open.

When a controlling process terminates, the controlling terminal is dissociated
from the current session, allowing it to be acquired by a new session leader.
Subsequent access to the terminal by other processes in the earlier session
may be denied, with attempts to access the terminal treated as if a modem
disconnect had been sensed.

