Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbUEFWjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUEFWjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 18:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUEFWjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 18:39:11 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5584 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263156AbUEFWjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 18:39:01 -0400
Message-ID: <409ABE7D.5040603@opensound.com>
Date: Thu, 06 May 2004 15:38:53 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: sam@ravnborg.org
Subject: [Fwd: Re: What is needed to build an external module]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sam Ravnborg wrote:
> In a private mail Dev Mazumdar suggested to create a system for 
> building external modules without the necessity to have the
> full kernel source available.
> 
> I decided to take this to LKML since it may be a questions
> other people had.
> 
> The reason why one must use the kbuild infrastructure when 
> building external modules are the CONFIG choices that either
> impact gcc options or the include files.
> If a seperate system for buiding modules were made that
> part should be copied over for each and every change, and only
> one particular version of the 'building external modules' would
> be compatible with a given kernel version. So having a 
> seperate system is a no-go.
> 
> What one should realize what is actually needed to build an
> external module.
> A full copy of:
> root of kernel src
> include/
> scripts/
> and a copy of the Makefile for the selected architecture.
> Thats all needed to build a well behaving external module.
> This could very well be what a distribution places in
> /lib/modules/linux-<version>/build
> and not a full kernel tree.
> 
> Hope this clarifies,
> 
> 	Sam
> 

Hi Sam,

Many thanks for your email.

Just having include+scripts in the build directory is sufficient.
Ofcourse this must totally match the kernel installed.

I think this is a workable system provided every Linux 2.6 distributor
ships this stuff when you just install the kernel RPM. So someone needs
to enforce this with all the new Linux 2.6 distributions (we need to
push this issue with OSDL/LSB as well)

The problem currently is that when you install the kernel source RPM,
the /lib/module/<ver>/build is a symlink to that kernel tree but it doesn't
reflect the exact settings/modifications that are in the kernel.

For example, I could be running a AMD K7/GCC 3.3/FOO/BAR kernel
but the kernel sources would reflect a i386/GCC 3.3.1/FOO kernel (with BAR not
configured by default - eg Fedora doesn't show 4KSTACKS in their .config - which
is why we needed vermagic).


So my proposal is that:

1) /lib/modules/<kernel version>/build is a directory (rather than symlink)

2) When you build/install a new kernel, the following is copied over (assuming a
    linux 2.6.6 kernel tree):

	a) the appropriate <asm-ARCH> and <linux> directories from
	   /usr/src/linux-2.6.6/include to the /lib/modules/2.6.6/build directory

	b) /usr/src/linux-2.6.6/scripts to the /lib/modules/2.6.6/build directory.
	
	c) /usr/src/linux-2.6.6/Makefile and .config to the /lib/modules/2.6.6/build dir.

Now we have a coherent build environment that totally reflects the configured kernel,
the kbuild environment and other kernel related changes in the includes/scripts etc.
We can now use kbuild to build out-of-kernel drivers without needing full kernel
sources.

We will work on this implementation and have something for your review next week.


best regards

Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

