Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVJBXQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVJBXQW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVJBXQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:16:22 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:22029 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751075AbVJBXQW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:16:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HyQ7nqtaC4qrURnxWGi+u/VWMH2W/LGvUaNFSM7WTFKC6R1xLKvYLYCJ14pUUrY0P4mX/woPzh7Ic3MIj0j1gDpN95j9yTlpZ6rSZQXKWSUkOrprVZ7xvkPe4GGQUrHUa47L1nOQlS2c6c1WZTuHmo43fqnLOHiDlFNVer5v8w4=
Message-ID: <9a8748490510021616h64aa355ch1da95a3bb0b2d839@mail.gmail.com>
Date: Mon, 3 Oct 2005 01:16:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Kernel Enthusiast <kernel@clones.net>
Subject: Re: LVM Compilation error on 2.6.13.2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.61.0510012327430.451@resurrection.clones.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.NEB.4.61.0510012327430.451@resurrection.clones.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, Kernel Enthusiast <kernel@clones.net> wrote:
> I ran into a problem building LVM on a new 2.6.13.2 kernel I built
> yesterday.   I built the kernel on an older Mandrake 8 system after
> updating to the latest gnu binutils.  It's very fast... much faster than
> my previous 2.4 kernel.  I have no complaints about performance.
> I was able to build the kernel with the stock gcc-2.96. Disk access is
> much quieter than with previous kernels.
>
> I'm not sure if this problem was due to a kernel customization error, but
> I got the error "BLKBSZGET undefined (first use this function)" in
> LVM2.2.0.14/lib/device/dev-io.c.  I added the following definition to the
> LVM code in order to enable LVM to compile:
>
> #define BLKBSZGET _IO(0x12,104)
>
> after the #INCLUDE statements in dev-io.c and then LVM 2.2.0.14 compiled
> without errors.
>
> My question is this:   Was the above problem due to a non-standard kernel
> config file, i.e. a kernel lacking support for BLKBSZGET? Or is gcc-2.96
> too old, or a bad version?  This fix feels like a kludge and before I

A small qoute from Documentation/Changes :

"
Kernel compilation
==================

GCC
---

The gcc version requirements may vary depending on the type of CPU in your
computer. The next paragraph applies to users of x86 CPUs, but not
necessarily to users of other CPUs. Users of other CPUs should obtain
information about their gcc version requirements from another source.

The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
should be used when you need absolute stability. You may use gcc 3.0.x
instead if you wish, although it may cause problems. Later versions of gcc
have not received much testing for Linux kernel compilation, and there are
almost certainly bugs (mainly, but not exclusively, in the kernel) that
will need to be fixed in order to use these compilers. In any case, using
pgcc instead of plain gcc is just asking for trouble.

The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
the kernel correctly.

In addition, please pay attention to compiler optimization.  Anything
greater than -O2 may not be wise.  Similarly, if you choose to use gcc-2.95.x
or derivatives, be sure not to use -fstrict-aliasing (which, depending on
your version of gcc 2.95.x, may necessitate using -fno-strict-aliasing).
"

> configure LVM, I would like to make sure I didn't cause a problem for myself
> by adding the above definition to the LVM source code.
> I don't want to hard-code a definition in the LVM sources if the same
> parameter is supposed to be defined in my environment elsewhere.
>
> From a theoretical standpoint, I am hoping it will not matter, but if anyone
> on the list is familiar with BLKBSZGET and knows whether it is supposed to be
> a kernel function, I would be delighted to hear your thoughts on the matter.

The BLKBSZGET macro is defined in the kernel in include/linux/fs.h :
   fs/compat_ioctl.c:1879:#define BLKBSZGET_32   _IOR(0x12,112,int)

The _IOR macro is defined in include/asm-<arch>/ioctl.h
   include/asm-i386/ioctl.h:64:#define _IOR(type,nr,size) 
_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))

_IOC, _IOC_READ and _IOC_TYPECHECK are defined in include/asm-<arch>/ioctl.h


May I recommend to you the excellent tool `grep` as well at the Linux
Cross Reference source browser at
http://sosdg.org/~coywolf/lxr/source/


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
