Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVJYVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVJYVlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJYVlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:41:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11726 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932405AbVJYVlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:41:12 -0400
Subject: [PATCH] 5/5 ibmveth fix failed addbuf
From: Santiago Leon <santil@us.ibm.com>
To: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain
Message-Id: <1130275622.11155.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Oct 2005 16:39:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug that happens when the hypervisor can't add a
buffer.  The old code wrote IBM_VETH_INVALID_MAP into the free_map
array, so next time the index was used, a ibmveth_assert() caught it and
called BUG().  The patch writes the right value into the free_map array
so that the index can be reused.


Signed-off-by: Santiago Leon <santil@us.ibm.com>
---
drivers/net/ibmveth.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)
---
diff -urN a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
--- a/drivers/net/ibmveth.c 2005-10-17 12:35:13.000000000 -0500
+++ b/drivers/net/ibmveth.c 2005-10-17 12:36:13.000000000 -0500
@@ -237,7 +237,7 @@
lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address,
desc.desc);
    
if(lpar_rc != H_Success) {
- pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
+ pool->free_map[free_index] = index;
pool->skbuff[index] = NULL;
pool->consumer_index--;
dma_unmap_single(&adapter->vdev->dev,

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

