Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWFBVjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWFBVjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWFBVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:39:16 -0400
Received: from a34-mta02.direcpc.com ([66.82.4.91]:733 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1030301AbWFBVjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:39:15 -0400
Date: Fri, 02 Jun 2006 17:38:36 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: [Updated v3]: How to become a kernel driver maintainer
In-reply-to: <9a8748490603081127r1b830c5bg94f42e021e2a2d58@mail.gmail.com>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <1149284317.4533.312.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: multipart/mixed; boundary="Boundary_(ID_p3TJaRZ9NNLfjjvGrlDwWw)"
References: <1136736455.24378.3.camel@grayson>
 <1136756756.1043.20.camel@grayson>
 <1136792769.2936.13.camel@laptopd505.fenrus.org>
 <1136813649.1043.30.camel@grayson>
 <1136842100.2936.34.camel@laptopd505.fenrus.org>
 <1141841013.24202.194.camel@grayson>
 <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
 <1141845047.12175.7.camel@laptopd505.fenrus.org>
 <9a8748490603081127r1b830c5bg94f42e021e2a2d58@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_p3TJaRZ9NNLfjjvGrlDwWw)
Content-type: text/plain
Content-transfer-encoding: 7BIT

This got back-burnered for awhile, but here's the fixed up copy from the
last round of feedback. Thanks to everyone that's given input. It's all
been helpful and I think this copy reflects everything that was
discussed last time.

If there's no major changes requested, the next time will be in diff
format for Documentation/ inclusion.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

--Boundary_(ID_p3TJaRZ9NNLfjjvGrlDwWw)
Content-type: text/plain; name=HOWTO-Become-a-Kernel-Driver-Maintainer.txt;
 charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: attachment;
 filename=HOWTO-Become-a-Kernel-Driver-Maintainer.txt

                How to become a kernel driver maintainer
                ----------------------------------------


This document explains what you must know before becoming the maintainer
of a portion of the Linux kernel. Please read SubmittingPatches,
SubmittingDrivers and CodingStyle, also in the Documentation/ directory.

With the large amount of hardware available for Linux, it's becoming
increasingly common for drivers for new or rare hardware to be maintained
outside of the main kernel tree. Usually these drivers end up in the
kernel tree once they are stable, but many times users and distribution
maintainers are left with collecting these external drivers in order to
support the required hardware.

The purpose of this document is to provide information for the authors of
these drivers to eventually have their code in the mainline kernel tree.


Why should I submit my driver?
------------------------------

This is often the question a driver maintainer is faced with. Most driver
authors really don't see the benefit of having their code in the main
kernel. Some even see it as giving up control of their code. This is
simply not the case, and the end result is always beneficial to users and
developers alike.

The primary benefit is availability. When people want to compile a kernel,
they want to have everything there in the kernel tree. No one (not even
kernel developers) likes having to search for, download, and build
external drivers out-of-tree (outside the stock kernel source). It's often
difficult to find the right driver (one known to work correctly), and is
even harder to find one that works on the kernel version they are
building.

The benefit to users compiling their own kernel is immense. The benefit to
distributions is even greater. Linux distributions already have a large
amount of work to provide a kernel that works for most users. If a driver
has to be provided for users that isn't in the primary kernel source, it
adds additional work to maintaining (tracking the external driver,
patching it into the build system, often times fixing build problems).
With a driver in the kernel source, it's as simple as tracking the main
kernel tree.

This assumes that the distribution finds your driver worth the time of
doing all this. If they don't, then the few users needing your driver will
probably never get it (since most users are not capable of compiling their
own modules).

Another benefit of having the driver in the kernel tree is to promote the
hardware that it supports. Many companies that have written drivers for
their hardware to run under Linux have not yet taken the leap to placing
the driver in the main kernel. The "Old Way" of providing downloadable
drivers doesn't work as well for Linux, since it's almost impossible to
provide pre-compiled versions for any given system. Having the driver in
the kernel tree means it will always be available. It also means that
users wishing to purchase hardware that "Just Works" with Linux will have
more options. A well-written and stable driver is a good reason for a user
to choose that particular type of hardware.

Having drivers in the main kernel tree benefits everyone.


What should I do to prepare for code submission?
------------------------------------------------

First you need to inspect your code and make sure it meets criteria for
inclusion. Read Documentation/CodingStyle for help on proper coding format
(indentation, comment style, etc). It is strongly suggested that your
driver builds cleanly when checked by the "sparse" tool. You will probably
need to annotate the driver so sparse can tell that it is following the
kernel's rules for address space accesses and endianness.  Adding these
annotations is a simple, but time-consuming, operation that often exposes
real portability problems in drivers.

There are also many targets in the kernel build system (KBuild) that will
help check your code as well. These targets are listed if you type "make
help" in the kernel tree. Some targets of note are, checkstack,
buildcheck and namespacecheck. You can also add C=1 to the make arguments,
in order to use the sparse tool for checking your code.

Once you have properly formatted the code, you also need to check a few
other areas. Most drivers include backward compatibility for older kernels
(usually ifdef's with LINUX_VERSION_CODE). This backward compatibility
needs to be removed. It's considered a waste of code for the driver to be
backward compatible within the kernel source tree, since it is going to be
compiled with a known version of the kernel.

Proper location in the kernel source needs to be determined. Find drivers
similar to yours, and use the same location. For example, USB network
drivers go in drivers/usb/net/, and filesystems go in fs/.

The driver should then be prepared for building from the main source tree
in this location.  A proper Makefile and Kconfig file in the Kbuild format
should be provided. Most times it is enough to just add your entries to
existing files. Here are some good rules to follow:

 - If your driver is a single source file (or single .c with a single .h),
   then it's typical to place the driver in an existing directory. Also,
   modify existing Makefile/Kconfig for that directory.

 - If your driver is made up of several source files, then it is typical
   to create a subdirectory for it under the existing directory where it
   applies. Separate Makefile should be included, with a reference in the
   parent Makefile to make sure to descend into the one you created.

   + In this case, it is usually still correct to just add the Kconfig
     entry to the existing one. If your driver has 2 or more config
     options (debug options, extra features, etc), then creating a
     standalone Kconfig may be best. Make sure to source this new Kconfig
     from the parent directory.

  - When creating the Kconfig entries be sure to keep in mind the criteria
    for the driver to be built. For example, a wireless network driver may
    need to "depend on NET && IEEE80211". Also, if your driver is specific
    to a certain architecture, be sure the Kconfig entry reflects this. DO
    NOT force your driver to a specific architecture simply because the
    driver is not written portably.

  - Make sure you provide useful help text for every entry you add to
    Kconfig so that users of your driver will be able to read about what
    it does, what hardware it supports and perhaps find a reference to
    more extensive documentation.

More info on the kbuild system is available in Documentation/kbuild/ in
the kernel source tree.

Lastly, you'll need to create an entry in the MAINTAINERS file. It should
reference you or the team responsible for the code being submitted (this
should be the same person/team submitting the code). Also include, if
available, a mailing that should be used for correspondence.


Code review
-----------

Once your patches are ready, you can submit them to the linux-kernel
mailing list. However, since most drivers fall under some subsystem (net,
usb, etc), then it is often more appropriate to send them to the mailing
list for this subsystem (see MAINTAINERS file for help finding the correct
address).

The code review process is there for two reasons. First, it ensures that
only good code, that follows current API's and coding practices, gets into
the kernel. The kernel developers know you have good intentions of
maintaining your driver, but too often a driver is submitted to the
kernel, and some time later becomes unmaintained. Then developers who are
not familiar with the code or its purpose are left with keeping it
compiling and working. So the code needs to be readable, and easily
modifiable.

Secondly, the code review helps you to make your driver better. The people
looking at your code have been doing Linux kernel work for years, and are
intimately familiar with all the nuances of the code. They can help with
locking issues as well as big-endian/little-endian and 64-bit portability.

Be prepared to take some heavy criticism. It's very rare that anyone comes
out of this process without a scratch. Usually code review takes several
tries. You'll need to follow the suggested changes, and make these to your
code, or have clear, acceptable reasons for *not* following the
suggestions. Code reviewers are generally receptive to reasoned argument.
If you do not follow a reviewer's initial suggestions, you should add
descriptive comments to the appropriate parts of the driver, so that
future contributors can understand why things are in a possibly unexpected
state. Once you've made the changes required, resubmit. Try not to take it
personally. The suggestions are meant to help you, your code, and your
users (and is often times seen as a rite of passage).


What is expected of me after my driver is accepted?
---------------------------------------------------

The real work of maintainership begins after your code is in the tree.
This is where some maintainers fail, and is the reason the kernel
developers are so reluctant to allow new drivers into the main tree.

There are two aspects of maintaining your driver in the kernel tree. The
obvious first duty is to keep your code synced to the kernel source. This
means submitting regular patch updates to the linux-kernel mailing list
and to the particular tree maintainer (e.g. Linus or Andrew). Now that
your code is included and properly styled and coded (with that shiny new
driver smell), it should be fairly easy to keep it that way.

The other side of the coin is keeping changes in the kernel synced to your
code. Often times, it is necessary to change a kernel API (driver model,
USB stack changes, networking subsystem change, etc). These sorts of
changes usually affect a large number of drivers. It is not feasible for
these changes to be individually submitted to the driver maintainers. So
instead, the changes are made together in the kernel tree. If your driver
is affected, you are expected to pick up these changes and merge them with
your temporary development copy.  Usually this job is made easier if you
use the same source control system that the kernel maintainers use
(currently, git), but this is not required. Using git, however, allows you
to merge more easily.

There are times where changes to your driver may happen that are not the
API type of changes described above. A user of your driver may submit a
patch directly to Linus to fix an obvious bug in the code. Sometimes these
trivial and obvious patches will be accepted without feedback from the
driver maintainer. Don't take this personally. We're all in this together.
Just pick up the change and keep in sync with it. If you think the change
was incorrect, try to find the mailing list thread or log comments
regarding the change to see what was going on. Then email the patch author
about the change to start discussion.


How should I maintain my code after it's in the kernel tree?
------------------------------------------------------------

The suggested, and certainly the easiest method, is to start a git tree
cloned from the primary kernel tree. In this way, you are able to
automatically track the kernel changes by pulling from Linus' tree. You
can read more about maintaining a kernel git tree at
http://linux.yyz.us/git-howto.html.

Whatever you decide to use for keeping your kernel tree, just remember
that the kernel tree source is the primary code. Your repository should
mainly be used for queuing patches, and doing development. Users should
not have to regularly go to your source in order to get a stable and
usable driver.

--Boundary_(ID_p3TJaRZ9NNLfjjvGrlDwWw)--
