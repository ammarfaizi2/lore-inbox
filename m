Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263674AbRFDAYc>; Sun, 3 Jun 2001 20:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRFDAGP>; Sun, 3 Jun 2001 20:06:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263717AbRFCXzH>; Sun, 3 Jun 2001 19:55:07 -0400
Date: Sun, 3 Jun 2001 16:55:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Akash Jain <aki.jain@stanford.edu>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, su.class.cs99q@nntp.stanford.edu
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <200105271321.f4RDLoM00342@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 May 2001, Richard Gooch wrote:
> 
> I absolutely don't want this patch applied. It's bogus. It is entirely
> safe to alloc 1 kB on the stack in this code, since it has a short and
> well-controlled code path from syscall entry to the function.

IT IS NEVER EVER SAFE TO ALLOCATE 1kB OF STACK!

Why?
 - automatic checkers are wonderful, and we do not want to have "oh, in
   this case it is magically ok" kinds of things.
 - the kernel stack is 4kB, and _nobody_ has the right to eat up a
   noticeable portion of it. It doesn't matter if you "know" your caller
   or not: you do not know what interrupts happen during this time, and
   how much stack they want.

Ergo: the simple rule of "don't allocate big structures of the stack" is
always a good rule, and making excuses for it is bad.

		Linus

