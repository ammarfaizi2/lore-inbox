Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285400AbRLGDxa>; Thu, 6 Dec 2001 22:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285398AbRLGDxW>; Thu, 6 Dec 2001 22:53:22 -0500
Received: from zok.sgi.com ([204.94.215.101]:43166 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S282707AbRLGDxF>;
	Thu, 6 Dec 2001 22:53:05 -0500
Date: Fri, 7 Dec 2001 14:51:31 +1100
From: Nathan Scott <nathans@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011207145131.B54252@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <E16C0PD-0000ot-00@starship.berlin> <20011207101517.B46546@wobbly.melbourne.sgi.com> <E16CAMb-0000s1-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16CAMb-0000s1-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Dec 07, 2001 at 03:03:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Daniel,

On Fri, Dec 07, 2001 at 03:03:43AM +0100, Daniel Phillips wrote:
> On December 7, 2001 12:15 am, Nathan Scott wrote:
> > > > [extended attributes on symlinks]
> > >   get, fget, set, fset, del, fdel, list, flist
> > 
> > I'm not too fussed - the second draft patch I sent out did exactly
> > as you describe, in an attempt to cut down on syscalls.  This again
> > meant adding a "flags" field to each operation.  We also have stat/
> > lstat/fstat and chown/lchown/fchown - I was trying to be consistent
> > with those, and I still think that is the right thing to do.
> 
> It may well be, however, the one call that has flags, set, is looking a 
> little irregular sitting there on its own.

Not sure what to say to that ... the API is practical, flags
seem to make sense for that call (the flags give the slightly
different "set" semantics, but it is still "set"), IMO they
don't make sense for others.

> We're inventing an API here for which we don't have a lot of guidance from 
> existing unices, correct?

No.  Many existing versions of Unix support extended attributes
in some form or another, but there is no common API/standard -
each implementation differs, sometimes radically, to the others.

> It wouldn't hurt to really kick it around.

Please read the archives first - discussion started well over a
year ago now on an API for Linux, and there have been heaps and
heaps of ideas, proposals, prototypes, etc, floated.

The lack of progress on getting something in the kernel is
hurting several projects (even having syscalls reserved would
be a _huge_ help to us).  We have distributors telling us they
would include XFS in their kernels if there was some progress
on this particular issue.

> After all, what we settle on in Linux is likely to become the standard.

Mmm.. I seriously doubt there could ever be any standards in this
area - I would be satisfied with a good implementation on Linux,
which allows filesystems from different operating systems to use
it while preserving any existing on-disk formats they may have.

> 
> Presumably there's some existing practice at SGI, do you have a pointer to 
> man pages?
> 

Start with the mail we sent to Linus, LKML, fs-devel, etc about a
month ago - it had pointers to the original discussion from this
time last year (and in that discussion, Andreas provided pointers
to documentation for several other implementations, incl. BSD,
IRIX, Tru64, & others).  It also has pointers to several projects
relying on the existing, diverging Linux implementations.

It should probably be pointed out again that many of the folk
working on filesystems which support extended attributes have
given their collective thumbs up to the latest round of patches.
In particular, the projects which have already implemented EAs
(XFS, ext2/ext3) and services above EAs, are confident that
these patches will work for them and that we'll be able to get
our userspace code working together for the first time.

cheers.

-- 
Nathan
