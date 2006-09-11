Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWIKXSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWIKXSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWIKXSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:18:51 -0400
Received: from mga03.intel.com ([143.182.124.21]:40122 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965102AbWIKXSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:39 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="114947122:sNHT44377942"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 12/19] dmaengine: dma_async_memcpy_err for DMA engines that do not support memcpy
Date: Mon, 11 Sep 2006 16:18:39 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231838.4737.6812.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Default virtual function that returns an error if the user attempts a
memcpy operation.  An XOR engine is an example of a DMA engine that does
not support memcpy.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index fe62237..33ad690 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -593,6 +593,18 @@ void dma_async_device_unregister(struct 
 }
 
 /**
+ * dma_async_do_memcpy_err - default function for dma devices that
+ *	do not support memcpy
+ */
+dma_cookie_t dma_async_do_memcpy_err(struct dma_chan *chan,
+		union dmaengine_addr dest, unsigned int dest_off,
+		union dmaengine_addr src, unsigned int src_off,
+                size_t len, unsigned long flags)
+{
+	return -ENXIO;
+}
+
+/**
  * dma_async_do_xor_err - default function for dma devices that
  *	do not support xor
  */
@@ -642,6 +654,7 @@ EXPORT_SYMBOL_GPL(dma_async_issue_pendin
 EXPORT_SYMBOL_GPL(dma_async_device_register);
 EXPORT_SYMBOL_GPL(dma_async_device_unregister);
 EXPORT_SYMBOL_GPL(dma_chan_cleanup);
+EXPORT_SYMBOL_GPL(dma_async_do_memcpy_err);
 EXPORT_SYMBOL_GPL(dma_async_do_xor_err);
 EXPORT_SYMBOL_GPL(dma_async_do_memset_err);
 EXPORT_SYMBOL_GPL(dma_async_chan_init);
