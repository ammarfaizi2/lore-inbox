Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263332AbSJJK1b>; Thu, 10 Oct 2002 06:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSJJK1b>; Thu, 10 Oct 2002 06:27:31 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:39176 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S263332AbSJJK1a>; Thu, 10 Oct 2002 06:27:30 -0400
Date: Thu, 10 Oct 2002 12:33:07 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <Pine.LNX.4.44L.0210092045195.22735-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0210101207140.26363-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Rik van Riel wrote:

> On Wed, 9 Oct 2002, Andreas Dilger wrote:
> > On Oct 09, 2002  10:14 -0400, Robert Love wrote:
> > > On Wed, 2002-10-09 at 10:10, Marco Colombo wrote:
> > >
> > > > >  #define O_NOFOLLOW	0400000 /* don't follow links */
> > > > >  #define O_NOFOLLOW	0x20000	/* don't follow links */
> > >
> > > No need.  See for example O_NOFOLLOW right above.  Each architecture can
> > > do has it pleases (I wish otherwise, but...).
> >
> > I would say - if you are picking a new flag that doesn't need to have
> > compatibility with any platform-specific existing flag, simply set them
> > all high enough so that they are the same on all platforms.
> 
> Doesn't really matter, you can't run x86 binaries on MIPS so
> you need to recompile anyway.
> 
> Source level compatibility is enough for flags like this.
> 
> regards,
> 
> Rik
> 

True, but either you include kernel headers from user apps, or wait for
glibc (or [whatever]libc) to catch up, or do something like this:

	#define O_STREAMING 04000000

	fd = open(file, ... | O_STREAMING);

(quoted directly from one of Robert's messages).

The latter is broken on MIPS, and requiring either glibc headers or the
programmer to handle different archs is unfortunate. One of the biggest
advantages of O_STREAMING is that is it's simple and elegant to integrate
it into existing apps: let's make it even easier by choosing the same
value, so that the above C is the right thing.

Besides, not all the world is C. I don't expect, say, Perl or Python to
support Linux O_STREAMING on their POSIX modules. Perl does pass flags to
open(2) untouched (I haven't tested Python yet), but right now I have to:
- wait for an official Perl update that supports O_STREAMING;
- test explicitly for different archs in my perl program in order
  to choose the right O_STREAMING value (or hack system modules to do
  the same);
- forget about portability on my Perl script (which is somewhat worse than
  doing that same for a C program: one of the goals of using Perl *is*
  portability).

Note that having different O_NOFOLLOW (or even O_CREAT) values is less
annoying, since I expect any language that allows me to pass flags to
open(2) (or fcntl(2)) to define those as macros (constants, subroutines
or whatever).

In the end, I see we can choose different values, but why should we?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

