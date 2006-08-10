Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWHJBQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWHJBQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWHJBQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:16:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45703 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030520AbWHJBQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:16:36 -0400
Subject: [PATCH 0/5] Forking ext4 filesystem and JBD2
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:16:37 -0700
Message-Id: <1155172597.3161.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patch forkes a new filesystem, ext4, from the current
ext3 filesystem, as the code base to work on, for the big features such
as extents and larger fs(48 bit blk number) support, per our discussion
on lkml a few weeks ago. 

[patch 1/5] ext4-fork.patch
1) create a ext4 dir under fs/
2) copy all ext3 files to fs/ext4
3) rename all ext3/EXT3 symbols in ext4 filesystem source code to
ext4/EXT4 correspondingly.

[patch 2/5] register-ext3dev.patch
Registered the ext4 filesystem as ext3dev at this moment, as Ted Tso has
proposed before.  The intention is to explicitly tell the new filesystem
is still under development. And it will be re-register itself as ext4
filesystem once the on-disk format changes are pretty much developed and
merged.

[patch 3/5] fork-jbd2.patch
Forking JBD2 from JBD at the same time forking ext4 filesystem, as we
discussed before. New JBD2 layer is only used by ext4 for now, and will
support both 64bit and 32 bit blk number.

[patch 4/5] jbd2-rename-funcs.patch
Rename all exported symbols in JBD2 layer with a jbd2_ prefix to
distinguish them from those symbols from JBD layer.

[patch 5/5] rename-jbd2-in-ext4.patch
Use JBD2 functions/header files in ext4 filesystem

Tested the changes on i386 machine(load ext4and jbd2 as module and also
tested as built-in). Able to mount ext3dev filesystem on an exisiting
ext3 filesystem, and survived a few hours fsx tests and tiobench tests. 

Patches against 2.6.18-rc4 kernel. Previous extents and 48bit ext3
patches are rebased to against ext4 filesystem, will send them out in
another thread.  The whole series of ext4 patches (including patches to
fork ext4 filesystem and patches to add extents and 48 bit blk number)
are avaible at
http://ext2.sourceforge.net/48bitext3/patches/latest/

Any comments? Could we add ext4/jbd2 to mm tree for a wider testing?

Thanks,
Mingming

