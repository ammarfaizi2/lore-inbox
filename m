Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSJVDRM>; Mon, 21 Oct 2002 23:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSJVDRL>; Mon, 21 Oct 2002 23:17:11 -0400
Received: from ecs.syr.edu ([128.230.208.14]:17911 "EHLO erebus.ecs.syr.edu")
	by vger.kernel.org with ESMTP id <S262038AbSJVDRK>;
	Mon, 21 Oct 2002 23:17:10 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-14smp sys_call_table not found by the LKM loader
Message-ID: <1035256996.3db4c4a484a23@webmail.ecs.syr.edu>
Date: Mon, 21 Oct 2002 23:23:16 -0400 (EDT)
From: Haizhi Xu <hxu02@ecs.syr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.8
X-Originating-IP: 128.230.14.117
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Friends:
I use linux kernel 2.4.18-14smp. I am trying a kernel module with a reference to
sys_call_table as:
extern void *sys_call_table[];
However, when loading the module into the kernel, the loader reports:
unresolved symbol sys_call_table
I read the following and related messages. My question is:
Is it true that I can NOT reference sys_call_table[] from a kernel loadable
module in 2.4.18-14smp or higher version kernels? Then if I need to intercept
system calls, how should I do it?
Thanks a lot for answers.
Hai



Re: Two fixes for 2.4.19-pre5-ac3
Erik Tews (erik.tews@gmx.net)
Mon, 8 Apr 2002 01:31:22 +0200

    * Messages sorted by: [ date ][ thread ][ subject ][ author ]
    * Next message: Brendan J Simon: "Re: [kbuild-devel] Re: Announce: Kernel
Build for 2.5, Release 2.0 is available"
    * Previous message: Alan Cox: "Re: 2.4.18 AND Geode GX1/200Mhz problem"
* In reply to: Alan Cox: "Re: Two fixes for 2.4.19-pre5-ac3"

On Sun, Apr 07, 2002 at 06:42:05PM +0100, Alan Cox wrote:
> > And, unless this is reversed the OpenAFS kernel module won't load (it
> > needs sys_call_table.):
>
> Correct. There was agreement a very long time ago that code should not patch
> the syscall table (for one its not safe). AFS probably needs fixing so the
> AFS syscall hook is exported portably and nicely in the syscall code.

I am really not an expert on kernel-programming but I remember that
there was a security-hole in the ptrace-code with which one a local user
could gain root access. And there was a little kernel-modul with a
wrapper-function for the ptrace-syscall that made traces only possible
if the user who was calling this syscall was root. So if I understand
right if we don't export the syscall-table it is impossible to write
such syscall-wrapper-functions and it requires to recompile the kernel
and reboot the machiene to fix such an security-hole.

So wouldn't it be better to export the syscall-table and just write into
the documentation that it is not a good idea to manipulate syscalls or
write a compiler-makro that gives out a warning when such a module is
beeing compiled.

