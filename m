Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVILTyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVILTyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVILTyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:54:50 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:48393 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932180AbVILTys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:54:48 -0400
Date: Mon, 12 Sep 2005 15:53:56 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Grant Grundler <iod00d@hp.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
       Asit.K.Mallick@intel.com
Subject: [patch 2.6.13] swiotlb: BUG() for DMA_NONE in sync_single
Message-ID: <20050912195356.GD19644@tuxdriver.com>
Mail-Followup-To: Grant Grundler <iod00d@hp.com>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
	Asit.K.Mallick@intel.com
References: <09122005104851.31056@bilbo.tuxdriver.com> <09122005104851.31120@bilbo.tuxdriver.com> <20050912185120.GD21820@esmail.cup.hp.com> <20050912195110.GC19644@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912195110.GC19644@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call BUG() if DMA_NONE is passed-in as direction for sync_single.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 lib/swiotlb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -315,13 +315,13 @@ sync_single(struct device *hwdev, char *
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dma == DMA_BIDIRECTIONAL))
 			memcpy(buffer, dma_addr, size);
-		else if (dir != DMA_TO_DEVICE && dir != DMA_NONE)
+		else if (dir != DMA_TO_DEVICE)
 			BUG();
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dma == DMA_BIDIRECTIONAL))
 			memcpy(dma_addr, buffer, size);
-		else if (dir != DMA_FROM_DEVICE && dir != DMA_NONE)
+		else if (dir != DMA_FROM_DEVICE)
 			BUG();
 		break;
 	default:
-- 
John W. Linville
linville@tuxdriver.com
