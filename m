Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160026AbQGaV3s>; Mon, 31 Jul 2000 17:29:48 -0400
Received: by vger.rutgers.edu id <S160094AbQGaV1p>; Mon, 31 Jul 2000 17:27:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1558 "EHLO chaos.analogic.com") by vger.rutgers.edu with ESMTP id <S160066AbQGaVZZ>; Mon, 31 Jul 2000 17:25:25 -0400
Date: Mon, 31 Jul 2000 17:49:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
In-Reply-To: <8m4q9v$871$1@enterprise.cistron.net>
Message-ID: <Pine.LNX.3.95.1000731173215.4111A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On 31 Jul 2000, Miquel van Smoorenburg wrote:

> In article >Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com>,
> Richard B. Johnson <root@chaos.analogic.com> wrote:
> > /usr/include/linux and /usr/include/asm are symbolic links, referenced
> >to /usr/src/linux, not a specific version. This makes changing kernel
> >development versions a simple change of a single symbolic link.
> 
> No. Even Linus himself has been saying for years (and recently even
> in this thread) that /usr/include/linux and /usr/include/asm should
> NOT EVER be symlinks to /usr/src/linux
> 

I don't think Linus said that at all. In fact, the first trees that
Linus made and distributed were done this way and have become the
de-facto standard as a result of this.

> Everything in /usr/include belongs to and depends on glibc, not
> the currently running kernel.
> 

No. I have /usr/include/subdirectories which contain headers for X11, some
that contain headers for Motif, some that contain headers for pthreads,
bind-4.9.3, etc. These are not glibc headers.

You cannot decide that I can't keep these where they are.

Any portable code is not supposed to include non-portable headers.
This means that if your code does:

#include <linux/something.h>

it is not portable. If your portable code is written properly, the
presence of links to non-portable headers in /usr/include does nothing.
They are never referenced.

When you need to have current kernel headers referenced, your non-
portable code (like modules) specifically includes the linux headers.
This is now it's been done. I see no reason to change it.

> And if you want to compile modules and use /usr/include/linux for
> the include files, what are you going to do about networking
> modules that use include/net ? The one in the kernel source is
> very, very different from the one in glibc .. so you have to compile
> with -I/path/to/kernel/include _anyway_
> 
> You can't just use /usr/src/linux/include, what if you want to compile
> against another kernel version? What if you are not root ?
> 

We don't use /usr/src/linux/include. As stated, the include files
are referenced from /usr/include.


> The /lib/modules/version/ stuff is a good idea, but it should
> contain a `kernel-config' script that outputs the complete CFLAGS
> that the kernel was compiled with. Easy, simple, enduser friendly.
> 


Cheers,
Dick Johnson

Penguin: Linux version 2.2.15 on an i686 machine (797.90 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
