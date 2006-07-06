Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWGFJXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWGFJXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWGFJXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:23:30 -0400
Received: from mail.gmx.net ([213.165.64.21]:16788 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965024AbWGFJXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:23:30 -0400
Cc: mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com, eggert@cs.ucla.edu,
       paire@ri.silicomp.fr, drepper@redhat.com, torvalds@osdl.com,
       tytso@mit.edu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 06 Jul 2006 11:23:28 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <44AABB31.8060605@colorfullife.com>
Message-ID: <20060706092328.320300@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
Subject: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
To: Manfred Spraul <manfred@colorfullife.com>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

> Michael Kerrisk wrote:
> 
> > c) The Linux baehviour has been arbitrary across kernel versions and 
> > system calls.  In particular, the following system calls showed this 
> > behaviour in earlier kernel versions, but then the behaviour was 
> > changed without forewarning and (AFAIK) without subsequent complaint:
> >
> > [snip]
> >
> >       * msgsnd() and msgrcv() in kernels before 2.6.9.
> >
> That was my change - and I even forgot to mention it in the changelog 
> (hiding in shame):
> I replaced -EINTR with -ERESTARTNOHAND.

Well, that change was useful for my argument: the change appears 
to have affected no-one, and so why not make it also for futex(), 
sigtimedwait(), semop()/semtimedop(), inotify read(),
epoll_wait()...

> That hides signals that are handled in the kernel from user space - 
> probably what we want.

Yes.

> Michael: Could you replace the EINTR in inotify.c with ERESTARTNOHAND? 
> That should prevent the kernel from showing the signal to user space.
> I'd guess that most instances of EINTR are wrong, except in device 
> drivers: It means we return from the syscall, even if the signal handler 
> wants to restart the system call.

I'll try patching a kernel to s/EINTR/ERESTARTNOHAND/ in relevant
places, and see how that goes.  If it goes well, I'll submit a 
patch.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
