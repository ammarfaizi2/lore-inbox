Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSESDBm>; Sat, 18 May 2002 23:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSESDBl>; Sat, 18 May 2002 23:01:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314094AbSESDBk>; Sat, 18 May 2002 23:01:40 -0400
Date: Sat, 18 May 2002 20:01:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <E179GA4-0004ZT-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205181958140.30454-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 May 2002, Rusty Russell wrote:
>
> Huh?  No, you ask for 2000 bytes into a buffer that can only take 1000
> bytes without hitting an unmapped page, returning EFAULT or giving a
> SIGSEGV is perfectly acceptable.

Bzzt, wrong answer.

Partial reads/writes are perfectly possible and non-buggy for any system
that uses variations of mmap/mprotect to implement user-level memory
management, for example persistant data-bases, garbage collection etc.

Which means that if half of a buffer used for "read()" just happens to be
marked non-writable for some GC purpose, the kernel HAS to have the
ability return the right answer (which in this case is to say "I could
only read 1000 bytes"). Because anything else just doesn't give the GC
library (or whatever) any way to recover nicely.

> As a coder, I'd *really* prefer that to hiding the bug!

Rusty, face it, you're wrong on this one. Just drop it.

		Linus

