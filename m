Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132551AbRDHNK4>; Sun, 8 Apr 2001 09:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132552AbRDHNKg>; Sun, 8 Apr 2001 09:10:36 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:36112 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132551AbRDHNKa>;
	Sun, 8 Apr 2001 09:10:30 -0400
Date: Sun, 8 Apr 2001 15:10:21 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christopher Turcksin <turcksin@raleigh.ibm.com>,
        "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to build modules outside the kernel tree? [Was: Proper way to release binary driver?]
Message-ID: <20010408151021.A15750@pcep-jamie.cern.ch>
In-Reply-To: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com> <m1g0fnwoo0.fsf@frodo.biederman.org> <3ACDE5C5.CEB65D4A@raleigh.ibm.com> <m1y9tdv6vt.fsf_-_@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1y9tdv6vt.fsf_-_@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Apr 06, 2001 at 07:24:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> So for solutions (That I know of):
> 
> With recent kernels with modules_install a:
>  /lib/modules/`uname -r`/build
> directory is created, that effectively points to the kernel source
> tree the modules were built with.  With the 2.4.x currently this is a
> symlink so but it should be o.k.  It needs to be checked that the
> distributors are using this directory appropriately, but it looks like
> a good thing to support.  Longterm this looks like a solution
> to the problem, of how to get kernel headers to match a kernel.  
> 
> This should even has a chance to work with people who build their own
> kernel.
> 
> With Redhat and many derivatives as a fallback there is kernel source in 
> /usr/src/linux that does it's best to match the currently running
> kernel.
> 
> Using either of those locations for the source to kernel headers it
> should be possible to build a package that as part of it's install
> process compiles appropriate drivers, at least for most of the cases.
> 
> I suspect there is enough work in this for someone to create a support
> package, that included makefiles and all the rest to assist in
> building a drivers on various platforms.  Any takers?

I have done exactly this, which I've used for a few device drivers.  The
Makefile can usually find the kernel source tree for the running kernel
by looking in the sensible places, it knows where to install modules,
and it is even able to get the right $(CFLAGS) from a configured kernel
tree.

The package includes a "compat.h", which rather like other similar files
("kcompat24.h") provides a 2.4-series API that works with all kernels
going back to 2.0, on all platforms I hope.  (I grepped the patches to
find out when each API change that I'm interested in occurred).  This
doesn't include network driver API though, just your basic PCI search
and read/write/ioctl/mmap/get_user interfaces.

The nice result is that, from a single source .tar.gz, "make" builds and
installs a driver module written with (more or less) the 2.4 API on any
kernel from 2.0 to 2.4, and the driver source is not full of ifdefs.

I suppose you're wondering where to get these files.  Mail me and I'll
see if there's much demand.

cheers,
-- Jamie
