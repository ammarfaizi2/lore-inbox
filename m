Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTKAHoP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 02:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTKAHoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 02:44:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:3593 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261687AbTKAHoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 02:44:14 -0500
Date: Sat, 1 Nov 2003 08:44:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031101074412.GB924@mars.ravnborg.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031030141519.GA10700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030141519.GA10700@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 02:15:19PM +0000, Dave Jones wrote:
> Modules.
> ~~~~~~~~
> - Modules now have a .ko suffix instead of .o
- Building external modules requires the use of kbuild, so a full kernel
  src package is needed. See also Documentation/kbuild/modules.txt

> Kernel build system.
> ~~~~~~~~~~~~~~~~~~~~
I suggest the following ordering and content:

 - The build system is much improved compared to 2.4.
   You should notice quicker builds, and no spontaneous rebuilds of files
   on subsequent builds from already built trees.
 - There are two new graphical config tools.
   "make xconfig" requires the qt libraries.
   "make gconfig" requires gtk libraries.
 - Make menuconfig/oldconfig has no user-visible changes other than speed,
   whilst numerous improvements have been made.
 - 'make help' provides a list of typical targets, including several new
   debugging targets ('allyesconfig' 'allnoconfig' 'allmodconfig' + more).
 - "make" is now the preferred command, without a target; it builds
   <arch-zimage> and modules. See 'make help' for what is built by default.
 - "make -jN" is now the preferred parallel-make execution.
   Do not bother to provide "MAKE=xxx"
 - Output files can be directed to an alternative directory. Use 'make O=dir'
   to locate all output files (including .config) in 'dir'.
 - The build is now much less verbose.  If you want to see exactly what's
   going on, try "make V=1" or set KBUILD_VERBOSE=1 in your environment.
 - 'make kernel/mm.o' will build the named file, provided a
   corresponding source exists. This also works for (non-composite)
   modules.
 - 'make kernel/' will recursively build all files in the specified
   subdirectory and below.
 - 'make dep' has been obsoleted and does no longer have any effect.
 - Note: The new configuration system is not CML2 related.
 - Also note: Whilst some ideas were taken from it, Keith Owens'
   kbuild-2.5 project was not integrated.

	Sam
