Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbTCGJcG>; Fri, 7 Mar 2003 04:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbTCGJcG>; Fri, 7 Mar 2003 04:32:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56332 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261454AbTCGJcF>; Fri, 7 Mar 2003 04:32:05 -0500
Date: Fri, 7 Mar 2003 09:42:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Chris Dukes <pakrat@www.uk.linux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030307094235.A11807@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Dukes <pakrat@www.uk.linux.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <20030307000816.P838@flint.arm.linux.org.uk> <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk>; from pakrat@www.uk.linux.org on Fri, Mar 07, 2003 at 01:29:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 01:29:05AM +0000, Chris Dukes wrote:
> If IBM can fit a kernel and a ramdisk containing all the utilities you
> describe and more in smaller than 5M of file for tftp, one would think 
> that it could be done on Linux.

Wow.  5MB eh?  We currently do NFS-root in 690K.

> > ipconfig.c does more than just configure networking.  It's a far smaller
> > solution to NFS-root than any userspace implementation could ever hope
> > to be.
> 
> That's nice.  Would you mind explaining to us where that would be a
> benefit?  Aside from dead header space in elf executables, I'm at
> a loss as to how a usermode implementation must be significantly
> larger than kernel code.

If you're suggesting above that "5MB isn't significantly larger than
the size Linux can do this" then I think I've just proven you wrong.

Lets see - building an ramdisk to mount a root filesystem out of existing
binaries would require from my exisitng systems probably something like:

   text    data     bss     dec     hex filename
1093047   21224   15560 1129831  113d67 /lib/libc.so.6
 515890   22320   16640  554850   87762 /bin/sh
  58540    2436    9776   70752   11460 /lib/libresolv.so.2
  53685    1476    5488   60649    ece9 /bin/mount
  45511     672     432   46615    b617 /bin/sed
  42830     624      40   43494    a9e6 /sbin/pump
  10783     500     104   11387    2c7b /lib/libtermcap.so.2
   8765     444      28    9237    2415 /lib/libdl.so.2

pump isn't really suitable for the task, but I don't have dhcpcd around.
dhcpcd is even larger than pump however.

That's getting on for 2MB vs:

   2620    2012       0    4632    1218 fs/nfs/nfsroot.o
   8016     380      80    8476    211c net/ipv4/ipconfig.o

about 13K.

Which version is overly bloated?
Which version is huge?
Which version is compact?

Even the klibc ipconfig version is significantly larger than the in-kernel
version - and klibc and its binaries are written to be small.



Note: I *do* agree that ipconfig.c needs to die before 2.6 but I do not
agree that today is the right day.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

