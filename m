Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWCIEaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWCIEaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWCIEaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:30:55 -0500
Received: from xenotime.net ([66.160.160.81]:43176 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750747AbWCIEaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:30:55 -0500
Date: Wed, 8 Mar 2006 20:32:41 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [Updated]: How to become a kernel driver maintainer
Message-Id: <20060308203241.ebd4a12d.rdunlap@xenotime.net>
In-Reply-To: <1141841013.24202.194.camel@grayson>
References: <1136736455.24378.3.camel@grayson>
	<1136756756.1043.20.camel@grayson>
	<1136792769.2936.13.camel@laptopd505.fenrus.org>
	<1136813649.1043.30.camel@grayson>
	<1136842100.2936.34.camel@laptopd505.fenrus.org>
	<1141841013.24202.194.camel@grayson>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2006 13:03:33 -0500 Ben Collins wrote:

> Only small changes, title and a little rewording regarding "local
> development copy". I will submit a patch if there are no more changes to
> this document.

in addition to other comments:


> Another benefit of having the driver in the kernel tree is to promote
> the
> hardware that it supports. Many companies who have written drivers for

s/who/that/  (companies are not a person; "who" is for persons)

> their hardware to run under Linux have not yet taken the leap to placing
> the driver in the main kernel. The "Old Way" of providing downloadable
> drivers doesn't work as well for Linux, since it's almost impossible to
> provide pre-compiled versions for any given system. Having the driver in
> the kernel tree means it will always be available. It also means that
> users wishing to purchase hardware that "Just Works" with Linux will
> have
> more options. A well written and stable driver is a good reason for a

well-written

> user
> to choose that particular type of hardware.
> 
> Having drivers in the main kernel tree benefits everyone.
> 
> 
> What should I do to prepare for code submission?
> ------------------------------------------------
> 
> First you need to inspect your code and make sure it meets criteria for
> inclusion. Read Documentation/CodingStyle for help on proper coding
> format
> (indentation, comment style, etc). It is strongly suggested that your
> driver builds cleanly when checked by the "sparse" tool. You will
> probably
> need to annotate the driver so sparse can tell that it is following the
> kernel's rules for address space accesses and endianness.  Adding these
> annotations is a simple, but time-consuming, operation that often
> exposes
> real portability problems in drivers.
> 
> Once you have properly formatted the code, you also need to check a few
> other areas. Most drivers include backward compatibility for older
> kernels
> (usually ifdef's with LINUX_VERSION_CODE). This backward compatibility
> needs to be removed. It's considered a waste of code for the driver to
> be
> backward compatible within the kernel source tree, since it is going to
> be
> compiled with a known version of the kernel.

Also use "make checkstack", "make buildcheck", and "make namespacecheck"
to check for problems that they can detect.

> Proper location in the kernel source needs to be determined. Find
> drivers
> similar to yours, and use the same location. For example, USB network
> drivers go in drivers/usb/net/, and filesystems go in fs/.
> 
> The driver should then be prepared for building from the main source
> tree
> in this location.  A proper Makefile and Kconfig file in the Kbuild
> format

and Kbuild Makefile & Kconfig files are described in Documentation/kbuild/*

> should be provided. Most times it is enough to just add your entries to
> existing files. Here are some good rules to follow:
> 
>  - If your driver is a single source file (or single .c with a
> single .h),
>    then it's typical to place the driver in an existing directory. Also,
>    modify existing Makefile/Kconfig for that directory.
> 
>  - If your driver is made up of several source files, then it is typical
>    to create a subdirectory for it under the existing directory where it
>    applies. Separate Makefile should be included, with a reference in
> the
>    parent Makefile to make sure to descend into the one you created.
> 
>    + In this case, it is usually still correct to just add the Kconfig
>      entry to the existing one. Unless your driver has 2 or more config

s/Unless/If/

>      options (debug options, extra features, etc), then creating a
>      standalone Kconfig may be best. Make sure to source this new
> Kconfig
>      from the parent directory.
> 
>   - When creating the Kconfig entries be sure to keep in mind the
> criteria
>     for the driver to be build. For example, a wireless network driver
> may

s/build/built/

>     need to "depend on NET && IEEE80211". Also, if you driver is
> specific

s/you/your/

>     to a certain architecture, be sure the Kconfig entry reflects this.
> DO
>     NOT force your driver to a specific architecture simply because the
>     driver is not written portably.
> 
> Lastly, you'll need to create an entry in the MAINTAINERS file. It
> should
> reference you or the team responsible for the code being submitted (this
> should be the same person/team submitting the code).

and the mailing list that should be used for correspondence.

> Code review
> -----------
> 
> Once your patches are ready, you can submit them to the linux-kernel
> mailing list. However, since most drivers fall under some subsystem
> (net,
> usb, etc), then it is often required that you also Cc the mailing list
> for
> this subsystem (see MAINTAINERS file for help finding the correct
> address).

I disagree that lkml should always be used.  It is becoming terribly
over-burdened recently so either people are spending more time reading
too much email or they are ignoring it.  It would be better IMO to
send patches for focused mailing lists that are appropriate for the
driver.

> The code review process is there for two reasons. First, it ensures that
> only good code, that follows current API's and coding practices, gets
> into
> the kernel. The kernel developers know you have good intentions of
> maintaining your driver, but too often a driver is submitted to the
> kernel, and some time later becomes unmaintained. Then developers who
> are
> not familiar with the code or it's purpose are left with keeping it

s/it's/its/

> compiling and working. So the code needs to be readable, and easily
> modified.


> What is expected of me after my driver is accepted?
> ---------------------------------------------------
> 
> The real work of maintainership begins after your code is in the tree.
> This is where some maintainers fail, and is the reason the kernel
> developers are so reluctant to allow new drivers into the main tree.

I disagree with that last part.  I guess I have seen some reluctance
occasionally, but I don't think that it's the (main) reason for
drivers not being accepted into the kernel tree.

> How should I maintain my code after it's in the kernel tree?
> ------------------------------------------------------------
> 
> Whatever you decide to use for keeping your kernel tree, just remember
> that the kernel tree source is the primary code. Your repository should
> mainly be used for queuing patches, and doing development. Users should
> not have to regularly go to your source in order to get a stable and
> usable driver.

amen.

---
~Randy
