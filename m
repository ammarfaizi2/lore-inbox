Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTLEDci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTLEDci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:32:38 -0500
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:52426
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S263836AbTLEDcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:32:36 -0500
Subject: [BK PATCH 0/3] Teach kbuild to pull files from BK repository
From: David Dillow <dave@thedillows.org>
To: linux-kernel@vger.kernel.org
Cc: kbuild-devel@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1070595121.4574.24.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Dec 2003 22:32:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I finally got tired of having to run "bk -r get" before doing a build, so I
taught the kbuild system to get the needed files for me. I did most of the
work before Sam added the KBUILD_OUTPUT option, so this doesn't work when
you're building to a different directory. It could probably be added with
a few tweaks to scripts/getfiles, but I'm lazy, and don't use KBUILD_OUTPUT
myself. If that scratches your itch, then feel free to take this code and
run with it. Same goes for CVS or subversion -- it should not be very
difficult to get those working as well.

This isn't really meant for inclusion, just something that makes my life
easier. Maybe it will make your's easier too. Though, I'll have to do many,
many builds in order to make up for the lost time.... :)

Anyways, the patches follow, or BK users (the intended audience) can do a

	bk pull http://typhoon.bkbits.net/autoget-2.5

This will update the following files:

 Makefile                            |   89 +++++++++++--
 drivers/scsi/aic7xxx/Makefile       |    2 
 scripts/Makefile.build              |   13 +
 scripts/Makefile.clean              |    6 
 scripts/Makefile.repo               |  124 ++++++++++++++++++
 scripts/depkconfig                  |   58 ++++++++
 scripts/getfiles                    |  245 ++++++++++++++++++++++++++++++++++++
 scripts/kconfig/Makefile            |   30 ++--
 scripts/kconfig/lex.zconf.c_shipped |  114 +++++++++++++++-
 scripts/kconfig/listkconfigs.c      |   22 +++
 scripts/kconfig/lkc.h               |    2 
 scripts/kconfig/zconf.l             |   29 +++-
 12 files changed, 697 insertions(+), 37 deletions(-)

through these ChangeSets:

<dave@thedillows.org> (03/12/04 1.1507)
   Make the build process a bit less verbose and a bit cleaner during a build
   from a "cleaned" repository.

<dave@thedillows.org> (03/12/04 1.1506)
   Teach the kbuild system how to retrieve the Kconfig files from
   the repository. This involves modifying the kconfig lexer/parser
   to give us a list of sourced Kconfig files so that we can tell
   make about the dependencies. Then is just a matter of makeing sure
   that make will extract those files before they are needed in the
   build process.

<dave@thedillows.org> (03/12/03 1.1505)
   Teach the kbuild system how to pull needed files from the repository.
   With this, you can copy your config into a clean repository, type
   make, and it will build the kernel, retrieving any needed files that
   have not yet been checked out.
           
   We cannot use make's default implicit rules to do this, as we do
   not list the dependencies for each file in the Makefiles, nor do we
   want to. Therefore, we use the getfiles script to parse error
   messages from a gcc -E run to determine which files are missing.
           
   This does not handle Kconfig files yet, only the source files.



