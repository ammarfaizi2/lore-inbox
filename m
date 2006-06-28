Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWF1Sfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWF1Sfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWF1Sfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:35:37 -0400
Received: from mga03.intel.com ([143.182.124.21]:49446 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750830AbWF1Sfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:35:36 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="58771559:sNHT56581046900"
Subject: [PATCH 000 of 006] raid5: Offload RAID operations to a workqueue
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:23:52 -0700
Message-Id: <1151519032.2232.62.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is a step towards enabling hardware offload in the
md-raid5 driver.  These patches are considered experimental and are not
yet suitable for production environments.

As mentioned, this patch set is the first step in that it moves work
from handle_stripe5 to a work queue.  The next step is to enable the
work queue to offload the operations to hardware copy/xor engines using
the dmaengine API (include/linux/dmaengine.h).  Initial testing shows
that about 60% of the array maintenance work previously performed by
raid5d has moved to the work queue.

These patches apply to the version of md as of commit 
266bee88699ddbde42ab303bbc426a105cc49809 in Linus' tree.

Regards,

Dan Williams

[PATCH 001 of 006] raid5: Move write operations to a work queue
[PATCH 002 of 006] raid5: Move check parity operations to a work queue
[PATCH 003 of 006] raid5: Move compute block operations to a work queue
[PATCH 004 of 006] raid5: Move read completion copies to a work queue
[PATCH 005 of 006] raid5: Move expansion operations to a work queue
[PATCH 006 of 006] raid5: Remove compute_block and compute_parity
