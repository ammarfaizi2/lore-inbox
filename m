Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWFRLt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWFRLt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWFRLt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:49:29 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:16575 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932192AbWFRLt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:49:29 -0400
X-IronPort-AV: i="4.06,146,1149490800"; 
   d="scan'208"; a="1827795909:sNHT34004212"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 18 Jun 2006 04:49:25 -0700
Message-ID: <adawtbesmyi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Jun 2006 11:49:27.0768 (UTC) FILETIME=[40AD2D80:01C692CD]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

Opening the floodgates for 2.6.18:

Ganapathi CH:
      IB/uverbs: Release lock on error path

Ishai Rabinovitz:
      IB/srp: Clean up loop in srp_remove_one()
      IB/srp: Handle DREQ events from CM
      IB/srp: Factor out common request reset code

Jack Morgenstein:
      IB: Add caching of ports' LMC
      IB/mad: Check GID/LID when matching requests
      IPoIB: Fix kernel unaligned access on ia64

Leonid Arsh:
      IB: Add client reregister event type
      IPoIB: Handle client reregister events
      IB: Move struct port_info from ipath to <rdma/ib_smi.h>
      IB/mthca: Add client reregister event generation

Matthew Wilcox:
      IB/srp: Use SCAN_WILD_CARD from SCSI headers
      IB/srp: Get rid of unneeded use of list_for_each_entry_safe()
      IB/srp: Change target_mutex to a spinlock

Michael S. Tsirkin:
      IB/mthca: restore missing PCI registers after reset
      IB/mthca: memfree completion with error FW bug workaround
      IB/mthca: Remove dead code
      IB/cm: remove unneeded flush_workqueue

Or Gerlitz:
      IB/mthca: Fill in max_map_per_fmr device attribute
      IB/fmr: Use device's max_map_map_per_fmr attribute in FMR pool.

Ramachandra K:
      [SCSI] srp.h: Add I/O Class values
      IB/srp: Support SRP rev. 10 targets

Roland Dreier:
      IB/srp: Use FMRs to map gather/scatter lists
      IB/mthca: Convert FW commands to use wait_for_completion_timeout()
      IB: Make needlessly global ib_mad_cache static
      IPoIB: Mention RFC numbers in documentation
      IB/srp: Get rid of "Target has req_lim 0" messages
      IPoIB: Avoid using stale last_send counter when reaping AHs
      IB/ipath: Add client reregister event generation
      IB/uverbs: Don't decrement usecnt on error paths
      IB/uverbs: Factor out common idr code
      IB/mthca: Fix memory leak on modify_qp error paths
      IB/mthca: Make all device methods truly reentrant
      IB/uverbs: Don't serialize with ib_uverbs_idr_mutex

Sean Hefty:
      IB: common handling for marshalling parameters to/from userspace
      IB/cm: Match connection requests based on private data
      [NET]: Export ip_dev_find()
      IB: address translation to map IP toIB addresses (GIDs)
      IB: IP address based RDMA connection manager
      IB/ucm: convert semaphore to mutex
      IB/ucm: Get rid of duplicate P_Key parameter
      IB: Add ib_init_ah_from_wc()
      IB/sa: Add ib_init_ah_from_path()
      IB/cm: Use address handle helpers

Vu Pham:
      IB/srp: Allow cmd_per_lun to be set per target port
      IB/srp: Allow sg_tablesize to be adjusted

 Documentation/infiniband/ipoib.txt             |   12 
 drivers/infiniband/Kconfig                     |    5 
 drivers/infiniband/core/Makefile               |   11 
 drivers/infiniband/core/addr.c                 |  367 +++++
 drivers/infiniband/core/cache.c                |   30 
 drivers/infiniband/core/cm.c                   |  119 +
 drivers/infiniband/core/cma.c                  | 1927 ++++++++++++++++++++++++
 drivers/infiniband/core/fmr_pool.c             |   30 
 drivers/infiniband/core/mad.c                  |   97 +
 drivers/infiniband/core/mad_priv.h             |    2 
 drivers/infiniband/core/sa_query.c             |   31 
 drivers/infiniband/core/ucm.c                  |  183 +-
 drivers/infiniband/core/uverbs.h               |    4 
 drivers/infiniband/core/uverbs_cmd.c           |  971 +++++++-----
 drivers/infiniband/core/uverbs_main.c          |   35 
 drivers/infiniband/core/uverbs_marshall.c      |  138 ++
 drivers/infiniband/core/verbs.c                |   44 -
 drivers/infiniband/hw/ipath/ipath_mad.c        |   42 -
 drivers/infiniband/hw/mthca/mthca_cmd.c        |   23 
 drivers/infiniband/hw/mthca/mthca_cq.c         |   12 
 drivers/infiniband/hw/mthca/mthca_eq.c         |    4 
 drivers/infiniband/hw/mthca/mthca_mad.c        |   14 
 drivers/infiniband/hw/mthca/mthca_provider.c   |   33 
 drivers/infiniband/hw/mthca/mthca_provider.h   |    3 
 drivers/infiniband/hw/mthca/mthca_qp.c         |   40 
 drivers/infiniband/hw/mthca/mthca_reset.c      |   59 +
 drivers/infiniband/hw/mthca/mthca_srq.c        |    5 
 drivers/infiniband/ulp/ipoib/ipoib.h           |   34 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   27 
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   28 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   11 
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    3 
 drivers/infiniband/ulp/srp/ib_srp.c            |  482 ++++--
 drivers/infiniband/ulp/srp/ib_srp.h            |   33 
 include/rdma/ib_addr.h                         |  114 +
 include/rdma/ib_cache.h                        |   13 
 include/rdma/ib_cm.h                           |   26 
 include/rdma/ib_marshall.h                     |   50 +
 include/rdma/ib_sa.h                           |    7 
 include/rdma/ib_smi.h                          |   36 
 include/rdma/ib_user_cm.h                      |   86 -
 include/rdma/ib_user_sa.h                      |   60 +
 include/rdma/ib_user_verbs.h                   |   80 +
 include/rdma/ib_verbs.h                        |   22 
 include/rdma/rdma_cm.h                         |  256 +++
 include/rdma/rdma_cm_ib.h                      |   47 +
 include/scsi/srp.h                             |    5 
 net/ipv4/fib_frontend.c                        |    1 
 48 files changed, 4590 insertions(+), 1072 deletions(-)
 create mode 100644 drivers/infiniband/core/addr.c
 create mode 100644 drivers/infiniband/core/cma.c
 create mode 100644 drivers/infiniband/core/uverbs_marshall.c
 create mode 100644 include/rdma/ib_addr.h
 create mode 100644 include/rdma/ib_marshall.h
 create mode 100644 include/rdma/ib_user_sa.h
 create mode 100644 include/rdma/rdma_cm.h
 create mode 100644 include/rdma/rdma_cm_ib.h
