Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSDDXsL>; Thu, 4 Apr 2002 18:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312119AbSDDXrw>; Thu, 4 Apr 2002 18:47:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27652 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312076AbSDDXrm>; Thu, 4 Apr 2002 18:47:42 -0500
Date: Thu, 4 Apr 2002 18:45:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] compile error in 2.4.19-pre5-ac1
Message-ID: <Pine.LNX.3.96.1020404183703.4898A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  init/do_mounts.c uses SCHED_YIELD, which seems no longer defined
although grep tells me it's heavily used in non-Intel code. I noted that
yield() is back, defined via an asmlink, so I replaced the SCHED_YIELD and
schedule()  loop with a call to yield(). I also include linux/sched.h
which may not have been needed but avoided trying a compile without.

  No patch, I'm not sure if defining SCHED_YIELD in sched.h would have
been the better fix, or would even work, but this worked, I built my
initrd file, and it all booted correctly several times (and is up as I
type).

  Note of warning to new Redhat users, for some reason /usr/include/linux
is a directory instead of a symbolic link to /usr/src/linux/include/linux,
so changes in includes aren't used. Possibly an artifact of the install on
that system, but something to note. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

