Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSESD6o>; Sat, 18 May 2002 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSESD6n>; Sat, 18 May 2002 23:58:43 -0400
Received: from slip-202-135-75-36.ca.au.prserv.net ([202.135.75.36]:6027 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314085AbSESD6m>; Sat, 18 May 2002 23:58:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Sat, 18 May 2002 20:05:40 MST."
             <20020518200540.N8794@work.bitmover.com> 
Date: Sun, 19 May 2002 14:01:25 +1000
Message-Id: <E179HtC-0001cB-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020518200540.N8794@work.bitmover.com> you write:
> On Sat, May 18, 2002 at 08:01:48PM -0700, Linus Torvalds wrote:
> > On Sun, 19 May 2002, Rusty Russell wrote:
> > >
> > > Huh?  No, you ask for 2000 bytes into a buffer that can only take 1000
> > > bytes without hitting an unmapped page, returning EFAULT or giving a
> > > SIGSEGV is perfectly acceptable.
> > 
> > Bzzt, wrong answer.
> 
> Linus is absolutely right.  The correct semantics are to return the number
> of bytes read, if they are greater than zero, and on the next read return
> the error.  This has been a corner case in read for a long time in various
> Unix versions, and Linus has it right.  I went through this back at Sun
> and we explored all the different ways, and the bottom line is that you
> first ACK that you moved some data and then you NAK on the next read.

It's interesting to look at this backwards:

	Imagine if copy_to_user returned void and delivered a SIGSEGV
	on fault, and always had.

	Now, to fix this, we'd want to add new code paths to the 5,500
	callers throughout the kernel.

I'm pretty sure everyone would balk.  They'd say "sorry, you're going
to have to wrap your syscalls somehow".

But as we all know, it is harder to remove a feature from Linux, than
to get the camel book through the eye of a needle (or something).

Oh well,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
