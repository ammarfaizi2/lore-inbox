Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160030AbQHAJRo>; Tue, 1 Aug 2000 05:17:44 -0400
Received: by vger.rutgers.edu id <S160088AbQHAJRP>; Tue, 1 Aug 2000 05:17:15 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:3094 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S160144AbQHAJQZ>; Tue, 1 Aug 2000 05:16:25 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 1 Aug 2000 09:36:57 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m65np$mm3$1@enterprise.cistron.net>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4tn3$cri$1@cesium.transmeta.com> <8m4uri$d9e$1@enterprise.cistron.net> <8m54u3$dh0$1@cesium.transmeta.com>
X-Trace: enterprise.cistron.net 965122617 23235 195.64.65.200 (1 Aug 2000 09:36:57 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >8m54u3$dh0$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Followup to:  <8m4uri$d9e$1@enterprise.cistron.net>
>By author:    miquels@cistron.nl (Miquel van Smoorenburg)
>In newsgroup: linux.dev.kernel
>> 
>> >> Everything in /usr/include belongs to and depends on glibc, not
>> >> the currently running kernel.
>> >
>> >Unfortunately that doesn't work very well.  For user-space daemons
>> >which talk to Linux-specific kernel interfaces, such as automount, you
>> >need both the glibc and the Linux kernel headers.
>> 
>> Yes, but you can't mix&match anyway. For stuff like that you're
>> probably best off by using a talktokernel.c file that is
>> compiled with -I/path/to/kernel/include while the rest of the
>> daemon doesn't know about kernel internals.
>> 
>> That could and perhaps should be fixed, but I think that is
>> a different issue entirely.
>
>For most kernel interface daemons, that is not an option.  You need to
>be able to translate (or just transfer information) between
>glibc-provided and kernel-provided data structures, so you need to be
>able to include all the datatypes.

Why? As I said you can use a glue layer. Note that you still
cannot mix /usr/include/net and /usr/src/linux/include/net anyway,
so clashes will always exist with the current system.
I agree it should probably be fixed.

>Let's get this straight: #include <linux/*> and #include <asm/*> are
>*expected* to be the kernel headers.  This is a completely different
>issue from the fact that glibc headers shouldn't #include these
>headers like libc5 did.

But again as I said that is a different issue. This thread (with the
misleading Subject: header) is mostly about how to build modules
correctly.

There are 3 different issues here:

1. Consistent build environment for 3rd party modules
2. kernel-provided data structures for system daemons like autofs
3. kernel-provided data structures being used in glibc headers

I was merely talking about #1

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
