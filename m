Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932902AbWF2V5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbWF2V5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWF2V45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:56:57 -0400
Received: from mx.pathscale.com ([64.160.42.68]:37263 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932903AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 25 of 39] IB/ipath - removed redundant statements
X-Mercurial-Node: 4c581c37bb95ad3abb6dc0c4889b85f9bc6d55de
Message-Id: <4c581c37bb95ad3abb6d.1151617276@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:16 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tail register read became redundant as the result of earlier receive
interrupt bug fixes.

Drop another unneeded register read.

And another line that got duplicated.

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r e952aedb0e94 -r 4c581c37bb95 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
@@ -890,9 +890,6 @@ void ipath_kreceive(struct ipath_devdata
 		goto done;
 
 reloop:
-	/* read only once at start for performance */
-	hdrqtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
-
 	for (i = 0; l != hdrqtail; i++) {
 		u32 qp;
 		u8 *bthbytes;
diff -r e952aedb0e94 -r 4c581c37bb95 drivers/infiniband/hw/ipath/ipath_ht400.c
--- a/drivers/infiniband/hw/ipath/ipath_ht400.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c	Thu Jun 29 14:33:26 2006 -0700
@@ -1573,7 +1573,6 @@ void ipath_init_ht400_funcs(struct ipath
 	dd->ipath_f_reset = ipath_setup_ht_reset;
 	dd->ipath_f_get_boardname = ipath_ht_boardname;
 	dd->ipath_f_init_hwerrors = ipath_ht_init_hwerrors;
-	dd->ipath_f_init_hwerrors = ipath_ht_init_hwerrors;
 	dd->ipath_f_early_init = ipath_ht_early_init;
 	dd->ipath_f_handle_hwerrors = ipath_ht_handle_hwerrors;
 	dd->ipath_f_quiet_serdes = ipath_ht_quiet_serdes;
diff -r e952aedb0e94 -r 4c581c37bb95 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:26 2006 -0700
@@ -824,7 +824,6 @@ irqreturn_t ipath_intr(int irq, void *da
 			ipath_stats.sps_fastrcvint++;
 			goto done;
 		}
-		istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
 	}
  
 	istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
