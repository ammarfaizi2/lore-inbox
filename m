Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSAMD7K>; Sat, 12 Jan 2002 22:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSAMD6v>; Sat, 12 Jan 2002 22:58:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23528 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287633AbSAMD6a>;
	Sat, 12 Jan 2002 22:58:30 -0500
Date: Sat, 12 Jan 2002 22:58:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020110231849.GA28945@kroah.com>
Message-ID: <Pine.GSO.4.21.0201122251240.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jan 2002, Greg KH wrote:

>   - klibc
>     Portability can be achieved through using the kernel unistd.h file
>     for the syscall logic, and having a very small _start function
>     written.  For an example of this kind of code, see the initramfs
>     patches from Al Viro on his ftp site:
> 	    ftp://ftp.math.psu.edu/pub/viro/
>     This would involve writing/porting a lot of the basic library
>     functions.  They could be copied from the existing libc
>     implementations, but this would be a separate project, requiring
>     maintenance over time, and people willing to do the work.

Note: said patches are against relatively old 2.4 trees.  They demonstrate
that quite a few things can be moved to userland, however it's mostly
proof-of-concept stuff.  In particular
	* in the final variant we let the loader to leave archive(s)
in core, rather than linking them into the kernel image.
	* nfsroot.c is *crap*
	* quite a few things are currently done better (modulo moving
init/do_mounts.c code in userland process).  IOW, reduction to syscalls
could be (and already is) done better than in these patches.

I'll put current version of that stuff for public testing, but that
will happen after the current mess with kdev_t/struct block_device *
will be resolved...

