Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160056AbQGaU5D>; Mon, 31 Jul 2000 16:57:03 -0400
Received: by vger.rutgers.edu id <S160018AbQGaU4J>; Mon, 31 Jul 2000 16:56:09 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:1079 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S159990AbQGaUzh>; Mon, 31 Jul 2000 16:55:37 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 31 Jul 2000 21:15:43 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m4q9v$871$1@enterprise.cistron.net>
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com>
X-Trace: enterprise.cistron.net 965078143 8417 195.64.65.200 (31 Jul 2000 21:15:43 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
> /usr/include/linux and /usr/include/asm are symbolic links, referenced
>to /usr/src/linux, not a specific version. This makes changing kernel
>development versions a simple change of a single symbolic link.

No. Even Linus himself has been saying for years (and recently even
in this thread) that /usr/include/linux and /usr/include/asm should
NOT EVER be symlinks to /usr/src/linux

Everything in /usr/include belongs to and depends on glibc, not
the currently running kernel.

And if you want to compile modules and use /usr/include/linux for
the include files, what are you going to do about networking
modules that use include/net ? The one in the kernel source is
very, very different from the one in glibc .. so you have to compile
with -I/path/to/kernel/include _anyway_

You can't just use /usr/src/linux/include, what if you want to compile
against another kernel version? What if you are not root ?

The /lib/modules/version/ stuff is a good idea, but it should
contain a `kernel-config' script that outputs the complete CFLAGS
that the kernel was compiled with. Easy, simple, enduser friendly.

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
