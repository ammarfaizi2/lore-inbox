Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUFUBZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUFUBZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUFUBZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:25:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:10905 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265530AbUFUBZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:25:35 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Hannu Savolainen <hannu@opensound.com>
Subject: Re: [PATCH 0/2] kbuild updates
Date: Mon, 21 Jun 2004 03:27:42 +0200
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620220319.GA10407@mars.ravnborg.org> <Pine.LNX.4.58.0406210242300.16975@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.58.0406210242300.16975@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406210327.42241.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 June 2004 02:29, Hannu Savolainen wrote:
> On Mon, 21 Jun 2004, Sam Ravnborg wrote:
> > > Many external modules, libs, etc use
> > > /lib/modules/`uname -r`/build to locate the _source_, and this will
> > > break them all.
> >
> > Examples please. What I have seen so far is modules that was not
> > adapted to use kbuild when being build.
> > If they fail to do so they are inherently broken.
>
> For example our installation script expects that
> /lib/modules/`uname -r`/build behaves like a symbolic link that points to
> /usr/src/linux-`uname -r`. If /lib/modules/`uname -r`/build doesn't exist
> then /usr/src/linux-`uname -r` will be attempted instead.
>
> "make -C $KERNELDIR SUBDIRS=$MYDIR \
>       CC=what_we_think_is_the_right_gcc_version" modules
>
> This approach seems to work with the "stock" kernels as well as with all
> the distribution kernels what we have tried so far (except the latest
> kernel from SuSE that used different directory scheme).

Did you actually try the above command with a SUSE kernel? I don't think so; 
one of the earlier postings in the other thread spiced with strong words 
tried to do other unusual things.

> It's relatively easy to use the dual directory scheme provided that the
> object and source directories always have the same naming. However it's
> possible that in the future there will be much more projects that need to
> compile external modules. So it would be easier in general if the
> (possible) dual directory scheme is "hidden" from the external projects.

This is already in place with Sam's patches.

> It should be easy difficult to patch the Makefile in
> /lib/modules/`uname -r`/build to locate the object directory without
> requiring the caller to pass it as a parameter to the "make modules"
> command.

There is one source tree for N object trees in general. Going from the N side 
to the 1 side makes a lot more sense than going the other way around.

> There is one special problem that doesn't affect users who have compiled
> their kernel themselves. Many distributions don't include gcc, make and
> related tools in the default installation so large amount of customer
> sites don't have them installed.

You will invoke make directly, so you should check if make and the kernel 
sources for the running kernel are available.

> In addition different gcc version may 
> have to be used to compile the kernel than the one that is the default gcc
> command in the system.

Then this should be defined in the Makefile in the kernel sources. Fixing 
problems for people who build their own kernels from vanilla sources without 
paying attention to such details will take you nowhere, it will only mess 
things up even worse.

> So before anything can be compiled the installation 
> scripts have to check also if the required tools are installed. If they
> are not available then the customer needs to be instructed to install
> them. Because the installation procedure depents on the distribution it's
> very difficult to help the customer in any way. For this reason it would
> be better if the re is some kind of unbrella script for building the
> module. In the vanilla kernels it simply executes the right make command.
> If the distribution vendors see it necessary they can improve the script
> and add features like automatic installation of the required modules or
> whatever else.

There could be a few basic checks in kbuild whether or not the required tools 
are available. Telling users who compile kernel modules on their own how to 
install packages sounds a bit much asked for my taste.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
