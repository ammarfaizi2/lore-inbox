Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSCGDzF>; Wed, 6 Mar 2002 22:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292877AbSCGDyr>; Wed, 6 Mar 2002 22:54:47 -0500
Received: from anchor.engin.umich.edu ([141.213.40.34]:45832 "EHLO
	anchor.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S292554AbSCGDyh>; Wed, 6 Mar 2002 22:54:37 -0500
Date: Wed, 6 Mar 2002 22:54:32 -0500 (EST)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: <laurent@augias.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ?chown and ?chown32 syscalls
Message-ID: <Pine.LNX.4.33.0203062243140.25407-100000@anchor.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent:

Prior to Linux 2.4, uid_t on i386 Linux was a 16 bit type. In Linux 2.4
uid_t was changed to be 32 bits on all Linux architectures. Those
architectures (such as x86) which formerly used a 16 bit uid_t needed to
have new syscall entries added, one of which is chown32.

At the same time, to preserve backwards compatibility with old software,
the existing 16 bit uid_t system calls were left intact, including the old
chown.

As of glibc 2.2, chown32 is used first if the kernel supports it, else
glibc falls back to using the old 16 bit uid_t syscalls.


If you use a version of glibc older than 2.2 or a Linux kernel older than
2.4, the old 16 bit uid_t system calls will be used on i386.

Note that Linux architectures which always used a 32 bit uid_t do not have
this second set of system calls, and chown32 will not be defined for them
in asm/unistd.h.

-Chris Wing
wingc@engin.umich.edu


> In asm/unistd.h there are 2 series of syscalls for chown commands (chown,
> lchown and fchown) : the ?chown and ?chown32
> In 2.4.17 (ix86) the system is using the ?chown32 syscalls, when I intercept
> the ?chown syscalls nothing happens. Are these syscalls deprecated ?
>
> Thanks for any help.
> Laurent Sinitambirivoutin
> laurent@augias.org

