Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVCCXuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVCCXuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVCCXtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:49:39 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262738AbVCCXWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:21 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][14/26] IB/mthca: tweak MAP_ICM_page firmware command
In-Reply-To: <2005331520.wYWJriF1rMlIY4lJ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.6eBThkRRWYJ5HE5s@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0863 (UTC) FILETIME=[95D79E70:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have MAP_ICM_page() firmware command map assume pages are always the
HCA-native 4K size rather than using the kernel's page size.  This
will make handling doorbell pages for mem-free mode simpler.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-03-03 14:12:58.283270213 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-03-03 14:12:58.619197294 -0800
@@ -1290,7 +1290,7 @@
 		return -ENOMEM;
 
 	inbox[0] = cpu_to_be64(virt);
-	inbox[1] = cpu_to_be64(dma_addr | (PAGE_SHIFT - 12));
+	inbox[1] = cpu_to_be64(dma_addr);
 
 	err = mthca_cmd(dev, indma, 1, 0, CMD_MAP_ICM, CMD_TIME_CLASS_B, status);
 

