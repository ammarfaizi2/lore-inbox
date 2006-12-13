Return-Path: <linux-kernel-owner+w=401wt.eu-S1751578AbWLMRqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWLMRqw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWLMRqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:46:52 -0500
Received: from mga03.intel.com ([143.182.124.21]:4068 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbWLMRqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:46:51 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 12:46:50 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="157779198:sNHT39373096"
Date: Wed, 13 Dec 2006 09:37:04 -0800
Message-Id: <200612131737.kBDHb47D013437@agluck-lia64.sc.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Ralph Campbell <ralph.campbell@qlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: sg_dma_address and sg_dma_len
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph,

I'm seeing dozens of build warnings and errors on ia64 from
infiniband.  According to git you touched it last, so even
if you aren't to blame, you are by definition an expert :-)

E.g.

In file included from include/rdma/ib_addr.h:37,
                 from drivers/infiniband/core/addr.c:39:
include/rdma/ib_verbs.h: In function `ib_sg_dma_address':
include/rdma/ib_verbs.h:1572: warning: implicit declaration of function `sg_dma_address'
include/rdma/ib_verbs.h: In function `ib_sg_dma_len':
include/rdma/ib_verbs.h:1584: warning: implicit declaration of function `sg_dma_len'

Adding a #include <linux/pci.h> would shut them up (as the defines for
sg_dma_address and sg_dma_len are in asm/pci.h) ... but I've no idea
whether this is the right fix.

-Tony
