Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVHDRe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVHDRe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVHDRdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:33:04 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:65187 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261487AbVHDRc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:32:27 -0400
X-IronPort-AV: i="3.95,167,1120460400"; 
   d="scan'208"; a="202753960:sNHT1137745554"
To: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [RFC] Move InfiniBand .h files
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 10:32:14 -0700
Message-ID: <52iryla9r5.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 17:32:15.0877 (UTC) FILETIME=[74DD0B50:01C5991A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to get people's reactions to moving the InfiniBand .h
files from their current location in drivers/infiniband/include/ to
include/linux/rdma/.  If we agree that this is a good idea then I'll
push this change as soon as 2.6.14 starts.

The advantages of doing this are:

  - The headers become more easily accessible to other parts of the
    tree that might want to use IB support.  For example, an NFS/RDMA
    client probably wants to live under fs/
  - It makes it easier to build IB modules outside the tree, since
    include/linux gets put in /lib/modules/<ver>/build.  I realize
    that we don't really care about out-of-tree modules, but it is
    convenient to be able to develop and distribute new drivers that
    build against someone's existing kernels.
  - We can kill off the ugly

        EXTRA_CFLAGS += -Idrivers/infiniband/include

    lines in our Makefiles.

The disadvantages are:

  - It's churn with little technical merit.
  - It makes it a little harder to pull the OpenIB svn tree into a
    kernel tree, since one would have to link both drivers/infiniband
    and include/linux/rdma instead of just drivers/infiniband.  This
    problem goes away if/when OpenIB shifts over to a new source code
    control system.

Thanks,
  Roland
