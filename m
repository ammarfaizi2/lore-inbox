Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWI1SUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWI1SUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWI1SUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:20:21 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:25912 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1030342AbWI1SUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:20:19 -0400
X-IronPort-AV: i="4.09,231,1157353200"; 
   d="scan'208"; a="343698368:sNHT56892180"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] Please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 28 Sep 2006 11:20:16 -0700
Message-ID: <adabqoz4zvj.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Sep 2006 18:20:17.0801 (UTC) FILETIME=[C01EBF90:01C6E32A]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This will merge:
 - ipath updates
 - iSER updates
 - a few of amso1100 Coverity fixes and warning cleanups

Bryan O'Sullivan:
      IB/ipath: Limit # of packets sent without an ACK received
      IB/ipath: Fix memory leak if allocation fails
      IB/ipath: Driver support for userspace sharing of HW contexts
      IB/ipath: Support revision 2 InfiniPath PCIE devices
      IB/ipath: Unregister from IB core early
      IB/ipath: Clean up handling of GUID 0
      IB/ipath: Lock and count allocated CQs properly
      IB/ipath: Count SRQs properly
      IB/ipath: Only allow complete writes to flash
      IB/ipath: RC and UC should validate SLID and DLID
      IB/ipath: Ensure that PD of MR matches PD of QP checking the Rkey
      IB/ipath: Print more informative parity error messages
      IB/ipath: Fix compiler warnings and errors on non-x86_64 systems
      IB/ipath: Fix mismatch in shifts and masks for printing debug info
      IB/ipath: Support multiple simultaneous devices of different types
      IB/ipath: Drop unnecessary "(void *)" casts
      IB/ipath: Improved support for PowerPC
      IB/ipath: Flush RWQEs if access error or invalid error seen
      IB/ipath: Call mtrr_del with correct arguments
      IB/ipath: Clean up module exit code
      IB/ipath: Change HT CRC message to indicate how to resolve problem
      IB/ipath: Fix and recover TXE piobuf and PBC parity errors
      IB/ipath: Fix EEPROM read when driver is compiled with -Os
      IB/ipath: Set CPU affinity early
      IB/ipath: Support new PCIE device, QLE7142
      IB/ipath: Fix races with ib_resize_cq()
      IB/ipath: Fix lockdep error upon "ifconfig ibN down"

Erez Zilber:
      IB/iser: Have iSER data transaction object point to iSER conn
      IB/iser: DMA unmap unaligned for RDMA data before touching it
      IB/iser: Fix the description of iSER in Kconfig

Eric Sesterhenn:
      RDMA/amso1100: Fix error path in c2_llp_accept()

Roland Dreier:
      RDMA/amso1100: Fix compile warnings
      RDMA/amso1100: Fix memory leak in c2_reg_phys_mr()

 drivers/infiniband/hw/amso1100/c2_ae.c         |    2 
 drivers/infiniband/hw/amso1100/c2_alloc.c      |    2 
 drivers/infiniband/hw/amso1100/c2_cm.c         |   15 
 drivers/infiniband/hw/amso1100/c2_provider.c   |    8 
 drivers/infiniband/hw/amso1100/c2_rnic.c       |    4 
 drivers/infiniband/hw/ipath/ipath_common.h     |   54 +
 drivers/infiniband/hw/ipath/ipath_cq.c         |   48 +
 drivers/infiniband/hw/ipath/ipath_driver.c     |  359 ++++-----
 drivers/infiniband/hw/ipath/ipath_eeprom.c     |   17 
 drivers/infiniband/hw/ipath/ipath_file_ops.c   |  974 ++++++++++++++++++------
 drivers/infiniband/hw/ipath/ipath_fs.c         |    9 
 drivers/infiniband/hw/ipath/ipath_iba6110.c    |  132 ++-
 drivers/infiniband/hw/ipath/ipath_iba6120.c    |  263 ++++--
 drivers/infiniband/hw/ipath/ipath_init_chip.c  |   56 +
 drivers/infiniband/hw/ipath/ipath_intr.c       |  280 +++++--
 drivers/infiniband/hw/ipath/ipath_kernel.h     |  116 +++
 drivers/infiniband/hw/ipath/ipath_keys.c       |   12 
 drivers/infiniband/hw/ipath/ipath_mad.c        |   16 
 drivers/infiniband/hw/ipath/ipath_mr.c         |    3 
 drivers/infiniband/hw/ipath/ipath_qp.c         |   16 
 drivers/infiniband/hw/ipath/ipath_rc.c         |   77 +-
 drivers/infiniband/hw/ipath/ipath_registers.h  |   40 +
 drivers/infiniband/hw/ipath/ipath_ruc.c        |   14 
 drivers/infiniband/hw/ipath/ipath_srq.c        |   23 -
 drivers/infiniband/hw/ipath/ipath_sysfs.c      |   21 -
 drivers/infiniband/hw/ipath/ipath_uc.c         |    6 
 drivers/infiniband/hw/ipath/ipath_ud.c         |    6 
 drivers/infiniband/hw/ipath/ipath_user_pages.c |   56 +
 drivers/infiniband/hw/ipath/ipath_verbs.c      |   43 +
 drivers/infiniband/hw/ipath/ipath_verbs.h      |   18 
 drivers/infiniband/hw/ipath/ipath_wc_ppc64.c   |   20 
 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c  |   13 
 drivers/infiniband/ulp/iser/Kconfig            |   13 
 drivers/infiniband/ulp/iser/iscsi_iser.c       |    2 
 drivers/infiniband/ulp/iser/iscsi_iser.h       |    9 
 drivers/infiniband/ulp/iser/iser_initiator.c   |   60 -
 drivers/infiniband/ulp/iser/iser_memory.c      |   42 +
 drivers/infiniband/ulp/iser/iser_verbs.c       |    8 
 38 files changed, 1973 insertions(+), 884 deletions(-)
