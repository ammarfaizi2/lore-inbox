Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVCDGek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVCDGek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCDGej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:34:39 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:52449 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262340AbVCDGeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:34:09 -0500
Date: Thu, 3 Mar 2005 22:33:40 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <reiser@namesys.com>
cc: mc@cs.Stanford.EDU
Subject: [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync
 option?
Message-ID: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

FiSC (our file system checker) emits several warnings on ext2, jfs and
reiserfs, complaining that diretories or files are lost while FiSC
believes they should already be persistent on disk. (ext3 behaves
correctly.)

All warnings boil down to a single cause:  when these file systems are
mounted -o sync or dirsync, dirty blocks are still written out
asynchronously.  It appears to me that these mount options don't have any
effect on these file systems.  Is this the intended behavior?

man mount shows:

              sync   All  I/O to the file system should be done
synchronously.

              dirsync
                     All directory updates within the file  system  should
be
                     done  synchronously.   This  affects the following
system
                     calls: creat, link, unlink, symlink, mkdir, rmdir,
mknod
                     and rename.

Any clafirication on this would be very helpful,

-Junfeng

