Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVGNWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVGNWBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNWAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:00:51 -0400
Received: from oban.u-picardie.fr ([193.49.184.8]:21096 "EHLO
	mailx.u-picardie.fr") by vger.kernel.org with ESMTP id S261625AbVGNV6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:58:37 -0400
Message-ID: <1121378308.42d6e00473669@webmail.u-picardie.fr>
Date: Thu, 14 Jul 2005 23:58:28 +0200
From: FyD <fyd@u-picardie.fr>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel 2.6.11
References: <1121369685.42d6be556505f@webmail.u-picardie.fr> <200507142106.06682.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507142106.06682.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 137.131.252.204
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alistair John Strachan <s0348365@sms.ed.ac.uk>:

> > I have a problem with a program named Gaussian (http://www.gaussian.com)
> > (versions g98 or g03) and FC 4.0 (default kernel 2.6.11): I am used to take
> > Gaussian binaries compiled on the RedHat 9.0 version, and used them on FC
> > 2.0 or FC 3.0. If I try to do so, on FC 4.0. (with the default kernel)
> > Gaussian stops (both g98 and g03 versions) with the following error
> > message:
> >
> > [fyd@localhost ~]$ g98 < toto-g98.com> toto-g98.log
> > [fyd@localhost ~]$ g03 < toto-g03.com> toto-g03.log
> > Erroneous write during file extend. write 208 instead of 4096
> > Probably out of disk space.
> > Write error in NtrExt1: No such file or directory
> >
> > And obviously, I do _not_ have any problem of space and no NFS server on my
> > machine...
> >
> > Now if I compile and use the kernel 2.6.12, this message dispears and the
> > program Gaussian g98 works fine, but I still have problems with the version
> > g03 which stops without providing any message...
> >
> > From my tests, it seems to be a problem relative to the kernel. Being not a
> > programmer, it is difficult for me to imagine the problem, and even to
> > describe it...
>
> Install "strace", then run the programs like:
> strace g98 < toto-g98.com> toto-g98.log
> You'll be able to see what syscalls fail and their decoded return values.
> This
> is extremely useful for determining how a binary application is interacting
> with libc and, inevitably, the kernel.

If I do strace g98 < toto-g98.com> toto-g98.log
The job finished well and the end of the strace output is:

stat64("/usr/local/g98/l1.exe", {st_mode=S_IFREG|0755, st_size=516678, ...}) = 0
write(1, " Entering Gaussian System, Link "..., 137) = 137
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_PARENT_SETTID|SIGCHLD,
parent_tidptr=0xbf9db204) = 3175
waitpid(3175, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 3175
rt_sigaction(SIGINT, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
stat64("/home/fyd/0QM_SCR/Gau-3174.inp", 0xbf9db114) = -1 ENOENT (No such file
or directory)
munmap(0x43a45000, 4096)                = 0
exit_group(0)                           = ?


If I do strace g03 < toto-g03.com> toto-g03.log
The job finished stop with any warning and the end of the strace output is:

stat64("/usr/local/g03/l1.exe", {st_mode=S_IFREG|0750, st_size=460870, ...}) = 0
write(1, " Entering Gaussian System, Link "..., 137) = 137
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
fork()                                  = 3237
wait4(3237, [{WIFSIGNALED(s) && WTERMSIG(s) == SIGSEGV}], 0, NULL) = 3237
rt_sigaction(SIGINT, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
stat64("/home/fyd/0QM_SCR/Gau-3236.inp", {st_mode=S_IFREG|0644, st_size=554,
...}) = 0
unlink("/home/fyd/0QM_SCR/Gau-3236.inp") = 0
_exit(1)                                = ?

There is a difference at the end of each strace log file. But what does it mean
?

Thanks, Francois

PS Please once again, add my email address in CC since I did not register...
