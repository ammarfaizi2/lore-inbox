Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWF1XpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWF1XpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWF1XpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:45:14 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:38865 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751780AbWF1XpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:45:12 -0400
Date: Thu, 29 Jun 2006 00:44:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, sam@savnborg.org, arnd@arndb.de,
       jbailey@ubuntu.com, Tim Yamin <plasmaroo@gentoo.org>,
       Bernhard Rosenkraenzer <bero@arklinux.org>, alan@lxorguk.ukuu.org.uk,
       Thorsten Kukuk <kukuk@suse.de>, Clint Adams <schizo@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT *] make headers_install
Message-ID: <20060628234450.GB5074@linux-mips.org>
References: <1151446372.6394.295.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151446372.6394.295.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 11:12:52PM +0100, David Woodhouse wrote:

> Linus, please pull from git://git.infradead.org/hdrinstall-2.6.git
> 
> This contains an implementation of a 'make headers_install' target for
> the kernel -- based on original work by Arnd Bergmann, modifed my myself
> and then cleaned up by Sam. This copies _selected_ kernel headers out to
> a separate directory, passing them through sed and BSD's 'unifdef' tool
> to remove parts which userspace should not see.
> 
> (The BSD 'unifdef' tool is available at least in Fedora and Debian
> through their standard package management tools. I believe that Sam
> intends to follow up with a patch to add our own copy of unifdef into
> the kernel scripts/ directory, as soon as he's fixed the dependency
> issues with that.)
> 
> This isn't a departure from our current policy that random userspace
> must not poke at kernel private headers. It's just an attempt to impose
> some control over those places where we have to accept that people _do_
> use the kernel's headers -- when building system libraries and tools,
> and when building compilers.
> 
> Currently, the compiler-build scripts just use 'cp -a', while the
> distributions tend to do their own thing to make it _slightly_ saner
> than that, although it's a lot of work to do so. The result is wildly
> inconsistent and often exposes things which we really don't want
> userspace to have copies of.
> 
> By adding a 'make headers_install' target to the kernel, we regulate
> those people who really do have to use kernel headers, and we can ensure
> that we have a _consistent_ set of headers across all distributions,
> which contains only what we _need_ to expose; ioctl definitions, etc.
> 
> An additional benefit is that comparing the results of 'make
> headers_install' from one kernel release to the next allows us to spot
> kernel<->user ABI changes in isolation and give them the extra review
> that they deserve. I've already caught and fixed one potential problem
> with 32-bit userspace on a 64-bit kernel this way.
> 
> The result of this export is already being used in the Fedora Core 6
> test releases, and other distributions are either looking at switching
> over to it or have done so already.
> 
> Ignoring the new Kbuild files which just list the files to be exported
> from each directory under include/, the diffstat is as follows:

Thanks for the time you've been pouring into this.  Copying kernel header
into applications clearly didn't work too well, especially for arch stuff
(two dozen and counting ...) it was a pain and each distribution had
different sets of hacked kernel headers.  So I hope this will restore
some sanity - and same for klibc.

  Ralf
