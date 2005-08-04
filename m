Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVHDQGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVHDQGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVHDQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:06:36 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42940 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262599AbVHDQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:04:45 -0400
X-IronPort-AV: i="3.95,167,1120460400"; 
   d="scan'208"; a="202719411:sNHT31016898"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] REALLY final InfiniBand updates for 2.6.13
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 09:04:28 -0700
Message-ID: <52vf2ladtf.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 16:04:29.0999 (UTC) FILETIME=[3227D3F0:01C5990E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two small last-minute fixes for InfiniBand I would like to
get into 2.6.13: one to avoid pain in releasing 2.6.13 with an
incorrect enum definition that we have to rename later, and one to fix
RARP on IP-over-InfiniBand.

If there's still time before 2.6.13, please pull from

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

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
