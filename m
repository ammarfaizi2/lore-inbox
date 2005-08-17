Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVHQUzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVHQUzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVHQUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:55:10 -0400
Received: from fmr24.intel.com ([143.183.121.16]:20973 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751250AbVHQUzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:55:08 -0400
Date: Wed, 17 Aug 2005 14:48:44 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [bcrl@linux.intel.com: [AIO] aio-2.6.13-rc6-B1]
Message-ID: <20050817184844.GA25332@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this comes through as a duplicate, but the mail client hung on 
my first attempt at sending this through....

----- Forwarded message from Benjamin LaHaise <bcrl@linux.intel.com> -----

Subject: [AIO] aio-2.6.13-rc6-B1
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 17 Aug 2005 14:44:07 -0400

The bugfix followup to the last aio rollup is now available at:

	http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1-all.diff

with the split up in:

	http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1/

This fixes the bugs noticed in the -B0 variant.  Major changes in this 
patchset are:

	- added aio semaphore ops
	- aio thread based fallbacks
	- vectored aio file_operations
	- aio sendmsg/recvmsg via thread fallbacks
	- retry based aio pipe operations

Comments?

		-ben

 arch/i386/Kconfig              |    4 
 arch/i386/kernel/semaphore.c   |  185 +-----------
 arch/um/Kconfig_i386           |    4 
 arch/um/Kconfig_x86_64         |    4 
 arch/x86_64/Kconfig            |    4 
 arch/x86_64/kernel/Makefile    |    2 
 arch/x86_64/kernel/semaphore.c |  180 ------------
 arch/x86_64/lib/thunk.S        |    1 
 description                    |    9 
 drivers/usb/gadget/inode.c     |    7 
 fs/aio.c                       |  610 +++++++++++++++++++++++++++++++++++------
 fs/bad_inode.c                 |    2 
 fs/block_dev.c                 |    9 
 fs/buffer.c                    |    2 
 fs/ext2/file.c                 |    2 
 fs/ext3/file.c                 |   16 -
 fs/inode.c                     |    2 
 fs/jfs/file.c                  |    2 
 fs/ntfs/file.c                 |    2 
 fs/pipe.c                      |  194 ++++++++++---
 fs/read_write.c                |  182 ++++++++----
 fs/reiserfs/file.c             |   10 
 include/asm-i386/semaphore.h   |   42 ++
 include/asm-x86_64/semaphore.h |   44 ++
 include/linux/aio.h            |   38 ++
 include/linux/aio_abi.h        |   13 
 include/linux/fs.h             |    9 
 include/linux/net.h            |    4 
 include/linux/pagemap.h        |   29 +
 include/linux/sched.h          |   13 
 include/linux/wait.h           |   42 ++
 include/linux/writeback.h      |    2 
 kernel/exit.c                  |    2 
 kernel/fork.c                  |    7 
 kernel/sched.c                 |   14 
 kernel/wait.c                  |   40 +-
 lib/Makefile                   |    1 
 lib/semaphore-sleepers.c       |  253 +++++++++++++++++
 mm/filemap.c                   |  164 ++++++++---
 net/socket.c                   |   97 +++++-
 40 files changed, 1593 insertions(+), 654 deletions(-)

----- End forwarded message -----
