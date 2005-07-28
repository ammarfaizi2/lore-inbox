Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVG1EUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVG1EUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 00:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVG1EUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 00:20:50 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:27780 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261154AbVG1EUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 00:20:48 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] Final InfiniBand updates for 2.6.13
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 27 Jul 2005 21:20:08 -0700
Message-ID: <52hdefsgsn.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jul 2005 04:20:19.0906 (UTC) FILETIME=[AA3F0220:01C5932B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This will update the following files:

 core/ucm.c                |   88 +++++++++++++++++++++-------------------------
 core/uverbs.h             |    1 
 core/uverbs_main.c        |   14 ++++++-
 hw/mthca/mthca_cq.c       |    6 ++-
 hw/mthca/mthca_provider.c |    6 +--
 ulp/ipoib/ipoib_ib.c      |    6 +--
 6 files changed, 66 insertions(+), 55 deletions(-)

through the following changes:

commit 79d81907594e1ec4d5171653dde7cb9e9cb87de2
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Wed Jul 27 20:38:56 2005 -0700

    [IB/ucm]: Clean up userspace CM
    
    Only print debug messages when debug_level is set.
    Eliminate NULL checks prior to calling kfree.
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Libor Michalek <libor@topspin.com>

commit 6d376756f2cf3478d5a4fdb8d18e958948366b9d
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Wed Jul 27 14:42:45 2005 -0700

    [IB/mthca]: Use io_remap_pfn_range for PCI space
    
    Use io_remap_pfn_range to remap IO pages (remap_pfn_range is for memory).
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2181858bb814b51de8ec25b3ddd37cd06c53b0c9
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Wed Jul 27 14:41:32 2005 -0700

    [IB/ipoib]: Fix unsigned comparisons to handle wraparound
    
    Fix handling of tx_head/tx_tail comparisons to handle wraparound.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit abdf119b4dad015803819c3d046d20cfbd393e87
Author: Gleb Natapov <glebn@voltaire.com>
Date:   Wed Jul 27 14:40:00 2005 -0700

    [IB/uverbs]: Add O_ASYNC support
    
    Add support for O_ASYNC notifications on userspace verbs
    completion and asynchronous event file descriptors.
    
    Signed-off-by: Gleb Natapov <glebn@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 42b1806d5cfc93bf8c3d7fa6e9e79e4ec860c678
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Wed Jul 27 14:38:49 2005 -0700

    [IB/mthca]: Fix error CQ entry handling on mem-free HCAs
    
    Fix handling of error CQ entries on mem-free HCAs: the doorbell count
    is never valid so we shouldn't look at it.  This fixes problems exposed
    by new HCA firmware.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>
