Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTD1BxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTD1BxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:53:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60044 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263140AbTD1Bw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:52:58 -0400
Date: Sun, 27 Apr 2003 22:09:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mark Grosberg <mark@nolab.conman.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <Pine.LNX.4.53.0304272203570.14901@chaos>
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Mark Grosberg wrote:

>
> Hello all,
>
> Is there any interest in a single system call that will perform both a
> fork() and exec()? Could this save some extra work of doing a
> copy_mm(), copy_signals(), etc?
>
> I would think on large, multi-user systems that are spawning processes all
> day, this might improve performance if the shells on such a system were
> patched.
>
> Perhaps a system call like:
>
>    pid_t spawn(const char *p_path,
>                const char *argv[],
>                const char *envp[],
>                const int   filp[]);
>
> The filp array would allow file descriptors to be redirected. It could be
> terminated by a -1 and reference the file descriptors of the current
> process (this could also potentially save some dup() syscalls).
>
> If any of these parameters (exclusing p_path) are NULL, then the
> appropriate values are taken from the current process.
>
> I originally was thinking of a name of fexec() for such a syscall, but
> since there are already "f" variant syscalls (fchmod, fstat, ...) that an
> fexec() would make more sense about executing an already open file, so the
> name spawn() came to mind.
>
> I know almost all of my fork()-exec() code does almost the same thing. I
> guess vfork() was a potential solution, but this somehow seems cleaner
> (and still may be more efficient than having to issue two syscalls)...
> the downside is, of course, another syscall.
>
> L8r,
> Mark G.

You don't save anything but one system call time which is inconsequential
compared to the time necessary to exec (load a file, etc). Also, it is
worthless for anything except the most basic 'system()' or popen()
enulation. In fact, it wouldn't even work for popen() because one
needs to set up a pipe in the child before the exec.

All it does is add kernel bloat and duplicate existing kernel code
(both). Learn Unix instead of trying to make it VMS with spawn().


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

