Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267862AbUHSB72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267862AbUHSB72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 21:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHSB71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 21:59:27 -0400
Received: from [12.177.129.25] ([12.177.129.25]:38595 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267862AbUHSB7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 21:59:25 -0400
Message-Id: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.6.7-2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Aug 2004 23:00:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released a second 2.6.7 UML patch.  This is to push out the changes I
have in order to give me a clean slate for the 2.6.8.1 UML.  These changes
sync up my 2.4 and 2.6 trees, and include

	Build cleanups, including 'linux' is now the default target, an
updated defconfig, and Kconfig updates
	Code cleanup, including removal of unused SMP code, removal of a 
userspace file, more EINTR handling, more error checking
	Time fixes, including switching from rdtsc to gettimeofday for the
real-time clock option and better handling of the host clock jumping backwards
	Introduction of centralized file descriptor management, allowing 
descriptors to be reclaimed if UML has hit the host's limit and the files
can be reopened to provide access to the same object on the host
	Introduction of externfs, which allows host resources to be mounted
as UML filesystems.  externfs handles the kernel interface and plug-ins to
it handle the host resources.  There are two users, hostfs and humfs, both
of which provide access to host directory hierarchies.  humfs stores metadata
separately, ala umsdos, which allows operations within the mount which would
require root privileges on the host with hostfs.  hostfs and humfs are still
somewhat dodgy on 2.6.
	UML can load at 0x8048000 like every other binary when MODE_SKAS
is enabled and MODE_TT is off.  This makes valgrind happier, and also
allows UML to have more physical memory without resorting to highmem.  With
STATIC_LINK disabled, the limit is ~750M, and with it enabled, the limit is 
~2.75G.
	A good number of bugs, including some crashes were also fixed.

For the full details, see
	http://user-mode-linux.sourceforge.net/changelog-uml-patch-2.6.7-2.bz2.html

For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html

Incremental patches between UML releases are available at
	http://user-mode-linux.sourceforge.net/patches.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

				Jeff

