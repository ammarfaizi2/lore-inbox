Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131516AbQLPIa1>; Sat, 16 Dec 2000 03:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbQLPIaR>; Sat, 16 Dec 2000 03:30:17 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:1288 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131516AbQLPIaJ>; Sat, 16 Dec 2000 03:30:09 -0500
Date: Fri, 15 Dec 2000 23:59:19 -0800 (PST)
From: ferret@phonewave.net
To: richard offer <offer@sgi.com>
cc: linux-kernel@vger.kernel.org, magenta@trikuare.cx
Subject: Re: What about 'kernel package'? was: Re: Linus's include file strategy redux
In-Reply-To: <1001215202538.ZM23045@sgi.com>
Message-ID: <Pine.LNX.3.96.1001215225813.20126A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, richard offer wrote:

> 
> * $ from ferret@phonewave.net at "15-Dec: 8:22pm" | sed "1,$s/^/* /"
> *
> *
> * Once again, I'd like to suggest Debian's kernel package system as a good
> * working example of this sort of administrative-level kernel management. I
> * brought this up on the list once before, maybe eight months ago, but I
> * recall not even one reply worth of discussion about it. I have a fairly
> * basic idea of what could be done to merge part of 'make-kpkg' into the
> * kernel-side management, but I'd like to see some other trained eyeballs
> * taking a look.
> 
> I'm not familiar with Debian at all.. do you have some pointers to information
> on make-kpkg ?

Off the top of my head:

* perl script (but this can be changed if we wanted to adopt it)
* Has build support for kernel 'flavours': 2.2.17-flavour
* Has build support for modules outside of the kernel tree: alsa and
  lm-sensors, and others
* Has support for cross-compiling the kernel and modules, by passing a
  single destination-archetecture paramater, with the support of an
  installed cross-compilation suite.

Has full support for building Debian packages (of course!):
* Kernel image
* Kernel headers: placed into /usr/src/kernel-headers-<version>
* Kernel source: placed into /usr/src/kernel-source-<version>
* External modules

The package build features could technically be seperated off into stubs
on the main package. but it seems Connectiva is working on merging Red
Hat's and Debian's packaging systems into something the LSB can adopt, if
I hear correctly.

Some of my ideas regarding the use of kernel-package with the main kernel
source:
* Simplifies the build of third-party modules AT KERNEL BUILD TIME:
  The sources go into /usr/src/modules/<package>
* Protects against the dreaded accidental overwriting of current kernel
  image and modules but is easily enough overridden: newbie or
  asleep-at-console protection.
* Could be easily hooked into local package management system.
* The current monolithic kernel tarball could be split up to take
  advantage of the modules build system, although the configuration
  scripts would have to be changed. This would have a liability that code
  outside the core kernel tree would be more difficult to compile into a
  kernel, but would benefit by allowing non-core components to be
  developed and released asynchronously. A non-core component would be
  anything not required for booting, basic networking, or console access.
  Examples: infrared, multimedia, and sound.

Areas in which the kernel-package system would need to be improved:
* Support for building new modules after kernel build time. This is a
  current issue which could be more easily solved in the framework of
  kernel-package.
* Support for calling an interactive configuration.
* Scripting support to run a user-defined sequence with a single command.




A typical build cycle on my build machine goes like:

# make-kpkg clean
# make menuconfig  (if I need to change or interactively verify my
		    options)
# make-kpkg --revision=<hostname>.<build #> configure
# make-kpkg modules-clean
# make-kpkg modules
# make-kpkg kernel-headers (which I usually skip for personal use)
# make-kpkg kernel-image

I end up with package files called something like:

kernel-image-2.4.0-test11_heathen.01_i386.deb
kernel-headers-2.4.0-test11_heathen.01_i386.deb
alsa-modules-2.4.0-test11_0.5.9d+heathen.01_i386.deb


Getting it:
* The package is called 'kernel-package', and you can download the source
  for it through www.debian.org
* The archives ARE undergoing reorganisation at this time, so if anyone
  has troubles I can place a copy onto my webserver.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
