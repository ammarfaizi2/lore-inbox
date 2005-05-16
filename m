Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVEPIQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVEPIQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVEPIPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:15:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59345 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261445AbVEPHRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:17:19 -0400
Date: Mon, 16 May 2005 15:21:23 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-cluster@redhat.com
Subject: [PATCH 8/8] dlm: build
Message-ID: <20050516072123.GM7094@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the dlm to the build system.

Signed-off-by: Dave Teigland <teigland@redhat.com>
Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>

---

 drivers/Kconfig      |    2 ++
 drivers/Makefile     |    1 +
 drivers/dlm/Kconfig  |   27 +++++++++++++++++++++++++++
 drivers/dlm/Makefile |   23 +++++++++++++++++++++++
 4 files changed, 53 insertions(+)

--- a/drivers/dlm/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/Makefile	2005-05-12 23:13:15.832485056 +0800
@@ -0,0 +1,23 @@
+obj-$(CONFIG_DLM) +=		dlm.o
+obj-$(CONFIG_DLM_DEVICE) +=	dlm_device.o
+
+dlm-y :=			ast.o \
+				config.o \
+				dir.o \
+				lock.o \
+				lockspace.o \
+				lowcomms.o \
+				main.o \
+				member.o \
+				member_sysfs.o \
+				memory.o \
+				midcomms.o \
+				node_ioctl.o \
+				rcom.o \
+				recover.o \
+				recoverd.o \
+				requestqueue.o \
+				util.o
+dlm-$(CONFIG_DLM_DEBUG) +=	debug_fs.o
+
+dlm_device-y :=			device.o
--- a/drivers/Makefile  2005-04-25 15:40:15.000000000 +0800
+++ b/drivers/Makefile  2005-04-25 16:10:10.228660648 +0800
@@ -64,3 +64,4 @@
 obj-$(CONFIG_BLK_DEV_SGIIOC4)	+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_DLM)		+= dlm/
--- a/drivers/dlm/Kconfig	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/Kconfig	2005-05-12 23:13:15.833484904 +0800
@@ -0,0 +1,27 @@
+menu "Distributed Lock Manager"
+	depends on INET && EXPERIMENTAL
+
+config DLM 
+	tristate "Distributed Lock Manager (DLM)"
+	select IP_SCTP
+	help
+	A general purpose distributed lock manager for kernel or userspace
+	applications.
+
+config DLM_DEVICE
+	tristate "DLM device for userspace access"
+	depends on DLM
+	help
+	This module creates a misc device through which the dlm lockspace
+	and locking functions become available to userspace applications
+	(usually through the libdlm library).
+
+config DLM_DEBUG
+	bool "DLM debugging"
+	depends on DLM
+	help
+	Under the debugfs mount point, the name of each lockspace will
+	appear as a file in the "dlm" directory.  The output is the
+	list of resource and locks the local node knows about.
+
+endmenu
--- a/drivers/Kconfig       2005-03-02 15:38:26.000000000 +0800
+++ b/drivers/Kconfig       2005-04-25 16:01:50.476634504 +0800
@@ -58,4 +58,6 @@
 
 source "drivers/infiniband/Kconfig"
 
+source "drivers/dlm/Kconfig"
+
 endmenu
