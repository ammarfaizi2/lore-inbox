Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUDIP2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDIP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 11:28:34 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:54515 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261405AbUDIP2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 11:28:17 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>, Valdis.Kletnieks@vt.edu
Subject: Re: kernel stack challenge
Date: Fri, 9 Apr 2004 10:27:48 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040408222246.49161.qmail@web40506.mail.yahoo.com>
In-Reply-To: <20040408222246.49161.qmail@web40506.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <04040910274800.07703@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 April 2004 17:22, Sergiy Lozovsky wrote:
>
> Usual way of stack problems was - to run shell using
> security hole. Change root password or create new
> account with root UID. All these usually done with
> tools available at the system.
>
> VXE use word Environment (description of available
> resources), some systems use word Domain. There is no
> shell, ls, vi and so on in POPD Environment. So, most
> of attackers will just go away. One should be really
> motivated to master unique binary code to hack VXE
> protected system. Let's see what is possible even in
> that case.
>
> Let's assume there is a security hole in POPD. One
> should create custom binary code to inspect RAM. How
> to communicate information back to hacker? There
> should be enough code to do that. This code should not
> destroy POPD to such extent that it will end (or core
> dumped), because hacker's code will end too. (POPD
> doesn't need exec or fork for its work, so hacker
> can't call these syscalls). So, in theory it is
> possible to do some damage to particular subsystem,
> but it's nearly impossible to compromise all system.

Why shouldn't it?

It can just replace the entire code with itself.
and since you cannot prevent the use of mmap (which
is used to load the runtime libraries AND the executable)
it can still do that.

> > Unless he finds a copy of the file on the process
> > heap (more than
> > one information leakage issue has come from THAT
> > sort of problem)
>
> If you have limited number syscalls (with limited
> parameters you can call allowed syscalls) - it's VERY
> hard to do. Purpose of VXE is to protect subsystems,
> which can have security holes. In real life nobody can
> gurantee, that there are no security holes in a given
> system. Some time ago they constantly were finding
> bugs in sendmail. Nevertheless people were using it.

And they were fixing it. Not trying to make VERY kluged
work arounds in the kernel.

> > Unless he opens a new file on the system, and writes
> > a binary into
> > it, chmod's it to executable, and does a
> > pipe/fork/exec and use
> > that program's quota of opens to read it...
>
> POPD doesn't use chmod/fork/exec, so that wouldn't
> work - there are no these syscalls in POPD
> Environment. Let's assume some file was created by
> hacker in /var/spool/mailbox, so what? How that can
> damage the system. (it's the only directory where POPD
> can create/modify files).

You don't need to use chmod/fork/exec. It is entire possible
to replace the executable just by using mmap. I've already
written programs that deliberately do that (though I did use
dlopen). I've written a single binary that do anything. Including
running previously build applications.

After all - ld.so does just that during the initial load
an execed binary. All exec does is start ld.so with different
parameters... and nothing says that can't be done again.

And just not having a shell program on disk is silly - It
can be created rather easily. After all, that is what
root kits do routinely.

> > And that's just the *obvious* end runs.  As somebody
> > else noted,
> > writing the code is the easy part....
>
> So, in theory it is possible to make some damage to
> hacked subsystem (POPD for example and damaged can be
> only mailboxes), but the rest of the system will be
> intact (and there is a lot of stuff in the system
> except POPD). But in practice with such striped
> environment - without shell, editors, limited set of
> syscalls - generic hackers tools will not work. Only
> if someone will dedicate efforts to create custom
> tools for your particular site - he can damage
> mailboxes at most (in case of POPD). I think, that it
> is a pretty good result.

It would be better to use a chroot environment.
