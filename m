Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUDHWWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUDHWWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:22:51 -0400
Received: from web40506.mail.yahoo.com ([66.218.78.123]:58784 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262866AbUDHWWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:22:47 -0400
Message-ID: <20040408222246.49161.qmail@web40506.mail.yahoo.com>
Date: Thu, 8 Apr 2004 15:22:46 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404081544.i38FiNdf014220@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Valdis.Kletnieks@vt.edu wrote:
> On Wed, 07 Apr 2004 21:07:56 PDT, Sergiy Lozovsky
> said:
> 
> > Actually one 'dynamic' feature is implemented in
> VXE.
> > In ordinary system resource has permissions which
> > allows access or not. For higher security VXE can
> > count number of allowed accesses. For example, we
> are
> > securing POP server. We allow it to open
> /etc/passwd,
> > /etc/shadow for reading only once (counter is 1).
> So,
> > if hacker breaks to POP server after it opened
> > /etc/passwd - there is no way hacker can open this
> > file.
> 
> Unless he finds an already open file descriptor for
> it and uses
> read()/write()/mmap()/etc - did you audit your POP
> server
> to make *really* sure that endpwent() is called at
> all the right
> times, and that said function actually is guaranteed
> to close()
> the file descriptor, and can't be forced into
> failing? (Note that
> this can be caused by either close() syscall
> failing, or the attacker
> managing to hijack the function entry point for
> either endpwent()
> or close()....)

Most common way of hacking a box looks much easier.
Usual way of stack problems was - to run shell using
security hole. Change root password or create new
account with root UID. All these usually done with
tools available at the system.

VXE use word Environment (description of available
resources), some systems use word Domain. There is no
shell, ls, vi and so on in POPD Environment. So, most
of attackers will just go away. One should be really
motivated to master unique binary code to hack VXE
protected system. Let's see what is possible even in
that case.

Let's assume there is a security hole in POPD. One
should create custom binary code to inspect RAM. How
to communicate information back to hacker? There
should be enough code to do that. This code should not
destroy POPD to such extent that it will end (or core
dumped), because hacker's code will end too. (POPD
doesn't need exec or fork for its work, so hacker
can't call these syscalls). So, in theory it is
possible to do some damage to particular subsystem,
but it's nearly impossible to compromise all system.

> Unless he finds a copy of the file on the process
> heap (more than
> one information leakage issue has come from THAT
> sort of problem)

If you have limited number syscalls (with limited
parameters you can call allowed syscalls) - it's VERY
hard to do. Purpose of VXE is to protect subsystems,
which can have security holes. In real life nobody can
gurantee, that there are no security holes in a given
system. Some time ago they constantly were finding
bugs in sendmail. Nevertheless people were using it.

> Unless he opens a new file on the system, and writes
> a binary into
> it, chmod's it to executable, and does a
> pipe/fork/exec and use
> that program's quota of opens to read it...

POPD doesn't use chmod/fork/exec, so that wouldn't
work - there are no these syscalls in POPD
Environment. Let's assume some file was created by
hacker in /var/spool/mailbox, so what? How that can
damage the system. (it's the only directory where POPD
can create/modify files).

> And that's just the *obvious* end runs.  As somebody
> else noted,
> writing the code is the easy part....

So, in theory it is possible to make some damage to
hacked subsystem (POPD for example and damaged can be
only mailboxes), but the rest of the system will be
intact (and there is a lot of stuff in the system
except POPD). But in practice with such striped
environment - without shell, editors, limited set of
syscalls - generic hackers tools will not work. Only
if someone will dedicate efforts to create custom
tools for your particular site - he can damage
mailboxes at most (in case of POPD). I think, that it
is a pretty good result.

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
