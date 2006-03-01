Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWCAXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWCAXPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCAXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:15:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:24451 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751122AbWCAXPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:15:51 -0500
Date: Wed, 1 Mar 2006 15:19:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.15.5
Message-ID: <20060301231907.GR3883@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.15.5 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.15.4 and 2.6.15.5, as it is small enough to do so.

The updated 2.6.15.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Documentation/hwmon/it87               |    2 
 Makefile                               |    2 
 arch/i386/kernel/cpu/common.c          |   17 +++---
 arch/ia64/ia32/ia32_signal.c           |    1 
 arch/ppc/boot/common/util.S            |    6 +-
 arch/s390/kernel/compat_signal.c       |    3 -
 drivers/hwmon/it87.c                   |    6 +-
 drivers/ieee1394/sbp2.c                |   10 +++
 drivers/infiniband/hw/mthca/mthca_qp.c |   62 +++++++++++++-----------
 drivers/md/dm.c                        |    8 ++-
 drivers/mtd/chips/cfi_cmdset_0001.c    |    1 
 drivers/net/skge.c                     |   85 ++++++++++++++++++++-------------
 drivers/net/skge.h                     |    1 
 drivers/scsi/sd.c                      |   19 ++++++-
 drivers/video/Kconfig                  |    2 
 drivers/video/gbefb.c                  |    3 +
 fs/binfmt_elf.c                        |    5 +
 fs/exec.c                              |    2 
 fs/ext2/xattr.c                        |    6 +-
 fs/hugetlbfs/inode.c                   |    4 -
 fs/nfs/direct.c                        |    5 +
 fs/ramfs/inode.c                       |    2 
 fs/reiserfs/super.c                    |    2 
 fs/xfs/linux-2.6/xfs_aops.c            |    2 
 include/asm-s390/setup.h               |   10 ++-
 include/linux/netlink.h                |    3 -
 include/linux/ptrace.h                 |    1 
 include/linux/sched.h                  |    2 
 ipc/mqueue.c                           |    3 -
 ipc/shm.c                              |    1 
 kernel/ptrace.c                        |   25 +++++----
 kernel/signal.c                        |    9 +--
 mm/mempolicy.c                         |    2 
 net/bridge/br_netfilter.c              |    4 -
 net/bridge/br_stp_if.c                 |    4 -
 net/core/datagram.c                    |   81 ++++++++++++++++++++-----------
 net/ipv6/addrconf.c                    |    3 +
 net/netlink/af_netlink.c               |    7 +-
 sound/core/control_compat.c            |   16 ++++--
 sound/drivers/opl3/opl3_oss.c          |    2 
 40 files changed, 277 insertions(+), 152 deletions(-)

Summary of changes from v2.6.15.4 to v2.6.15.5
==============================================

Adrian Drzewiecki:
      Fix deadlock in br_stp_disable_bridge

Alexey Kuznetsov:
      Fix a severe bug

Andi Kleen:
      i386: Move phys_proc_id/early intel workaround to correct function

Andrew Morton:
      ramfs: update dir mtime and ctime

Chris Wright:
      sys_mbind sanity checking
      Linux 2.6.15.5

Dave Jones:
      Fix s390 build failure.

David S. Miller:
      Revert skb_copy_datagram_iovec() recursion elimination.

Heiko Carstens:
      s390: add #ifdef __KERNEL__ to asm-s390/setup.h

Horms:
      netfilter missing symbol has_bridge_parent

Hugh Dickins:
      hugetlbfs mmap ENOMEM failure

Jack Morgenstein:
      IB/mthca: max_inline_data handling tweaks

Jean Delvare:
      it87: Fix oops on removal
      hwmon it87: Probe i2c 0x2d only

Jeff Mahoney:
      reiserfs: disable automatic enabling of reiserfs inode attributes

Juergen Kreileder:
      Fix snd-usb-audio in 32-bit compat environment

Jun'ichi Nomura:
      dm: missing bdput/thaw_bdev at removal
      dm: free minor after unlink gendisk

Kaj-Michael Lang:
      gbefb: IP32 gbefb depth change fix

KAMEZAWA Hiroyuki:
      shmdt cannot detach not-alined shm segment cleanly.

Kristian Slavov:
      Address autoconfiguration does not work after device down/up cycle

Martin Michlmayr:
      gbefb: Set default of FB_GBE_MEM to 4 MB

Mike O'Connor:
      XFS ftruncate() bug could expose stale data (CVE-2006-0554)

Oleg Nesterov:
      sys_signal: initialize ->sa_mask
      do_sigaction: cleanup ->sa_mask manipulation
      fix zap_thread's ptrace related problems

Peter Staubach:
      fix deadlock in ext2

Simon Vogl:
      cfi: init wait queue in chip struct

Stefan Richter:
      sd: fix memory corruption with broken mode page headers
      sbp2: fix another deadlock after disconnection

Stephen Hemminger:
      skge: speed setting
      skge: fix NAPI/irq race
      skge: genesis phy initialization fix
      skge: fix SMP race

Suresh Siddha:
      x86_64: Check for bad elf entry address (CVE-2006-0741)

Takashi Iwai:
      alsa: fix bogus snd_device_free() in opl3-oss.c

Tom Rini:
      ppc32: Put cache flush routines back into .relocate_code section

Tony Luck:
      sys32_signal() forgets to initialize ->sa_mask

Trond Myklebust:
      Normal user can panic NFS client with direct I/O (CVE-2006-0555)

