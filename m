Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSESD3L>; Sat, 18 May 2002 23:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSESD3K>; Sat, 18 May 2002 23:29:10 -0400
Received: from slip-202-135-75-36.ca.au.prserv.net ([202.135.75.36]:395 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314078AbSESD3K>; Sat, 18 May 2002 23:29:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Sat, 18 May 2002 20:01:48 MST."
             <Pine.LNX.4.44.0205181958140.30454-100000@home.transmeta.com> 
Date: Sun, 19 May 2002 13:31:55 +1000
Message-Id: <E179HQd-0000j7-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205181958140.30454-100000@home.transmeta.com> you wr
ite:
> 
> 
> On Sun, 19 May 2002, Rusty Russell wrote:
> >
> > Huh?  No, you ask for 2000 bytes into a buffer that can only take 1000
> > bytes without hitting an unmapped page, returning EFAULT or giving a
> > SIGSEGV is perfectly acceptable.
> 
> Bzzt, wrong answer.
> 
> Partial reads/writes are perfectly possible and non-buggy for any system
> that uses variations of mmap/mprotect to implement user-level memory
> management, for example persistant data-bases, garbage collection etc.
> 
> Which means that if half of a buffer used for "read()" just happens to be
> marked non-writable for some GC purpose, the kernel HAS to have the
> ability return the right answer (which in this case is to say "I could
> only read 1000 bytes"). Because anything else just doesn't give the GC
> library (or whatever) any way to recover nicely.

Um, what about delivering a SIGSEGV?  So, copy_to/from_user always
returns 0, but a signal is delivered.  Then the only places which need
to be clever are the mount option copying, and the signal delivery
code for SIGSEGV (which uses copy_to_user).

This has the benefit of not breaking existing kernel code, whichever
interpretation of the return value is used.

> > As a coder, I'd *really* prefer that to hiding the bug!
> 
> Rusty, face it, you're wrong on this one. Just drop it.

That's certainly possible,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
