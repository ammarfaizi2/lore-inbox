Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTD1A4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 20:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTD1A4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 20:56:43 -0400
Received: from firenze.terenet.com.br ([200.255.3.10]:50878 "EHLO
	firenze.terenet.com.br") by vger.kernel.org with ESMTP
	id S262598AbTD1A4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 20:56:42 -0400
From: Rafael Costa dos Santos <rsantos@terenet.com.br>
To: linux-kernel@vger.kernel.org, Mark Grosberg <mark@nolab.conman.org>
Date: Mon, 28 Apr 2003 22:05:49 -0300
X-Priority: 3 (Normal)
Reply-To: rafael@thinkfreak.com.br
In-Reply-To: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
Message-Id: <MK1YLGYVX1UUOSNUQPN482OM94POGC.3eadcfed@rafaelnote.ns1.lhost.com.br>
Subject: Re: [RFD] Combined fork-exec syscall.
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Mailer: Opera 6.05 build 1140
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have some work done on this issue ?


4/27/03 9:57:12 PM, Mark Grosberg <mark@nolab.conman.org> wrote:

>
>Hello all,
>
>Is there any interest in a single system call that will perform both a
>fork() and exec()? Could this save some extra work of doing a
>copy_mm(), copy_signals(), etc?
>
>I would think on large, multi-user systems that are spawning processes all
>day, this might improve performance if the shells on such a system were
>patched.
>
>Perhaps a system call like:
>
>   pid_t spawn(const char *p_path,
>               const char *argv[],
>               const char *envp[],
>               const int   filp[]);
>
>The filp array would allow file descriptors to be redirected. It could be
>terminated by a -1 and reference the file descriptors of the current
>process (this could also potentially save some dup() syscalls).
>
>If any of these parameters (exclusing p_path) are NULL, then the
>appropriate values are taken from the current process.
>
>I originally was thinking of a name of fexec() for such a syscall, but
>since there are already "f" variant syscalls (fchmod, fstat, ...) that an
>fexec() would make more sense about executing an already open file, so the
>name spawn() came to mind.
>
>I know almost all of my fork()-exec() code does almost the same thing. I
>guess vfork() was a potential solution, but this somehow seems cleaner
>(and still may be more efficient than having to issue two syscalls)...
>the downside is, of course, another syscall.
>
>L8r,
>Mark G.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


