Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVDYPil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVDYPil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVDYPhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:37:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262661AbVDYPJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:09:49 -0400
Date: Mon, 25 Apr 2005 23:13:33 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 7/7] dlm: build
Message-ID: <20050425151333.GH6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds the dlm to the build system.

Signed-Off-By: Dave Teigland <teigland@redhat.com>
Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>

---

 drivers/Kconfig      |    2 ++
 drivers/Makefile     |    1 +
 drivers/dlm/Kconfig  |   25 +++++++++++++++++++++++++
 drivers/dlm/Makefile |   23 +++++++++++++++++++++++
 4 files changed, 51 insertions(+)

--- a/drivers/dlm/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/Makefile	2005-04-25 22:52:04.209778304 +0800
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
+++ b/drivers/dlm/Kconfig	2005-04-25 22:52:04.217777088 +0800
@@ -0,0 +1,25 @@
+menu "Distributed Lock Manager"
+
+config DLM 
+	tristate "Distributed Lock Manager (DLM)"
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
