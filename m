Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUHOUmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUHOUmc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUHOUmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:42:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37512 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266879AbUHOUma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:42:30 -0400
Date: Sun, 15 Aug 2004 21:42:29 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild + kconfig: Updates
Message-ID: <20040815204229.GJ12308@parcelfarce.linux.theplanet.co.uk>
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:12:24PM +0200, Sam Ravnborg wrote:
> A number of kbuild updates and Randy's Kconfig.debug
> 
> Most important stuff is:
> o Get rid og bogus "has no CRC" when building external modules
> o Rename *.lds.s to *.lds (*)
> o Allow external modules to use host-progs
> 
> (*) The renaming of the *.lds file has been doen to allow the kernel to
> be build with for example Cygwin.
> The major outstanding issue with Cygwin/Solaris are availability of
> certain .h files for the tools in scripts/* and spread in the tree.
> Tested patches that allows the tools to be build under Cygwin/Solaris
> are appreciated.
> 
> Patches follows this mail.

Speaking of kbuild, is there any reasonable way to do check-only runs?
Simple "set CC et.al. to scripts that will create target and do nothing
else" doesn't work for obvious reasons - we have some stuff that really
has to be compiled (e.g. empty.c + some arch-dependent files).  Same
goes for make -n C=1 | grep sparse | ... variants.

Another thing that would be very nice to have: analog of allmodconfig with
some options pre-set.  Trivial cases can be hanlded by patching Kconfig
(basically, adding depends on BROKEN), but IWBN to have something like
make allmodconfig PRESET=<file that looks like a subset of .config>...
