Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUIMOvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUIMOvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUIMOsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:48:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7555 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267683AbUIMOqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:46:03 -0400
Date: Mon, 13 Sep 2004 10:42:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Constantine Gavrilov <constg@qlusters.com>
cc: bugs@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Calling syscalls from x86-64 kernel results in a crash on
 Opteron machines
In-Reply-To: <4145ABEE.5050606@qlusters.com>
Message-ID: <Pine.LNX.4.53.0409131027230.12575@chaos>
References: <200409131715.27584.anatolya@qlusters.com> <4145ABEE.5050606@qlusters.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Constantine Gavrilov wrote:

> >
> >
> >Subject: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
> >Date: Mon, 13 Sep 2004 17:04:17 +0300
> >From: Constantine Gavrilov <constg@qlusters.com>
> >To: bugs@x86-64.org, linux-kernel@vger.kernel.org
> >
> >Hello:
> >
> >We have a piece of kernel code that calls some system calls in kernel
> >context (from a process with mm and a daemonized kernel thread that does
> >not have mm). This works fine on IA64 and i386 architectures.
> >
> ..............

Okay, It's a real process that has its own context.

>
> >Attached please find a test module that tries to call the umask() (JUST
> >TO DEMONSTRATE a problem) via the syscall machanism. Both methods (the
> >_syscall1() marco and GLIBC INLINE_SYCALL() were used.
> >
> >
>

You can't use the user-mode syscalls! You need to use the kernel
procedures to which they trap (like sys_open(), etc.). The reason
is that you are operating on the kernel stack, you then generate a
trap for the system call, which starts over again on the kernel
stack (overwriting your previous return addresses, etc.).

A kernel-mode daemon has a context of its own, but it shares
kernel data and stack.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

