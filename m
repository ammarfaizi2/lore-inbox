Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWKHWUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWKHWUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161730AbWKHWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:20:42 -0500
Received: from mx.pathscale.com ([64.160.42.68]:25813 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161483AbWKHWUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:20:41 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] Fix patch
X-Mercurial-Node: 5011f2a1dbc9446539c1d7f0204f6eac7ee5a0a4
Message-Id: <5011f2a1dbc9446539c1.1163024451@localhost.localdomain>
Date: Wed, 08 Nov 2006 14:20:51 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: rdreier@cisco.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -r b610f87d01e2 -r 5011f2a1dbc9 ipath-htirq.patch
--- a/ipath-htirq.patch	Wed Nov 08 12:08:13 2006 -0800
+++ b/ipath-htirq.patch	Wed Nov 08 14:20:04 2006 -0800
@@ -1,15 +1,16 @@ IB/ipath - program interrupt control reg
-IB/ipath - program interrupt control register using new htirq hook
+IB/ipath - program intconfig register using new HT irq hook
 
 Eric's changes to the htirq infrastructure require corresponding
 modifications to the ipath HT driver code so that interrupts are still
 delivered properly.
 
 Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
-Cc: Eric W. Biedermann <ebiederm@xmission.com>
+Cc: Eric W. Biederman <ebiederm@xmission.com>
+Cc: Roland Dreier <rdreier@cisco.com>
 
-diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_driver.c
---- a/drivers/infiniband/hw/ipath/ipath_driver.c	Tue Nov 07 11:35:24 2006 -0800
-+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 11:25:18 2006 -0800
+diff -r 69779e2890e3 drivers/infiniband/hw/ipath/ipath_driver.c
+--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 14:17:04 2006 -0800
++++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 14:17:04 2006 -0800
 @@ -304,7 +304,7 @@ static int __devinit ipath_init_one(stru
  	}
  	addr = pci_resource_start(pdev, 0);
@@ -54,9 +55,9 @@ diff -r bb12c8d85f7c drivers/infiniband/
  	} else
  		ipath_dbg("irq is 0, not doing free_irq "
  			  "for unit %u\n", dd->ipath_unit);
-diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_iba6110.c
---- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Tue Nov 07 11:35:24 2006 -0800
-+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Wed Nov 08 11:57:00 2006 -0800
+diff -r 69779e2890e3 drivers/infiniband/hw/ipath/ipath_iba6110.c
+--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Wed Nov 08 14:17:04 2006 -0800
++++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Wed Nov 08 14:17:04 2006 -0800
 @@ -38,6 +38,7 @@
  
  #include <linux/pci.h>
@@ -241,9 +242,9 @@ diff -r bb12c8d85f7c drivers/infiniband/
  
  	/*
  	 * initialize chip-specific variables
-diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_iba6120.c
---- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Tue Nov 07 11:35:24 2006 -0800
-+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Wed Nov 08 11:56:55 2006 -0800
+diff -r 69779e2890e3 drivers/infiniband/hw/ipath/ipath_iba6120.c
+--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Wed Nov 08 14:17:04 2006 -0800
++++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Wed Nov 08 14:17:04 2006 -0800
 @@ -851,6 +851,7 @@ static int ipath_setup_pe_config(struct 
  	int pos, ret;
  
@@ -273,9 +274,9 @@ diff -r bb12c8d85f7c drivers/infiniband/
  
  	/* initialize chip-specific variables */
  	dd->ipath_f_tidtemplate = ipath_pe_tidtemplate;
-diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_intr.c
---- a/drivers/infiniband/hw/ipath/ipath_intr.c	Tue Nov 07 11:35:24 2006 -0800
-+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Nov 08 11:16:41 2006 -0800
+diff -r 69779e2890e3 drivers/infiniband/hw/ipath/ipath_intr.c
+--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Nov 08 14:17:04 2006 -0800
++++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Nov 08 14:17:04 2006 -0800
 @@ -710,14 +710,14 @@ static void ipath_bad_intr(struct ipath_
  			 * linuxbios development work, and it may happen in
  			 * the future again.
@@ -304,9 +305,9 @@ diff -r bb12c8d85f7c drivers/infiniband/
  		} else if (allbits > 2) {
  			if ((allbits % 10000) == 0)
  				printk(".");
-diff -r bb12c8d85f7c drivers/infiniband/hw/ipath/ipath_kernel.h
---- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Tue Nov 07 11:35:24 2006 -0800
-+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Nov 08 12:07:03 2006 -0800
+diff -r 69779e2890e3 drivers/infiniband/hw/ipath/ipath_kernel.h
+--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Nov 08 14:17:04 2006 -0800
++++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Nov 08 14:17:04 2006 -0800
 @@ -213,6 +213,8 @@ struct ipath_devdata {
  	void (*ipath_f_setextled)(struct ipath_devdata *, u64, u64);
  	/* fill out chip-specific fields */
