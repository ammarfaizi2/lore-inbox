Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132292AbRCWAnt>; Thu, 22 Mar 2001 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbRCWAnj>; Thu, 22 Mar 2001 19:43:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:13064 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132292AbRCWAnX>; Thu, 22 Mar 2001 19:43:23 -0500
Message-ID: <3C9BDAC7.4B499AD1@evision-ventures.com>
Date: Sat, 23 Mar 2002 02:30:47 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Clouse <stephenc@theiqgroup.com>
CC: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva> <20010322124727.A5115@win.tue.nl> <20010322142831.A929@owns.warpcore.org> <3C9BCD6E.94A5BAA0@evision-ventures.com> <20010322182048.B1406@owns.warpcore.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clouse wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Sat, Mar 23, 2002 at 01:33:50AM +0100, Martin Dalecki wrote:
> > AMEN! TO THIS!
> > Uptime of a process is a much better mesaure for a killing candidate
> > then it's size.
> 
> Thing is, if you take a good study of mm/oom_kill.c, it *does* take start time

I did thing is Rik did use a non normalized formula in oom_kill for the
calculation of the kill penalty a process get's. This is the main
reason for the non controllable behaviour of it.

> into account, as well as CPU time.  The problem is that a process (like Oracle,
> in our case) using ludicrous amounts of memory can still rank at the top of the
> list, even with the time-based reduction factors, because total VM is the
> starting number in the equation for determining what to kill.  Oracle or what
> not sitting at 80 MB for a day or two will still find a way to outrank the
> newly-started 1 MB shell process whose malloc triggered oom_kill in the first
> place.

This is due to the broken calculation formula in oom_kill().

> 
> If anything, time really needs to be a hard criterion for sorting the final list
> on and not merely a variable in the equation and thus tied to vmsize.
> 
> This is why the production database boxen aren't running 2.4 yet.  I can control
> Oracle's usage very finely (since it uses a fixed memory pool preallocated at
> startup), but if something else decides to fire up on there (like the nightly
> backup and maintenance routine) and decides it needs just a pinch more memory
> than what's available -- ick.  2.2.x doesn't appear to enforce new memory
> allocation with a sniper rifle -- the new process just suffers a pleasant ("Out
> of memory!") or violent (SIGSEGV) death.

And you should never ever overcommit memmory to oracle! Don't make the
buffers bigger then half the memmory in the system really. There ARE
circumstances where oracle is using all available memmory in very random
manner.
