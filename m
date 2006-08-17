Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWHQUOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWHQUOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWHQUOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:14:30 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:4779 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1030258AbWHQUOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:14:04 -0400
X-IronPort-AV: i="4.08,139,1154934000"; 
   d="scan'208"; a="312148577:sNHT32781260"
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: InfiniBand merge plans for 2.6.19
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 17 Aug 2006 13:13:57 -0700
Message-ID: <adawt9786ii.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Aug 2006 20:13:59.0108 (UTC) FILETIME=[AC961840:01C6C239]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a short summary of what I plan to merge for 2.6.19.  Some of
this is already in infiniband.git[1], while some still needs to be
merged up.  Highlights:

    o  iWARP core support[2].  This updates drivers/infiniband to work
       with devices that do RDMA over IP/ethernet in addition to
       InfiniBand devices.  As a first user of this support, I also
       plan to merge the amso1100[3] driver for Ammasso RNIC.

       I will post this for review one more time after I pull it into
       my git tree for last minute cleanups.  But if you feel this
       iWARP support should not be merged, please let me know why now.

    o  IBM eHCA driver, which supports IBM pSeries-specific InfiniBand
       hardware.  This is in the ehca branch of infiniband.git, and I
       will post it for review one more time.  My feeling is that more
       cleanups are certainly possible, but this driver is "good
       enough to merge" now and has languished out of tree for long
       enough.  I'm certainly happy to merge cleanup patches, though.

    o  mmap()ed userspace work queues for ipath.  This is a
       performance enhancement for QLogic/PathScale HCAs but it does
       touch core stuff in minor ways.  Should not be controversial.

    o  I also have the following minor changes queued in the
       for-2.6.19 branch of infiniband.git:

       Ishai Rabinovitz:
             IB/srp: Add port/device attributes

       James Lentini:
             IB/mthca: Include the header we really want

       Michael S. Tsirkin:
             IB/mthca: Don't use privileged UAR for kernel access
             IB/ipoib: Fix flush/start xmit race (from code review)
       
       Roland Dreier:
             IB/uverbs: Use idr_read_cq() where appropriate
             IB/uverbs: Fix lockdep warning when QP is created with 2 CQs

[1]  git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git
[2]  http://thread.gmane.org/gmane.linux.network/40903
[3]  http://thread.gmane.org/gmane.linux.drivers.openib/28657
