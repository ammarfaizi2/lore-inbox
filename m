Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVHRJx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVHRJx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVHRJx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:53:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62607 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932152AbVHRJx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:53:57 -0400
Date: Thu, 18 Aug 2005 15:32:59 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@linux.intel.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [AIO] aio-2.6.13-rc6-B1
Message-ID: <20050818100259.GA7060@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050817184406.GA24961@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817184406.GA24961@linux.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 02:44:07PM -0400, Benjamin LaHaise wrote:
> The bugfix followup to the last aio rollup is now available at:
> 
> 	http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1-all.diff
> 
> with the split up in:
> 
> 	http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-B1/
> 
> This fixes the bugs noticed in the -B0 variant.  Major changes in this 
> patchset are:
> 
> 	- added aio semaphore ops
> 	- aio thread based fallbacks
> 	- vectored aio file_operations
> 	- aio sendmsg/recvmsg via thread fallbacks
> 	- retry based aio pipe operations
> 
> Comments?

Tried http://www.kvack.org/~bcrl/patches/aio-2.6.13-rc6-all.diff  (since
there is no aio-2.6.13-rc6-B1-all.diff). It hangs during bootup :(

...
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
Using IPI Shortcut mode
VFS: Cannot open root device "sda6" or unknown-block(8,6)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,6)


Regards
Suparna

> 
> 		-ben
> 
>  arch/i386/Kconfig              |    4 
>  arch/i386/kernel/semaphore.c   |  185 +-----------
>  arch/um/Kconfig_i386           |    4 
>  arch/um/Kconfig_x86_64         |    4 
>  arch/x86_64/Kconfig            |    4 
>  arch/x86_64/kernel/Makefile    |    2 
>  arch/x86_64/kernel/semaphore.c |  180 ------------
>  arch/x86_64/lib/thunk.S        |    1 
>  description                    |    9 
>  drivers/usb/gadget/inode.c     |    7 
>  fs/aio.c                       |  610 +++++++++++++++++++++++++++++++++++------
>  fs/bad_inode.c                 |    2 
>  fs/block_dev.c                 |    9 
>  fs/buffer.c                    |    2 
>  fs/ext2/file.c                 |    2 
>  fs/ext3/file.c                 |   16 -
>  fs/inode.c                     |    2 
>  fs/jfs/file.c                  |    2 
>  fs/ntfs/file.c                 |    2 
>  fs/pipe.c                      |  194 ++++++++++---
>  fs/read_write.c                |  182 ++++++++----
>  fs/reiserfs/file.c             |   10 
>  include/asm-i386/semaphore.h   |   42 ++
>  include/asm-x86_64/semaphore.h |   44 ++
>  include/linux/aio.h            |   38 ++
>  include/linux/aio_abi.h        |   13 
>  include/linux/fs.h             |    9 
>  include/linux/net.h            |    4 
>  include/linux/pagemap.h        |   29 +
>  include/linux/sched.h          |   13 
>  include/linux/wait.h           |   42 ++
>  include/linux/writeback.h      |    2 
>  kernel/exit.c                  |    2 
>  kernel/fork.c                  |    7 
>  kernel/sched.c                 |   14 
>  kernel/wait.c                  |   40 +-
>  lib/Makefile                   |    1 
>  lib/semaphore-sleepers.c       |  253 +++++++++++++++++
>  mm/filemap.c                   |  164 ++++++++---
>  net/socket.c                   |   97 +++++-
>  40 files changed, 1593 insertions(+), 654 deletions(-)
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

