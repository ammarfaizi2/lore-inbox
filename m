Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160136AbQGaX64>; Mon, 31 Jul 2000 19:58:56 -0400
Received: by vger.rutgers.edu id <S160113AbQGaX5x>; Mon, 31 Jul 2000 19:57:53 -0400
Received: from [209.10.217.66] ([209.10.217.66]:3361 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S160123AbQGaX5D>; Mon, 31 Jul 2000 19:57:03 -0400
To: linux-kernel@vger.rutgers.edu
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 31 Jul 2000 17:17:07 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8m54u3$dh0$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com> <8m4uri$d9e$1@enterprise.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <8m4uri$d9e$1@enterprise.cistron.net>
By author:    miquels@cistron.nl (Miquel van Smoorenburg)
In newsgroup: linux.dev.kernel
> 
> >> Everything in /usr/include belongs to and depends on glibc, not
> >> the currently running kernel.
> >
> >Unfortunately that doesn't work very well.  For user-space daemons
> >which talk to Linux-specific kernel interfaces, such as automount, you
> >need both the glibc and the Linux kernel headers.
> 
> Yes, but you can't mix&match anyway. For stuff like that you're
> probably best off by using a talktokernel.c file that is
> compiled with -I/path/to/kernel/include while the rest of the
> daemon doesn't know about kernel internals.
> 
> That could and perhaps should be fixed, but I think that is
> a different issue entirely.
> 

For most kernel interface daemons, that is not an option.  You need to
be able to translate (or just transfer information) between
glibc-provided and kernel-provided data structures, so you need to be
able to include all the datatypes.

Let's get this straight: #include <linux/*> and #include <asm/*> are
*expected* to be the kernel headers.  This is a completely different
issue from the fact that glibc headers shouldn't #include these
headers like libc5 did.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
