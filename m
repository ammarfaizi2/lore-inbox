Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbRESIaf>; Sat, 19 May 2001 04:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbRESIa0>; Sat, 19 May 2001 04:30:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47079 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261700AbRESIaL>;
	Sat, 19 May 2001 04:30:11 -0400
Date: Sat, 19 May 2001 04:30:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Clausen <clausen@gnu.org>
cc: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <3B061F63.194BAF63@gnu.org>
Message-ID: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Andrew Clausen wrote:

> Alexander Viro wrote:
> > On Sat, 19 May 2001, Andrew Clausen wrote:
> > 
> > > (1) these issues are independent.  The partition parsing could
> > > be done in user space, today, by blkpg, if I read the code correctly
> > > ;-)  (there's an ioctl for [un]registering partitions)  Never
> > > tried it though ;-)
> > 
> > ioctls are even more evil than encoding limits into the name.
> 
> Why?  Encoding sounds funky... you don't get normal
> ls behaviour, etc.

ioctls are evil, period. At least with these names you can use normal
scripting and don't need any special tools. Every ioctl means a binary
that has no business to exist.

> What about partition editing on other OSs?  There's no reason
> why fdisk/parted/etc. should be Linux only.  Why should the kernel
> need to know how to write partition tables?

It needs to read them. Writing doesn't add much. I'd rather see
trivial partitioning tools that consist only of UI code in case
of Linux.

> Also, different partition table formats have different alignment
> constraints (which is relevant for creating partitions).  These
> mainly need to be respected for other braindead OS's and/or BIOSes.
> 
> Communicating those between user/kernel space doesn't excite me.

So don't communicate them.
 
> Libtool & friends deals with version skew (ugly, but it works...)

With statically linked binaries? How?
 
> You can write wrappers for libraries.

Uh-huh. And you can write them for ioctls. We had been busily doing that
for years. Results are not pretty, to put it very mildly.

OK, let me put it that way: I know how to do it in the kernel with
no code duplication and less impact on userland. BTW, most of the
code can very well sit in the userland, but that's another story
(userland filesystems). Anyway, there's only one way to settle such
stuff - sit down and write the patch. Which is what I'm going to do.

