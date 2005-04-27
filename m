Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVD0DCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVD0DCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 23:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVD0DCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 23:02:49 -0400
Received: from mail.autoweb.net ([198.172.237.26]:53927 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261895AbVD0DCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 23:02:46 -0400
Subject: [UML] Compile error when building with seperate source and object
	directories
From: Ryan Anderson <ryan@michonline.com>
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Apr 2005 23:02:38 -0400
Message-Id: <1114570958.5983.50.camel@mythical>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing a build error when trying to build User Mode Linux on
an x86-32 host (Athlon, fwiw).  The kernel I'm building is a 1-day old
pull from git.  This error is not new, though.  I thought it was merely
an artifact of a patch stuck in a queue at first so I didn't mention it
right away.

ryan@mythryan2 ~/dev/linux/linux-git$ make O=/home/ryan/dev/linux/output/uml ARCH="um" -j4 CC="ccache distcc" clean
/bin/bash: line 1: cd: arch/um: No such file or directory
ryan@mythryan2 ~/dev/linux/linux-git$ make O=/home/ryan/dev/linux/output/uml ARCH="um" -j4 CC="ccache distcc" oldconfig
/bin/bash: line 1: cd: arch/um: No such file or directory
  HOSTCC  scripts/basic/fixdep
  GEN    /home/ryan/dev/linux/output/uml/Makefile
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -o arch/um/Kconfig
arch/um/Kconfig:71: can't open file "arch/um/Kconfig_arch"
make[2]: *** [oldconfig] Error 1
make[1]: *** [oldconfig] Error 2
make: *** [oldconfig] Error 2


ryan@mythryan2 ~/dev/linux/linux-git$ ls -al /home/ryan/dev/linux/output/uml/
total 60
drwxr-xr-x  5 ryan ryan  4096 Apr 13 11:15 .
drwxr-xr-x  4 ryan ryan  4096 Apr 23 02:38 ..
-rw-r--r--  1 ryan ryan 15445 Apr 13 11:15 .config
-rw-r--r--  1 ryan ryan  1812 Apr 13 11:15 .config.cmd
-rw-r--r--  1 ryan ryan 15855 Mar 29 03:20 .config.old
-rw-r--r--  1 ryan ryan   351 Apr 26 22:56 Makefile
drwxr-xr-x  4 ryan ryan  4096 Apr 13 11:15 include
drwxr-xr-x  2 ryan ryan  4096 Apr 13 11:15 include2
drwxr-xr-x  4 ryan ryan  4096 Mar 29 03:21 scripts

I'm not quite sure what's going on here - but something seems broken.

My gut feeling is that arch/um/Kconfig_arch is supposed to be a symlink
(or something else magical) pointing at arch/um/Kconfig_i386, but this
doesn't seem to be working.

I can provide my .config if it matters - but since the above failure
happens almost instantly, I don't think it will matter much.

Thanks!

-- 
Ryan Anderson <ryan@michonline.com>
