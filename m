Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVF1X2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVF1X2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVF1XXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:23:33 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:41396 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262242AbVF1XEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:04:00 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037162:sNHT27846404"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 07/16] IB uverbs: hook up Kconfig/Makefile
In-Reply-To: <2005628163.qcqYIUxXOrm3IH43@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.3Q9FD2m0Zd9kmlVn@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up InfiniBand userspace verbs to Kconfig and the make system.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/Kconfig       |   10 ++++++++++
 drivers/infiniband/core/Makefile |    5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)



--- linux.orig/drivers/infiniband/Kconfig	2005-06-28 15:19:24.783512128 -0700
+++ linux/drivers/infiniband/Kconfig	2005-06-28 15:20:09.143931652 -0700
@@ -7,6 +7,16 @@ config INFINIBAND
 	  any protocols you wish to use as well as drivers for your
 	  InfiniBand hardware.
 
+config INFINIBAND_USER_VERBS
+	tristate "InfiniBand userspace verbs support"
+	depends on INFINIBAND
+	---help---
+	  Userspace InfiniBand verbs support.  This is the kernel side
+	  of userspace verbs, which allows userspace processes to
+	  directly access InfiniBand hardware for fast-path
+	  operations.  You will also need libibverbs and a hardware
+	  driver library from <http://www.openib.org>.
+
 source "drivers/infiniband/hw/mthca/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
--- linux.orig/drivers/infiniband/core/Makefile	2005-06-28 15:19:24.782512344 -0700
+++ linux/drivers/infiniband/core/Makefile	2005-06-28 15:20:09.143931652 -0700
@@ -1,6 +1,7 @@
 EXTRA_CFLAGS += -Idrivers/infiniband/include
 
-obj-$(CONFIG_INFINIBAND) +=	ib_core.o ib_mad.o ib_sa.o ib_umad.o
+obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o ib_umad.o
+obj-$(CONFIG_INFINIBAND_USER_VERBS) +=	ib_uverbs.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
 				device.o fmr_pool.o cache.o
@@ -10,3 +11,5 @@ ib_mad-y :=			mad.o smi.o agent.o
 ib_sa-y :=			sa_query.o
 
 ib_umad-y :=			user_mad.o
+
+ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_mem.o
