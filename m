Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936052AbWK1TpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936052AbWK1TpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936058AbWK1TpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:45:21 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:9991 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S936052AbWK1TpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:45:20 -0500
To: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: What's in infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 28 Nov 2006 11:45:16 -0800
Message-ID: <aday7pvtkxf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Nov 2006 19:45:17.0325 (UTC) FILETIME=[BADF1BD0:01C71325]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Linus hinted that 2.6.19 is very near, I thought it would be a
good idea to say what I have queued for 2.6.20.  And it turns out that
I really don't have anything all that interesting.  Basically, I just
have a pile of fixes and cleanups all over drivers/infiniband.  The
most obvious thing is that Krishna Kumar did a lot of work fixing up
iWARP-related stuff, but there's stuff in ehca, mthca, IPoIB and SRP
and probably other places too.

If you have something you want to merge for 2.6.20 that goes beyond
a fix, please get it to me ASAP.  If it's a fix, don't sit on it
either -- we might as well merge it early.

The detailed list of patches and stats are:

Arne Redlich (1):
      IB/srp: Increase supported CDB size

Dotan Barak (1):
      RDMA/cm: Remove setting local write as part of QP access flags

Eric Sesterhenn (1):
      IB: kmemdup() cleanup

Hoang-Nam Nguyen (1):
      IB/ehca: Use WQE offset instead of WQE addr for pending work reqs

Jack Morgenstein (1):
      IB/mthca: Fix initial SRQ logsize for mem-free HCAs

Krishna Kumar (11):
      RDMA/cma: Optimize cma_bind_loopback() to check for empty list
      RDMA/cma: Remove redundant check in cma_add_one
      RDMA/addr: Use time_after_eq() instead of time_after() in queue_req()
      RDMA/cma: Rewrite cma_req_handler() to encapsulate common code
      RDMA/iwcm: Fix memory corruption bug in cm_work_handler()
      RDMA/iwcm: Fix memory leak
      RDMA/iwcm: Remove unnecessary initializations
      RDMA/iwcm: Remove unnecessary function argument
      RDMA/iwcm: Fix comment for iwcm_deref_id() to match code
      RDMA/amso1100: Prevent deadlock in destroy QP
      RDMA/addr: Fix some cancellation problems in process_req()

Michael S. Tsirkin (1):
      IPoIB: Fix skb leak when freeing neighbour

Roland Dreier (5):
      IB/mthca: Fix section mismatches
      RDMA/amso1100: Fix section mismatches
      IB/ipath: Fix typo in pma_counter_select subscript
      IB: Convert kmem_cache_t -> struct kmem_cache
      RDMA/addr: list_move() cleanups

Vu Pham (1):
      IB/srp: Fix memory leak on reconnect


 drivers/infiniband/core/addr.c                 |   19 ++++-----
 drivers/infiniband/core/cm.c                   |    6 +--
 drivers/infiniband/core/cma.c                  |   49 ++++++++++-------------
 drivers/infiniband/core/iwcm.c                 |   43 +++++++++++----------
 drivers/infiniband/core/mad.c                  |    2 +-
 drivers/infiniband/core/ucm.c                  |    6 +--
 drivers/infiniband/hw/amso1100/c2.h            |    2 +-
 drivers/infiniband/hw/amso1100/c2_qp.c         |   36 +++++++++++++----
 drivers/infiniband/hw/amso1100/c2_rnic.c       |    4 +-
 drivers/infiniband/hw/ehca/ehca_main.c         |    4 +-
 drivers/infiniband/hw/ehca/ehca_qp.c           |   22 ++++------
 drivers/infiniband/hw/ehca/ipz_pt_fn.c         |   13 ++++++
 drivers/infiniband/hw/ehca/ipz_pt_fn.h         |   15 +++++++
 drivers/infiniband/hw/ipath/ipath_verbs.c      |    2 +-
 drivers/infiniband/hw/mthca/mthca_av.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_cq.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_eq.c         |   21 +++++-----
 drivers/infiniband/hw/mthca/mthca_mad.c        |    2 +-
 drivers/infiniband/hw/mthca/mthca_main.c       |   29 +++++++-------
 drivers/infiniband/hw/mthca/mthca_mcg.c        |    3 +-
 drivers/infiniband/hw/mthca/mthca_mr.c         |    5 +-
 drivers/infiniband/hw/mthca/mthca_pd.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_provider.c   |    3 +-
 drivers/infiniband/hw/mthca/mthca_qp.c         |    3 +-
 drivers/infiniband/hw/mthca/mthca_srq.c        |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib.h           |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   19 ++++++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h       |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.c            |   11 +++--
 30 files changed, 185 insertions(+), 153 deletions(-)
