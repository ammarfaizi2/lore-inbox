Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288296AbSAHUh4>; Tue, 8 Jan 2002 15:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288297AbSAHUhh>; Tue, 8 Jan 2002 15:37:37 -0500
Received: from codepoet.org ([166.70.14.212]:6665 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288296AbSAHUhb>;
	Tue, 8 Jan 2002 15:37:31 -0500
Date: Tue, 8 Jan 2002 13:37:30 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020108203730.GA31371@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020108192450.GA14734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108192450.GA14734@kroah.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 08, 2002 at 11:24:50AM -0800, Greg KH wrote:
> 	- portable, runs on all platforms that the kernel currently
> 	  works on, but doesn't have to run on any non-Linux based OS.

uClibc currently only runs on arm, i386, m68k, mips, powerpc, sh,
and v850, with full shared lib support on arm, i386, and powerpc.
Porting to a new arch typically involves writing just a few asm
files.  I don't bother with anything non-Linux...

> 	- tiny.  If we link statically it should be _small_.  Both
> 	  dietLibc and uClibc are good examples of the size goal.  We do
> 	  not need to support all of POSIX here, only what we really
> 	  need.

uClibc does tiny static stuff just fine.  Though these days,
uClibc passes POSIX conformance tests (with some exceptions for
stupid things which have been omitted).

> 	- If we end up having a lot of different programs in initramfs,
> 	  a dynamic version of the library should be available.  This
> 	  shared library should be _small_ and only contain the symbols
> 	  that are needed by the programs to run.  This should be able
> 	  to be determined at build time.

uClibc currently has shared lib support only on arm, i386, and powerpc.
There is a library reducer script (to include only needed
symbols) in uClibc/extra/libstrip/libstrip which does a fine job.

I personally think busybox + uClibc are ideal for building
initramfs stuff, since you can build everything you need into 
a single multi-call binary (eliminating the need for shared libs
in most cases).

> 	- It has to "not suck" :)  This is a lovely relative feeling
> 	  about the quality of the code base, ease at building the
> 	  library, ease at understanding the code, and responsiveness of
> 	  the developers of the library.

Well, I do my best.  :)

As for ease of building the library, most people can just copy
the Config file into place and compile.  I build a fake
gcc-wrapper toolchain, so using the library is as simple as 
'make install' then running 'CC=/usr/i386-linux-uclibc/bin/gcc make'

I think one big advantage uClibc has in the "not suck"
department, is that it uses the header files from glibc 2.2.4
(with minor changes), meaning that for most apps, if it compiles
with glibc it will compile with uClibc.

> response.  Hence my post.  I would love to work with the authors of an
> existing libc to build such a library, as I have other things I would
> rather work on than a libc :)

Ok.  here I am.   Work with me.  :) 

> Comments from the various libc authors?  Comments from other kernel
> developers about requirements and goals they would like to see from such
> a libc?

If folks have requirements and goals, I'm very interested in
hearing them...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
