Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSERBXx>; Fri, 17 May 2002 21:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316742AbSERBXw>; Fri, 17 May 2002 21:23:52 -0400
Received: from slip-202-135-75-205.ca.au.prserv.net ([202.135.75.205]:48265
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316739AbSERBXw>; Fri, 17 May 2002 21:23:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Fri, 17 May 2002 15:52:20 +0100."
             <E178j5g-0006en-00@the-village.bc.nu> 
Date: Sat, 18 May 2002 11:26:48 +1000
Message-Id: <E178t00-0006e2-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E178j5g-0006en-00@the-village.bc.nu> you write:
> > We could do that, or, we could fix the actual problem, which is the
> > HUGE FUCKING BEARTRAP WHICH CATCHES EVERY SINGLE NEW PROGRAMMER ON THE
> > WAY THROUGH.
> 
> Capital letters versus content. I'd prefer content

1) Returning 0 on success, and -errno on error is a common kernel
   convention.

2) Following kernel conventions makes it easier for other programmers
   to use your code.

3) You should only violate kernel conventions when there is a
   compelling reason.

	1a) If you're going to break a convention, do it in a way that
	    breaks compile, or 
	1b) If you can't do that, make it reliably break at runtime.

4) The single case which requires this information can be fixed by a
   simple 10-line wrapper function.

I do not believe this is a compelling reason to violate kernel
convention in a way which is almost impossible to notice.  I furthur
believe that it speaks very poorly about the thought put into kernel
interface design.

> All the cases I looked at where replications of existing bugs copied from
> old drivers.

Try looking at intermezzo, or the s390 and s390x ports.  New code, new
coders, same trap.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
