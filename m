Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160512AbQHBR6X>; Wed, 2 Aug 2000 13:58:23 -0400
Received: by vger.rutgers.edu id <S160474AbQHBR5E>; Wed, 2 Aug 2000 13:57:04 -0400
Received: from emu.prod.itd.earthlink.net ([207.217.121.31]:57383 "EHLO emu.prod.itd.earthlink.net") by vger.rutgers.edu with ESMTP id <S160533AbQHBRz6>; Wed, 2 Aug 2000 13:55:58 -0400
Message-ID: <39886579.9982E8BD@pobox.com>
Date: Wed, 02 Aug 2000 11:16:25 -0700
From: peter swain <swine@pobox.com>
Reply-To: swine@pobox.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en-US, en, es, de
MIME-Version: 1.0
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
References: <200007271459.KAA04701@tsx-prime.MIT.EDU> <200007271531.KAA89926@tomcat.admin.navo.hpc.mil> <7iw6kYsXw-B@khms.westfalen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)  wrote:
> > That way the "uname -r" command could be used to set a symbolic link
> > to point to the correct include files at boot time (or install time).

Kai Henningsen wrote:
> Correct for what?

correct for building kernel modules for /lib/include/$KERNEL_VER.
that's how i've used /lib/include for some time,
when needing to generate oodles of different versions of a kernel
module under active development, without necessarily having oodles of
/usr/src/linux-$KERNEL_VER trees.

i just propagate /boot/*$KERNEL_VER* and
/lib/{modules,include}/$KERNEL_VER as one tarball fully describing the
environment, to anything i'm even thinking of building on.

i do admit to maintaining boot-time /usr/include/{linux,asm} --->
/lib/include/$(uname -r)/{linux,asm} symlinks to get a consistent
usermode include tree, but it's always worried me.
The interesting parts of /usr/include are always the bleeding 
edge which *hasn't* made it into glibc-blessed namespace yet.

I'm hoping some clear methodology will arise out of this bickering which
will allow stable apps to build against a static tree, with
gcc-bleeding-edge resorted to as a fallback.
[exec gcc -I/lib/include/${KERNEL_VER:-$(uname -r)} "$@"]
Ideally, binaries produced in this way would be tagged with their
dependance on version>=xx.yy.zz obvious, so they're not confused
with the stable builds, and can be ported to glibc-blessed-namespace
when new features propagate there.



^..^
(oo)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
