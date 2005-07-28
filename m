Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVG1UgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVG1UgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVG1Udw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:33:52 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:23839 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262220AbVG1UcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:32:07 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 0/2] REALLY final InfiniBand updates for 2.6.13
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Thu, 28 Jul 2005 13:31:45 -0700
Message-Id: <20057281331.dR47KhjBsU48JfGE@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 28 Jul 2005 20:31:56.0757 (UTC) FILETIME=[65E08850:01C593B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two last-minute fixes for InfiniBand: one to avoid pain in
releasing 2.6.13 with an incorrect constant and then having to rename
the enum later, and one to fix RARP on IP-over-InfiniBand.

After Greg's scolding, I'm sending them as patches, but they're also
available in the git tree at

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

(pending mirror propagation)

The patches update the following files:

 include/ib_cm.h        |    3 ++-
 ulp/ipoib/ipoib_main.c |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

through the following changes:

commit 0dca0f7bf82face7b700890318d5550fd542cabf
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Thu Jul 28 13:17:26 2005 -0700

    [PATCH] [IPoIB] Handle sending of unicast RARP responses
    
    RARP replies are another valid case where IPoIB may need to send a
    unicast packet with no neighbour structure.
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 4e38d36d88ead4e56f3155573976da84d5df18b3
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Thu Jul 28 13:16:30 2005 -0700

    [PATCH] [IB/cm]: Correct CM port redirect reject codes
    
    Reject code 24 is port and CM redirection, not just port redirection.
    Port redirection alone is code 25.
    
    Therefore we should rename code 24 to IB_CM_REJ_PORT_CM_REDIRECT and
    use IB_CM_REJ_PORT_REDIRECT for code 25.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

Thanks,
  Roland
