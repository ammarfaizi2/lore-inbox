Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVBCLnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVBCLnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVBCLkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:40:42 -0500
Received: from rev.193.226.232.88.euroweb.hu ([193.226.232.88]:8128 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262920AbVBCL3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:29:46 -0500
To: fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Filesystem in Userspace - 2.2 
Message-Id: <E1CwfAs-0000aE-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 03 Feb 2005 12:29:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE version 2.2 is out there:

  http://sourceforge.net/project/showfiles.php?group_id=121684&package_id=132802&release_id=301878

This can be used standalone or with recent -mm kernels (with the
exception of -rc2-mm2).

Most notable changes since 2.1:

  - Added file handle parameter to open/read/write/release.  This
    should make life easier for filesystems wanting to implement
    stateful I/O.

  - Added compatibility to the 2.1 and to some extent to the 1.X API

  - Re-added ability to interrupt operations.  This time more
    carefully than in 1.X.

Regressions:

  - Removed shared-writable mmap support, which could deadlock the
    linux memory subsystem.  This should not affect most people, but
    if some application breaks for you, I'd like to hear about it.

  - Made the readpages() operation synchronous, again for deadlock
    considerations.  This can degrade performance, especially for high
    latency filesystems, since previously parallel read-ahead is now
    serialized.

In the long run I hope to solve both problems, but neither is trivial.
Ideas are welcome, as well as bugreports of course.

Thanks,
Miklos
