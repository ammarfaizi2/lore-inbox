Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWKEUpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWKEUpe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWKEUpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:45:34 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:3376 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422654AbWKEUpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:45:33 -0500
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page mode
Date: Sun, 5 Nov 2006 21:41:28 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5xkTFOip1X5A9Ve"
Message-Id: <200611052141.29030.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5xkTFOip1X5A9Ve
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
This is another patch of ehca for 64k page support. It fixes a bug that maps
4k aligned addresses in 64k page mode in a wrong way.
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 hcp_phyp.c |    5 +++--0018_64kpage_ioremap.patch  
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.c b/drivers/infiniband/hw/ehca/hcp_phyp.c
index 0b1a477..6237252 100644
--- a/drivers/infiniband/hw/ehca/hcp_phyp.c
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.c
@@ -44,13 +44,14 @@ #include "hipz_hw.h"
 
 int hcall_map_page(u64 physaddr, u64 *mapaddr)
 {
- *mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
+ *mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
+  (physaddr & (~PAGE_MASK));
  return 0;
 }
 
 int hcall_unmap_page(u64 mapaddr)
 {
- iounmap((volatile void __iomem*)mapaddr);
+ iounmap((void __iomem*)(mapaddr & PAGE_MASK));
  return 0;
 }
 

--Boundary-00=_5xkTFOip1X5A9Ve
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_64kpage_ioremap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_64kpage_ioremap.patch"

diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.c b/drivers/infiniband/hw/ehca/hcp_phyp.c
index 0b1a477..6237252 100644
--- a/drivers/infiniband/hw/ehca/hcp_phyp.c
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.c
@@ -44,13 +44,14 @@ #include "hipz_hw.h"
 
 int hcall_map_page(u64 physaddr, u64 *mapaddr)
 {
-	*mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
+	*mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
+		(physaddr & (~PAGE_MASK));
 	return 0;
 }
 
 int hcall_unmap_page(u64 mapaddr)
 {
-	iounmap((volatile void __iomem*)mapaddr);
+	iounmap((void __iomem*)(mapaddr & PAGE_MASK));
 	return 0;
 }
 

--Boundary-00=_5xkTFOip1X5A9Ve--
