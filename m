Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTJBODI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTJBODI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:03:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:61428 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263366AbTJBODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:03:05 -0400
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
From: Albert Cahalan <albert@users.sf.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F7BB073.60509@redhat.com>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
	 <3F7B9CF9.4040706@redhat.com> <1065067968.741.75.camel@cube>
	 <3F7BB073.60509@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065102539.741.94.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Oct 2003 09:48:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-02 at 00:58, Ulrich Drepper wrote:
> Albert Cahalan wrote:
> 
> > In that case, don't you already have a severe mess?
> > [...]
> 
> That's all completely up to whoever decides to use this combination of
> CLONE_* flags.  It might mean that SIGIO cannot be used and that fuser
> cannot be used.  But so what?  That might be acceptable in that
> situation.

To the user, maybe. To the admin, no. The admin uses
fuser and/or lsof to find out why he can't umount.
If those programs were thread-aware (they are not),
then they could take many minutes to run.

In other words, stuff runs faster if we can ban this.
If not, please suggest a way to make fuser and lsof fast.

> Of course it could be redefined as "point to the process group leader"
> but I'm not sure whether this and introducing "/proc/task" or so is
> worth the trouble.

Adding a /proc/task isn't any more trouble.
I guess I'll do that in any case.

If /proc/self should be some deprecated hack that
goes through the invisible non-leader directories
at top-level, then it itself should be made invisible
and a /proc/proc (pointing to tgid) should be added.
A /proc/proc could be backported to 2.4.xx. We'd then
have top-level links for process (tgid, "proc", POSIX PID),
thread (pid, "task", POSIX TID), and... an ugly thing
that we can kill 5 years from now.


