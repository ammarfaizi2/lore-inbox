Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVDDWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVDDWfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVDDWff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:35:35 -0400
Received: from webmail.topspin.com ([12.162.17.3]:9259 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261463AbVDDWeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:34:24 -0400
Subject: [PATCH][RFC][4/4] IB: userspace verbs Kconfig/Makefile changes
In-Reply-To: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 4 Apr 2005 15:09:00 -0700
Message-Id: <200544159.LHYjypUjDczyHP7A@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 04 Apr 2005 22:09:00.0835 (UTC) FILETIME=[E7CB0F30:01C53962]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hook userspace verbs up to Kconfig and Makefile.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/drivers/infiniband/Kconfig	2005-04-04 14:58:53.397756926 -0700
+++ linux-export/drivers/infiniband/Kconfig	2005-04-04 15:01:08.716332258 -0700
@@ -7,6 +7,14 @@
 	  any protocols you wish to use as well as drivers for your
 	  InfiniBand hardware.
 
+config INFINIBAND_USER_VERBS
+	tristate "InfiniBand userspace verbs support"
+	depends on INFINIBAND
+	---help---
+	  Userspace InfiniBand verbs support.  This is the kernel side
+	  of userspace verbs.  You will also need libibverbs and a
+	  hardware driver library from <http://www.openib.org>.
+
 source "drivers/infiniband/hw/mthca/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
--- linux-export.orig/drivers/infiniband/core/Makefile	2005-04-04 14:58:53.398756709 -0700
+++ linux-export/drivers/infiniband/core/Makefile	2005-04-04 15:00:44.933503748 -0700
@@ -1,7 +1,8 @@
 EXTRA_CFLAGS += -Idrivers/infiniband/include
 
-obj-$(CONFIG_INFINIBAND) +=	ib_core.o ib_mad.o ib_ping.o \
-				ib_cm.o ib_sa.o ib_umad.o ib_ucm.o
+obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_ping.o \
+					ib_cm.o ib_sa.o ib_umad.o ib_ucm.o
+obj-$(CONFIG_INFINIBAND_USER_VERBS) +=	ib_uverbs.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
 				device.o fmr_pool.o cache.o
@@ -16,4 +17,6 @@
 
 ib_umad-y :=			user_mad.o
 
+ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_mem.o
+
 ib_ucm-y :=			ucm.o

