Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWKEUqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWKEUqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWKEUqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:46:48 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:26273 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932579AbWKEUqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:46:47 -0500
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 4/4] ehca: ehca_av.c use constant for max mtu
Date: Sun, 5 Nov 2006 21:42:56 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QzkTFQwVfAgoAV9"
Message-Id: <200611052142.56722.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QzkTFQwVfAgoAV9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
This is a patch for ehca, mainly a code change to adhere to
kernel coding style. It defines and uses a constant EHCA_MAX_MTU 
instead hardcoded value.
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_av.c |    5 ++---
 hipz_hw.h |    2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
index 3bac197..214e2fd 100644
--- a/drivers/infiniband/hw/ehca/ehca_av.c
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -118,8 +118,7 @@ struct ib_ah *ehca_create_ah(struct ib_p
   }
   memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
  }
- /* for the time being we use a hard coded PMTU of 2048 Bytes */
- av->av.pmtu = 4;
+ av->av.pmtu = EHCA_MAX_MTU;
 
  /* dgid comes in grh.word_3 */
  memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
@@ -193,7 +192,7 @@ int ehca_modify_ah(struct ib_ah *ah, str
   memcpy(&new_ehca_av.grh.word_1, &gid, sizeof(gid));
  }
 
- new_ehca_av.pmtu = 4; /* see also comment in create_ah() */
+ new_ehca_av.pmtu = EHCA_MAX_MTU;
 
  memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
         sizeof(ah_attr->grh.dgid));
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index 3fc92b0..fad9136 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -45,6 +45,8 @@ #define __HIPZ_HW_H__
 
 #include "ehca_tools.h"
 
+#define EHCA_MAX_MTU 4
+
 /* QP Table Entry Memory Map */
 struct hipz_qptemm {
  u64 qpx_hcr;

--Boundary-00=_QzkTFQwVfAgoAV9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_maxmtu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_maxmtu.patch"

diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
index 3bac197..214e2fd 100644
--- a/drivers/infiniband/hw/ehca/ehca_av.c
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -118,8 +118,7 @@ struct ib_ah *ehca_create_ah(struct ib_p
 		}
 		memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
 	}
-	/* for the time being we use a hard coded PMTU of 2048 Bytes */
-	av->av.pmtu = 4;
+	av->av.pmtu = EHCA_MAX_MTU;
 
 	/* dgid comes in grh.word_3 */
 	memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
@@ -193,7 +192,7 @@ int ehca_modify_ah(struct ib_ah *ah, str
 		memcpy(&new_ehca_av.grh.word_1, &gid, sizeof(gid));
 	}
 
-	new_ehca_av.pmtu = 4; /* see also comment in create_ah() */
+	new_ehca_av.pmtu = EHCA_MAX_MTU;
 
 	memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
 	       sizeof(ah_attr->grh.dgid));
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index 3fc92b0..fad9136 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -45,6 +45,8 @@ #define __HIPZ_HW_H__
 
 #include "ehca_tools.h"
 
+#define EHCA_MAX_MTU 4
+
 /* QP Table Entry Memory Map */
 struct hipz_qptemm {
 	u64 qpx_hcr;

--Boundary-00=_QzkTFQwVfAgoAV9--
