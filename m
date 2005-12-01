Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbVLAKL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbVLAKL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbVLAKL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:11:58 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:63895 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751683AbVLAKL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:11:57 -0500
Message-Id: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/12] Balancing the scan rate of major caches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch balances the aging rates of active_list/inactive_list/slab.

It started out as an effort to enable the adaptive read-ahead to handle large
number of concurrent readers. Then I found it involves much more stuffs, and
deserves a standalone patchset to address the balancing problem as a whole.


The whole picture of balancing:

- In each node, inactive_list scan rates are synced with each other.
  It is done in the direct/kswapd reclaim path.

- In each zone, active_list scan rate always follows that of inactive_list.

- Slab cache scan rates always follow that of the current node.
  If the shrinkers are not NUMA aware, they will effectly sync scan rates
  with that of the most scanned node.


The patches can be grouped as follows:

- balancing stuffs
vm-kswapd-incmin.patch
mm-balance-zone-aging-supporting-facilities.patch
mm-balance-zone-aging-in-direct-reclaim.patch
mm-balance-zone-aging-in-kswapd-reclaim.patch
mm-balance-slab-aging.patch
mm-balance-active-inactive-list-aging.patch

- pure code cleanups
mm-remove-unnecessary-variable-and-loop.patch
mm-remove-swap-cluster-max-from-scan-control.patch
mm-accumulate-nr-scanned-reclaimed-in-scan-control.patch
mm-turn-bool-variables-into-flags-in-scan-control.patch

- debug code
mm-page-reclaim-debug-traces.patch

- a minor fix
mm-scan-accounting-fix.patch

Thanks,
Wu Fengguang

-- 
Dept. Automation                University of Science and Technology of China
