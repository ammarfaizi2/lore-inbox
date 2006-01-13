Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423070AbWAMW52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423070AbWAMW52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423073AbWAMW52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:57:28 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:60006 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1423070AbWAMW51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:57:27 -0500
X-IronPort-AV: i="3.99,366,1131350400"; 
   d="scan'208"; a="391640018:sNHT44725423968"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] IB changes for 2.6.16-rc1
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 13 Jan 2006 14:57:03 -0800
Message-ID: <ada64on4tz4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 13 Jan 2006 22:57:04.0301 (UTC) FILETIME=[ABCA0DD0:01C61894]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Eli Cohen:
      IPoIB: Fix error path in ipoib_mcast_dev_flush()
      IPoIB: Fix address handle refcounting for multicast groups
      IPoIB: Fix memory leak of multicast group structures

Ingo Molnar:
      IB: convert from semaphores to mutexes

Ishai Rabinovitz:
      IB/mthca: Fix memory leak of multicast group structures

Jack Morgenstein:
      IB/mthca: Fix memory leaks in error handling

Michael S. Tsirkin:
      IB/mthca: fix page shift calculation in mthca_reg_phys_mr()
      IB/mthca: prevent event queue overrun
      IPoIB: Take dev->xmit_lock around mc_list accesses
      IB/mthca: Cosmetic: use the ALIGN macro
      IB/mthca: Initialize grh_present before using it

Roland Dreier:
      IB/mthca: kzalloc conversions
      IB/mthca: Factor common MAD initialization code

Sean Hefty:
      IB: Add node_guid to struct ib_device

 drivers/infiniband/core/cm.c                   |   29 +----
 drivers/infiniband/core/device.c               |   23 ++--
 drivers/infiniband/core/sysfs.c                |   22 +--
 drivers/infiniband/core/ucm.c                  |   23 ++--
 drivers/infiniband/core/uverbs.h               |    5 -
 drivers/infiniband/core/uverbs_cmd.c           |  152 ++++++++++++------------
 drivers/infiniband/core/uverbs_main.c          |    8 +
 drivers/infiniband/hw/mthca/mthca_av.c         |   10 +-
 drivers/infiniband/hw/mthca/mthca_cmd.c        |    7 +
 drivers/infiniband/hw/mthca/mthca_dev.h        |    1 
 drivers/infiniband/hw/mthca/mthca_eq.c         |   28 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c   |  132 ++++++++++++---------
 drivers/infiniband/hw/mthca/mthca_qp.c         |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h           |    6 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   31 ++---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   12 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |  105 +++++------------
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    8 +
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |   10 +-
 drivers/infiniband/ulp/srp/ib_srp.c            |   23 +---
 include/rdma/ib_verbs.h                        |    2 
 21 files changed, 287 insertions(+), 352 deletions(-)
