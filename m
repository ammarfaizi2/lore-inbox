Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSEPC63>; Wed, 15 May 2002 22:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316549AbSEPC62>; Wed, 15 May 2002 22:58:28 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14162 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316548AbSEPC62>; Wed, 15 May 2002 22:58:28 -0400
Date: Thu, 16 May 2002 04:58:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516025825.GG1025@dualathlon.random>
In-Reply-To: <20020516023238.GE1025@dualathlon.random> <Pine.LNX.4.44L.0205152340250.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 11:42:24PM -0300, Rik van Riel wrote:
> On Thu, 16 May 2002, Andrea Arcangeli wrote:
> 
> > I'm not using the full blown initrd of most distros that is aware of the
> 
> Then I guess we found the problem. ;)

disagreement, my initrd is not the problem. the kernel code is really
explicit about what it will do with the real root fs, it will mount it
by itself, I am definitely not required to mount it by myself within
linuxrc, for sure not to workaround a bug in the kernel, and now in
2.4.19pre mounting it in linuxrc is even worse idea because the mount
will likely fail at the first different mount option. linuxrc is allowed
to just run exit(2) and the real root fs must still be mouned correctly,
that is the linuxrc API.

> 
> > > --- snip from linuxrc ----
> > > mount --ro -t $rootfs $rootdev /sysroot
> > > pivot_root /sysroot /sysroot/initrd
> > > ------
> 
> > both lines are completly superflous, very misleading as well. I
> > recommend to drop such two lines from all the full blown bug-aware
> > linuxrc out there (of course after you apply the ordering fix to the
> > kernel).
> 
> Personally I hope the special initrd code gets moved from
> kernelspace into userspace.

I don't care about this part, if it gets changed I will update my
initscripts to act accordingly, however requiring all linux users to
update their init scripts in mid/late 2.4 is probably not a good idea,
if you really want to drop such two lines then do it in 2.5 only (not
recommended, still it's a gratuitous API change IMHO).

Andrea
