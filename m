Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTD1Ao6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 20:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTD1Ao6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 20:44:58 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:58189 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S262513AbTD1Ao5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 20:44:57 -0400
Date: Sun, 27 Apr 2003 20:57:12 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: linux-kernel@vger.kernel.org
Subject: [RFD] Combined fork-exec syscall.
Message-ID: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

Is there any interest in a single system call that will perform both a
fork() and exec()? Could this save some extra work of doing a
copy_mm(), copy_signals(), etc?

I would think on large, multi-user systems that are spawning processes all
day, this might improve performance if the shells on such a system were
patched.

Perhaps a system call like:

   pid_t spawn(const char *p_path,
               const char *argv[],
               const char *envp[],
               const int   filp[]);

The filp array would allow file descriptors to be redirected. It could be
terminated by a -1 and reference the file descriptors of the current
process (this could also potentially save some dup() syscalls).

If any of these parameters (exclusing p_path) are NULL, then the
appropriate values are taken from the current process.

I originally was thinking of a name of fexec() for such a syscall, but
since there are already "f" variant syscalls (fchmod, fstat, ...) that an
fexec() would make more sense about executing an already open file, so the
name spawn() came to mind.

I know almost all of my fork()-exec() code does almost the same thing. I
guess vfork() was a potential solution, but this somehow seems cleaner
(and still may be more efficient than having to issue two syscalls)...
the downside is, of course, another syscall.

L8r,
Mark G.

