Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUFTVHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUFTVHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUFTVHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:07:51 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:42540 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263585AbUFTVHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:07:49 -0400
Date: Sun, 20 Jun 2004 23:19:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/2] kbuild updates
Message-ID: <20040620211905.GA10189@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Linus.

Here follows two kbuild patches.

1) Add generic infrastructure for creating kernel packages.
   This moves make rpm support to scripts/package
   and add the deb-pkg target.
   The infrastructure were added because there is requests
   to add .tar.gz, .tar.gz2 support as well, and the functionality
   really did not belong in the top-level makefile.
   The implementation is simplified based on feedback on first
   patch, so one just have to set KBUILD_IMAGE in arch Makefiel
   to say what kernel image to include in the package.

2) Improved support for external modules.
   It has been debated what to name the symlink in /lib/modules/`uname -r`
   and where it should point.
   Now that there is a possibility to build the kernel with a separate output
   directory, there is a need to utilise this in the install.
   From now on build will point to the output directory, and source will point
   to the kernel source.
   A small MAkefile is created in the output directory allowing external modules
   to continue to build independent of the kernel being built with separate
   output directory, or with ouput and source mixed.

   If the kernel is build with source and output mixed there is no change
   in behaviour.
   If the kernel is build with separate source and output directories,
   all external modules that has not yet picked up on using the kbuild
   infrastructure will fail...
   No effort whatsoever will be done to keep external modules working if they
   do not use the kbuild infrastructure. There is no reason not to do so.

	Sam
