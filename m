Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVJ1Xk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJ1Xk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVJ1Xk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:40:56 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:27001 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750780AbVJ1Xk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:40:56 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand updates for 2.6.14
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 28 Oct 2005 16:40:47 -0700
Message-ID: <523bmlqkg0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Oct 2005 23:40:48.0681 (UTC) FILETIME=[063BE990:01C5DC19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Jack Morgenstein:
  [IB] Add checks to multicast attach and detach
  [IB] mthca: Report correct atomic capability
  [IB] mthca: Fill in more fields in query_port method
  [IB] mthca: Better limit checking and reporting
  [IB] mthca: Don't enter QP into MCG more than once.

Roland Dreier:
  [IB] uverbs: ABI-breaking fixes for userspace verbs
  [IB] uverbs: Fix up resource creation error paths
  [IB] uverbs: Add device-specific ABI version attribute
  [IB] uverbs: reject invalid memory registration permission flags
  [IB] Check port number in ib_query_port()/ib_modify_port()
  [IB] mthca: SRQ limit reached events
  [IB] mthca: detect SRQ overflow
  [IB] Fix leak on MAD initialization failure
  [IPoIB] Rename ipoib_create_qp() -> ipoib_init_qp() and fix error cleanup
  [IB] uverbs: unlock correctly in error paths
  [IB] fail SA queries if device initialization failed
  [IB] uverbs: Add a mask of device methods allowed for userspace
  [IB] uverbs: Add ABI structures for more commands
  [IB] uverbs: Implement more commands
  [IB] ucm: quiet sparse warnings
  [IPoIB] Improve ipoib_timeout() output
  [IB] mthca: Use enum in mthca_alloc_db() prototype
  [IB] mthca: Add struct pci_driver.owner field
  [IB] Fail sysfs queries after device is unregistered
  [IB] cm: Add missing break in switch
  [IB] user_mad: trivial coding style fixes
  [IB] user_mad: Use class_device.devt
  [IB] mthca: Always re-arm EQs in mthca_tavor_interrupt()
  Merge master.kernel.org:/.../torvalds/linux-2.6
  [IB] Add idr_destroy() calls on module unload
  Manual merge of for-linus to upstream (fix conflicts in drivers/infiniband/core/ucm.c)
  [IB] mthca: correct modify QP attribute masks for UC
  [IB] simplify mad_rmpp.c:alloc_response_msg()
  [IB] mthca: first pass at catastrophic error reporting
  [IB] ib_umad: fix crash when freeing send buffers
  [IPoIB] Drop RX packets when out of memory
  [IB] umad: Fix device lifetime problems
  [IB] uverbs: Fix device lifetime problems
  Merge master.kernel.org:/.../torvalds/linux-2.6
  [IB] fix up class_device_create() calls

Sean Hefty:
  [IB] merge ucm.h into ucm.c
  [IB] CM: bind IDs to a specific device
  [IB] CM: Fix initialization of QP attributes for UC QPs.
  [IB] Fix MAD layer DMA mappings to avoid touching data buffer once mapped
  [IB] ib_umad: various cleanups

 drivers/infiniband/core/agent.c              |  301 ++-------
 drivers/infiniband/core/agent.h              |   13 
 drivers/infiniband/core/agent_priv.h         |   62 --
 drivers/infiniband/core/cm.c                 |  217 +++----
 drivers/infiniband/core/cm_msgs.h            |    1 
 drivers/infiniband/core/device.c             |   12 
 drivers/infiniband/core/mad.c                |  329 +++++-----
 drivers/infiniband/core/mad_priv.h           |    8 
 drivers/infiniband/core/mad_rmpp.c           |  112 ++-
 drivers/infiniband/core/mad_rmpp.h           |    2 
 drivers/infiniband/core/sa_query.c           |  272 ++++----
 drivers/infiniband/core/smi.h                |    2 
 drivers/infiniband/core/sysfs.c              |   16 
 drivers/infiniband/core/ucm.c                |  267 ++++++--
 drivers/infiniband/core/ucm.h                |   83 ---
 drivers/infiniband/core/user_mad.c           |  403 ++++++------
 drivers/infiniband/core/uverbs.h             |   62 +-
 drivers/infiniband/core/uverbs_cmd.c         |  858 +++++++++++++++++++++-----
 drivers/infiniband/core/uverbs_main.c        |  503 ++++++++++-----
 drivers/infiniband/core/verbs.c              |   18 -
 drivers/infiniband/hw/mthca/Makefile         |    3 
 drivers/infiniband/hw/mthca/mthca_catas.c    |  153 +++++
 drivers/infiniband/hw/mthca/mthca_cmd.c      |   11 
 drivers/infiniband/hw/mthca/mthca_dev.h      |   22 +
 drivers/infiniband/hw/mthca/mthca_eq.c       |   21 +
 drivers/infiniband/hw/mthca/mthca_mad.c      |   72 --
 drivers/infiniband/hw/mthca/mthca_main.c     |   11 
 drivers/infiniband/hw/mthca/mthca_mcg.c      |   11 
 drivers/infiniband/hw/mthca/mthca_memfree.c  |    3 
 drivers/infiniband/hw/mthca/mthca_memfree.h  |    3 
 drivers/infiniband/hw/mthca/mthca_provider.c |   49 +
 drivers/infiniband/hw/mthca/mthca_qp.c       |   16 
 drivers/infiniband/hw/mthca/mthca_srq.c      |   43 +
 drivers/infiniband/hw/mthca/mthca_user.h     |    6 
 drivers/infiniband/ulp/ipoib/ipoib.h         |   23 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c      |  122 ++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c    |   15 
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c   |    9 
 include/rdma/ib_cm.h                         |   10 
 include/rdma/ib_mad.h                        |   66 +-
 include/rdma/ib_user_cm.h                    |   10 
 include/rdma/ib_user_verbs.h                 |  222 +++++--
 include/rdma/ib_verbs.h                      |    6 
 43 files changed, 2675 insertions(+), 1773 deletions(-)
 delete mode 100644 drivers/infiniband/core/agent_priv.h
 delete mode 100644 drivers/infiniband/core/ucm.h
 create mode 100644 drivers/infiniband/hw/mthca/mthca_catas.c
