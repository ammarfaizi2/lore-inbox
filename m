Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267966AbUHSDiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267966AbUHSDiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 23:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUHSDiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 23:38:11 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:26025 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267966AbUHSDiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 23:38:07 -0400
Subject: RE: setproctitle
From: Albert Cahalan <albert@users.sf.net>
To: rwhite@casabyte.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092877482.5761.2029.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Aug 2004 21:04:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What happens to all the little ps (etc.) programs
> when I munge together a *really* *long* title?

Obviously, ps prints a *really* *long* title.
I suppose, given enough tasks and ps options that
cause sorting, you could run ps out of memory.

> I'd prefer a setthreadtitle(char * new_title) such
> that the individual threads in a process (including
> the master thread, and so setproctitle() function
> is covered) could be re-titled to declare their
> purposes.  It would make debugging and logging a
> lot easier and/or more meaningful sometimes. 8-)

You won't see this in ps output. To save memory
and avoid reading normally-redundant info, ps will
only read the cmdline data once for a process.

You can get the thread ID with "ps -efL", "ps -efT",
"ps -efLm", and so on. That's pretty good. Have it all:

ps -emostat,c,psr,rtprio,class,ppid,pid,tid,nlwp,wchan:9,args

> It would also let the system preserve the original
> invocation and args for the lifetime of the process
> to prevent masquerading.  You know, by default the
> title is the args, but the set operation would
> build the new title in a new kernel-controlled
> place and move the pointer.

Now, this I like.

Solaris stores the first 80 bytes of argv in the
kernel. Modifications do not show up. HP-UX stores
the first 64 bytes, and in recent releases can
also supply a kilobyte of (modified?) argv.


