Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTKMP6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTKMP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:58:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9603 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264336AbTKMP6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:58:00 -0500
Date: Thu, 13 Nov 2003 11:00:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: "martin.knoblauch " <"martin.knoblauch "@mscsoftware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_statfs: statfs error = 116
In-Reply-To: <shssmks70gc.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.53.0311131052260.31147@chaos>
References: <3FB391FC.2090406@mscsoftware.com> <Pine.LNX.4.53.0311130927280.30784@chaos>
 <shssmks70gc.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Trond Myklebust wrote:

> >>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:
>
>      > ESTALE happens when a mounted file-system is on a server that
>      > went down or re-booted. The file-handles are then "stale".
>
> Sort of. It means that the server is unable to find the file that
> corresponds to the filehandle that the client sent it. If the server
> strictly follows the NFS specs, then this is only supposed to happen
> if somebody else has deleted the file (and this is why designing a
> scheme for generating filehandles is such a difficult job).
>
> Some broken servers do, however, "lose" the file in other interesting
> and unpredictable ways.
>
>      > ERESTARTSYS is the error returned by a server that has
>      > re-booted that is supposed to tell the client-side software to
>      > get a new file-handle because of an attempt to access with a
>      > stale file-handle. When getting this error, the client should
>      > have reopened the file(s) to obtain a new handle.
>
> ERESTARTSYS actually just means that a signal was received while
> inside a system call. If this results in a interruption of that
> syscall, the kernel is supposed to translate ERESTARTSYS into the user
> error EINTR.
>
> Userland should therefore never have to handle ERESTARTSYS errors.
>

Hmmm, Maybe I'm getting confused by all the winning-lottery messages,
but it's in the syscall specifications for connect() and
even fcntl(). http:/www.infran.ru/Techinfo/syscalls/syscalls_43.html

Also, maybe Linux now claims exclusive ownership and keeps it internal,
but some networking software, nfsd and pcnfsd, might not know about that.
I've seen ERESTARTSYS returned from a DOS (actually FAT) file-handle use
after a server has crashed and come back on-line.

Moot point, though, the reported errors were internal via syslog, which
was not previously known when I responded.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


