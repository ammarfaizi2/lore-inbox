Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSEDN6D>; Sat, 4 May 2002 09:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312998AbSEDN6C>; Sat, 4 May 2002 09:58:02 -0400
Received: from pool-151-201-37-99.pitt.east.verizon.net ([151.201.37.99]:64140
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S312983AbSEDN6B>; Sat, 4 May 2002 09:58:01 -0400
Date: Sat, 4 May 2002 09:58:16 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020504095815.Q30294@marta>
Mail-Followup-To: Kurt Wall <kwall>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0205021738410.17171-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0205031554180.10456-100000@mhw.ULib.IUPUI.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scribbling feverishly on May 03, Mark H. Wood managed to emit:
> On Thu, 2 May 2002, Alexander Viro wrote:
> [quote snipped]
> > Sigh...  Configurations with /usr/include/{linux,asm} being symlinks
> > are BROKEN.  Please, look through the archives - it had been discussed
> > a lot of times.  Userland has no business using kernel headers directly
> > and that's precisely what had bitten you - setup where /usr/include/asm
> > comes not from libc but from the (currently being built) kernel.
> 
> There is a reason that this issue keesp rising from the grave.  I just
> downloaded the glibc 2.2.5 source tarball and in INSTALL I find
> this:

Indeed.

> [begin quote]
> Specific advice for Linux systems
> =================================
> 
>    If you are installing GNU libc on a Linux system, you need to have
> the header files from a 2.2 kernel around for reference.  You do not
> need to use the 2.2 kernel, just have its headers where glibc can access
> at them.  The easiest way to do this is to unpack it in a directory
> such as `/usr/src/linux-2.2.1'.  In that directory, run `make config'
> and accept all the defaults.  Then run `make include/linux/version.h'.
> Finally, configure glibc with the option
> `--with-headers=/usr/src/linux-2.2.1/include'.  Use the most recent
> kernel you can get your hands on.

I've had no trouble (or, no *known* trouble) building glibc against
the current (2.4.18) kernel headers. So, are references to the 2.2 kernel
in glibc's INSTALL document out of date in this respect? "Use the most
recent kernel you can get your hands on." suggests this is the case.

>    An alternate tactic is to unpack the 2.2 kernel and run `make
> config' as above.  Then rename or delete `/usr/include', create a new
> `/usr/include', and make the usual symbolic links of
> `/usr/include/linux' and `/usr/include/asm' into the 2.2 kernel
> sources.  You can then configure glibc with no special options.  This
> tactic is recommended if you are upgrading from libc5, since you need
> to get rid of the old header files anyway.
> 
>    Note that `/usr/include/net' and `/usr/include/scsi' should *not* be
> symlinks into the kernel sources.  GNU libc provides its own versions
> of these files.
> [end quote]
> 
> Note the bit about "usual symbolic links...into the...kernel sources".

What, then, is the best way to proceed? Build and install glibc,
copy $KERNELSRC/include/asm to /usr/include/asm and
$KERNELSRC/include/linux to /usr/include/linux?

Kurt
-- 
Happiness, n.:
	An agreeable sensation arising from contemplating the misery of
another.
		-- Ambrose Bierce, "The Devil's Dictionary"
