Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311290AbSCLQwU>; Tue, 12 Mar 2002 11:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311286AbSCLQwK>; Tue, 12 Mar 2002 11:52:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25865 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311287AbSCLQv6>; Tue, 12 Mar 2002 11:51:58 -0500
Date: Tue, 12 Mar 2002 11:50:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Edgar Toernig <froese@gmx.de>
cc: Doug Siebert <dsiebert@divms.uiowa.edu>, linux-kernel@vger.kernel.org
Subject: Re: Fast Userspace Mutexes (futex) vs. msem_*
In-Reply-To: <3C893570.767929F9@gmx.de>
Message-ID: <Pine.LNX.3.96.1020312114314.31421D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Edgar Toernig wrote:

> And what is "right"?  You have two problems:
> 
>  - The kernel has no idea of how many locks a dying process holds.  The
>    kernel only starts to know about a lock when another process has to
>    wait for it.

There have been some discussions on this, it seems possible to make the
information available, to {kernel,lockmanager,other}.
 
>  - Locked data may be in an inconsistent state.  The kernel has no idea
>    how to "repair" it.

But that's true for other things as well, like locks on regions of files.
That hasn't prevented locking from working and being useful.

What I don't like is the idea of processes sitting forever with their
thumb up their ass waiting for an unlock which isn't going to come. I have
an application like that, starts a few thousand threads and spins at
10-70k ctx/sec forever. It's (a) commercial binary-only, and (b) selected
by management against my recommendations. The vendor blames Linux, of
course, "threads don't work right," meaning "like Solaris" rather than
"like POSIX."

I would LOVE to see Andrea's "Child Run First" and optional part of the
mainline kernel, the patch seems to solve the hang, but doesn't play well
with other patches.

I don't see either of the above as show stoppers, although I agree they
are implementation issues.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

