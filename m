Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLOWHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLOWHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:07:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:43394 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264241AbTLOWHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:07:38 -0500
Date: Mon, 15 Dec 2003 17:10:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Felix von Leitner <felix-kernel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
In-Reply-To: <20031215213912.GA29281@codeblau.de>
Message-ID: <Pine.LNX.4.53.0312151700320.15531@chaos>
References: <20031215213912.GA29281@codeblau.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Felix von Leitner wrote:

> I would like to be able to drop capabilities that every normal user has,
> so that network servers can limit the impact of possible future security
> problems further.  For example, I want my non-cgi web server to be able
> to drop the capabilities to
>
>   * fork
>   * execve
>   * ptrace
>   * load kernel modules
>   * mknod
>   * write to the file system
>
> and I would like to modify my smtpd to not be able to
>
>   * fork
>   * execve
>   * ptrace
>   * load kernel modules
>   * mknod
>
> I can kludge around some of these, for example I can disable fork with
> resource limits, and I can limit writing to the file system with chroot
> and proper permissions in the file systems, but I'm not aware of a way
> to disable ptrace for example, or pthread_create.
>
> I know that there are patches to provide an extended "jail" chroot
> support, but being able to drop capabilities like this would be a more
> general solution.
>
> Felix

So you expect kernel support?  Normally, real people write or
modify applications to provide for specific exceptions to
the standards. They don't expect an operating system to
modify itself to unique situations. That's not what
operating systems have generally done in the past.

The 'C' runtime library interfaces to the kernel. You
can use the ld.so.preload capabilities to substitute
private functions for fork(), etc. This has the additional
benefit of allowing crappy, poorly-written, executables
that may have buffer overflows to be executed with
increased confidence. Of course, some root-shell programs
bypass the 'C' runtime libraries.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


