Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVHEPDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVHEPDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVHEOxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:43 -0400
Received: from fep16.inet.fi ([194.251.242.241]:37007 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S262635AbVHEOvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:51:46 -0400
Subject: [PATCH 6/8] drivers: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7k7.yd6x86.4tha6emvbijm9jwl3fjqhsrfy.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7js.czjdww.9wbed36gfob4o2kzq2itotq1c.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:51:45 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 block/aoe/aoedev.c       |    2 +-
 char/mbcs.c              |    2 +-
 i2c/chips/isp1301_omap.c |    2 +-
 infiniband/core/sysfs.c  |    2 +-
 scsi/sata_qstor.c        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

Index: 2.6/drivers/block/aoe/aoedev.c
===================================================================
--- 2.6.orig/drivers/block/aoe/aoedev.c
+++ 2.6/drivers/block/aoe/aoedev.c
@@ -35,7 +35,7 @@ aoedev_newdev(ulong nframes)
 	struct aoedev *d;
 	struct frame *f, *e;
 
-	d = kcalloc(1, sizeof *d, GFP_ATOMIC);
+	d = kzalloc(sizeof *d, GFP_ATOMIC);
 	if (d == NULL)
 		return NULL;
 	f = kcalloc(nframes, sizeof *f, GFP_ATOMIC);
Index: 2.6/drivers/char/mbcs.c
===================================================================
--- 2.6.orig/drivers/char/mbcs.c
+++ 2.6/drivers/char/mbcs.c
@@ -750,7 +750,7 @@ static int mbcs_probe(struct cx_dev *dev
 
 	dev->soft = NULL;
 
-	soft = kcalloc(1, sizeof(struct mbcs_soft), GFP_KERNEL);
+	soft = kzalloc(sizeof(struct mbcs_soft), GFP_KERNEL);
 	if (soft == NULL)
 		return -ENOMEM;
 
Index: 2.6/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- 2.6.orig/drivers/i2c/chips/isp1301_omap.c
+++ 2.6/drivers/i2c/chips/isp1301_omap.c
@@ -1489,7 +1489,7 @@ static int isp1301_probe(struct i2c_adap
 	if (the_transceiver)
 		return 0;
 
-	isp = kcalloc(1, sizeof *isp, GFP_KERNEL);
+	isp = kzalloc(sizeof *isp, GFP_KERNEL);
 	if (!isp)
 		return 0;
 
Index: 2.6/drivers/infiniband/core/sysfs.c
===================================================================
--- 2.6.orig/drivers/infiniband/core/sysfs.c
+++ 2.6/drivers/infiniband/core/sysfs.c
@@ -461,7 +461,7 @@ alloc_group_attrs(ssize_t (*show)(struct
 		return NULL;
 
 	for (i = 0; i < len; i++) {
-		element = kcalloc(1, sizeof(struct port_table_attribute),
+		element = kzalloc(sizeof(struct port_table_attribute),
 				  GFP_KERNEL);
 		if (!element)
 			goto err;
Index: 2.6/drivers/scsi/sata_qstor.c
===================================================================
--- 2.6.orig/drivers/scsi/sata_qstor.c
+++ 2.6/drivers/scsi/sata_qstor.c
@@ -489,7 +489,7 @@ static int qs_port_start(struct ata_port
 	if (rc)
 		return rc;
 	qs_enter_reg_mode(ap);
-	pp = kcalloc(1, sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp) {
 		rc = -ENOMEM;
 		goto err_out;
