Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131623AbRCSVSf>; Mon, 19 Mar 2001 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131612AbRCSVSZ>; Mon, 19 Mar 2001 16:18:25 -0500
Received: from [63.109.146.2] ([63.109.146.2]:43764 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S131623AbRCSVSO>;
	Mon, 19 Mar 2001 16:18:14 -0500
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B40@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        linux-kernel@vger.kernel.org
Subject: RE: Linux should better cope with power failure
Date: Mon, 19 Mar 2001 13:16:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Otto Wyss wrote:
> situation was switching power off and on after a few minutes of
> inactivity. From the impression I got during the following startup, I

You aren't giving a lot of detail here.  I assume your startup scripts run
fsck, and you saw a lot of errors.  Were any of them uncorrectable?  

> assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power
> failiure or manually switching it off. Not even if there wasn't any
> activity going on. 

That is correct.  Pulling the plug on non-journaled filesystems is a
bad idea.

> Shouldn't a good system allways try to be on the save side? 

Yes.  Some of this is your responsibility.  You have several options:
1. Get a UPS.  That would not have helped your particular problem,
   but it's a good idea if you care about data integrity.
2. Use a journaling file system.  These are much more tolerant of
   abuse.  Reiserfs seems to work for me on embedded systems I am
   building where the user can (and does) remove the power any time.
3. Use RAID.  Hard drives are very cheap and software raid is very 
   easy to set up.

> There is currently much work done in
> getting high performance during high activity but it seems there is no
> work done at all in getting a save system during low/no activity. 

Actually, a lot of work _is_ being done on journaling file systems
which help solve this problem.  Current journaling file systems are
metadata only, but Tux2 (if I understand it) will journal everything.

> How could this be accomplished:
> 1. Flush any dirty cache pages as soon as possible. There may 
> not be any
> dirty cache after a certain amount of idle time.

This can be done from user space.  The simple approach would be to set up a
cron job to sync and flush buffers every "n" seconds.  A smarter approach
would examine the load average, and not sync if the load was high.  This
does not need to be in the kernel.

> 2. Keep open files in a state where it doesn't matter if they where
> improperly closed (if possible).

This is mostly a user space problem as well.  It has been solved for
editors which automatically save files every "n" minutes.   I don't know
if it can be solved from kernel space - if applications leave files in
an inconsistent state, how can the kernel possibly do anything about it?

> 3. Swap may not contain anything which can't be discarded. Otherwise
> swap has to be treated as ordinary disk space.

I'm not an expert, but I don't think this is relevant?

> Don't we tell children never go close to any abyss or doesn't have
> alpinist a saying "never go to the limits"? So why is this simple rule
> always broken with computers?

So were you breaking this rule?  Were you using a journaling file system,
or RAID, or a UPS?  

Torrey Hoffman
