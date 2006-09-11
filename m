Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWIKXSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWIKXSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWIKXSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:18:53 -0400
Received: from mga03.intel.com ([143.182.124.21]:44215 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965113AbWIKXSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:50 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="114947171:sNHT33253857"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 14/19] dmaengine: add dma_sync_wait
Date: Mon, 11 Sep 2006 16:18:49 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231849.4737.90803.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

dma_sync_wait is a common routine to live wait for a dma operation to
complete.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 include/linux/dmaengine.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9fd6cbd..0a70c9e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -750,6 +750,18 @@ static inline void dma_async_unmap_singl
 	chan->device->unmap_single(chan, handle, size, direction);
 }
 
+static inline enum dma_status dma_sync_wait(struct dma_chan *chan,
+						dma_cookie_t cookie)
+{
+	enum dma_status status;
+	dma_async_issue_pending(chan);
+	do {
+		status = dma_async_operation_complete(chan, cookie, NULL, NULL);
+	} while (status == DMA_IN_PROGRESS);
+
+	return status;
+}
+
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
