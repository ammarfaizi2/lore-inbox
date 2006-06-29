Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932970AbWF2V6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbWF2V6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbWF2V6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:58:22 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34447 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932876AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 14 of 39] IB/ipath - removed unused field ipath_kregvirt from
	struct ipath_devdata
X-Mercurial-Node: e43b4df874a97ae8bfc98a93213b3176b7f62a95
Message-Id: <e43b4df874a97ae8bfc9.1151617265@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:05 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r a94e9f9c9c23 -r e43b4df874a9 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
@@ -496,10 +496,8 @@ static int __devinit ipath_init_one(stru
 		((void __iomem *)dd->ipath_kregbase + len);
 	dd->ipath_physaddr = addr;	/* used for io_remap, etc. */
 	/* for user mmap */
-	dd->ipath_kregvirt = (u64 __iomem *) phys_to_virt(addr);
-	ipath_cdbg(VERBOSE, "mapped io addr %llx to kregbase %p "
-		   "kregvirt %p\n", addr, dd->ipath_kregbase,
-		   dd->ipath_kregvirt);
+	ipath_cdbg(VERBOSE, "mapped io addr %llx to kregbase %p\n",
+		   addr, dd->ipath_kregbase);
 
 	/*
 	 * clear ipath_flags here instead of in ipath_init_chip as it is set
@@ -1809,7 +1807,6 @@ static void cleanup_device(struct ipath_
 			 * re-init
 			 */
 			dd->ipath_kregbase = NULL;
-			dd->ipath_kregvirt = NULL;
 			dd->ipath_uregbase = 0;
 			dd->ipath_sregbase = 0;
 			dd->ipath_cregbase = 0;
diff -r a94e9f9c9c23 -r e43b4df874a9 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
@@ -158,11 +158,6 @@ struct ipath_devdata {
 	unsigned long ipath_physaddr;
 	/* base of memory alloced for ipath_kregbase, for free */
 	u64 *ipath_kregalloc;
-	/*
-	 * version of kregbase that doesn't have high bits set (for 32 bit
-	 * programs, so mmap64 44 bit works)
-	 */
-	u64 __iomem *ipath_kregvirt;
 	/*
 	 * virtual address where port0 rcvhdrqtail updated for this unit.
 	 * only written to by the chip, not the driver.
