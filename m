Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUCGMxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUCGMxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:53:52 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:2830 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261614AbUCGMxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:53:50 -0500
Date: Sun, 7 Mar 2004 13:53:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: External kernel modules, second try
Message-ID: <20040307125348.GA2020@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
	"kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>
References: <1078620297.3156.139.camel@nb.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078620297.3156.139.camel@nb.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 01:44:58AM +0100, Andreas Gruenbacher wrote:
> Hello,
> 
> here is the patch I posted previously that adds support for modversions
> in external kernel modules that are built outside the main kernel tree
> (first posting archived here: http://lwn.net/Articles/69148/). Relative
> to the original version, the attached version also works when compiling
> with O=.
Hi Andreas.
I have started to look into this.
The changes im Makefile when you use SUBDIRS as a flag does not look
pretty.

What I have in mind is something like this:
- Get rid of current use of SUBDIRS. It is no longer used in any
  arch Makefiles.
- Introduce a KBUILD_EXTMOD variable that is only set when building
  external modules
- Introduce a new method to be used when compiling external modules:
  make M=dir-to-module
- Keeping the SUbDIRS notation for backward compatibility
- When using SUBDIRS or M= the 'modules' target is implicit.
- make clean and make mrproper/distclen only deletes files in the
  external module directory (as done in your patch)
- Error out if any updadtes are requires in the kernel tree
- Find a magic way to include a Kconfig file for the external module
- Allow kbuild Makefiles to be named Kbuild, so local stuff can be in
  a file named Makefile file
  note: this can be achieved using makefile/Makefile today but
  it makes sense since there is not much 'Make' syntax left in
  kbuild makefiles today.

Above will not be made in one go. My next step is to make a patch for the
first four steps - to see the actual impact on current makefiles.

Comments welcome!

Could you explain what is the actually gain of using the
modversions file your patch creates. (modpost changes)

> The patch also adds a modules_add target that does the equivalent of
> modules_install for one external module.
Looks good.

> The third change is to remove one instance of temporary file creation
> inside the main kernel tree while external modules are built. I think
> there are still other cases where temp files in the kernel tree are
> used. IMHO they should all go away, so that a ``make -C $KERNEL_SOURCE
> modules SUBDIRS=$PWD'' works against a read-only tree.
Agree - should be easy to test using a CD.
Are there an easy way to mount just a directory structure RO?

	Sam
