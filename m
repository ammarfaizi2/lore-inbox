Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUHRVEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUHRVEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHRVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:03:34 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:43564 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267748AbUHRVCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:02:41 -0400
Date: Thu, 19 Aug 2004 01:02:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Kbuild updates
Message-ID: <20040818230252.GA23495@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another bunch of smallish kbuild updates.

o Fix parrallel build
o Add make C=2 to force check of C code with sparse
o Fiw warnings in binoffset
o Removed dreadful check for undefined symbols in vmlinux
o Delete last occurence of HEAD in kbuild
o Add comments to Makefile.clean
o Introduce CHECKFLAGS enabling make CHECK=mysparse

Patches follows (most have been sent to lkml before).


Significant outstanding items in kbuild land is mainly package
handling.
Several issues needs to be adressed:
- Rename debian directory to deb/debian
- Utilise parallel build with make rpm
- Add one more prm package variant
- Add tar-pkg, targz.pkg
- Find a better way to identify relevant binaries to include in rpm, deb
	- Current KBUILD_IMAGE proves not to be good enough


And a patch relate to control alignment in gcc produced code.
Needs to land some consolidation stuff first. Planning to rename
check_gcc to gcc_option, and include a new one named gcc_option_ok.


For ppc we have a problem with as trashing /dev/null.
This is apperantly due to this code:
BAD_AGCC_AS :=  $(shell echo mftb 5 | $(AS) -mppc -many -o /dev/null >/dev/null 2>&1 && echo 0 || echo 1)
 
It seem like as deletes /dev/null and recreate it.
Not good if run as root - which is needed for modules_install for example.

Would it be considered acceptable to start using mktemp to generate temporary
filenames as part of a normal kernel build?
I do not fully understand the eventual security issues around this!

	Sam
