Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTBIDVU>; Sat, 8 Feb 2003 22:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTBIDVU>; Sat, 8 Feb 2003 22:21:20 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59298 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267154AbTBIDVT>; Sat, 8 Feb 2003 22:21:19 -0500
Date: Sat, 8 Feb 2003 19:30:45 -0800
Message-Id: <200302090330.h193UjR04919@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Linus Torvalds's message of  Saturday, 8 February 2003 18:33:06 -0800 <Pine.LNX.4.44.0302081826230.7675-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I'm wet!  I'm wild!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is definitely something after that patch.  gdb is broken in ways that
are being mysterious to me, and now zombies with ppid 1 are sticking around
forever.  With that patch, do:

  bash$ (sleep 2 & echo zombie $! ; exec sleep 10000000) & sleep 4; kill -9 $!
  [2] 1220
  zombie 1222
  bash$ ps l1222
  [2]+  Killed                  ( sleep 2 & echo zombie $!; exec sleep 10000000 )
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
  0  5281  1222     1  15   0     0    0 wait4  Z    pts/1      0:00 [sleep <defun

Such zombies seem to stick around forever.  I must have managed to break
the normal delivery of SIGCHLD to init, but right now it's a mystery to me how.
