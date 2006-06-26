Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWFZQrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWFZQrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFZQrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31717 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750812AbWFZQql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:46:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/4] [Suspend2] kernel/power/Makefile Suspend2 modifications.
Date: Tue, 27 Jun 2006 02:46:45 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164643.10641.71209.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
References: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Makefile entries for suspend2 objects.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/Makefile |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 01f2230..0d0f132 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -5,9 +5,28 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o swap.o user.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 obj-$(CONFIG_SUSPEND_SHARED)	+= snapshot.o
 
+# Order is important for compression and encryption - we
+# compress before encrypting.
+
+suspend_core-objs := io.o pagedir.o prepare_image.o \
+		extent.o suspend.o modules.o \
+		pageflags.o ui.o proc.o \
+		power_off.o atomic_copy.o
+
+#ifdef CONFIG_NET
+suspend_core-objs += storage.o netlink.o
+#endif
+
+obj-$(CONFIG_SUSPEND2)			+= suspend_core.o
+obj-$(CONFIG_SUSPEND2_CRYPTO)		+= compression.o encryption.o
+
+obj-$(CONFIG_SUSPEND2_SWAPWRITER)	+= suspend_block_io.o suspend_swap.o
+obj-$(CONFIG_SUSPEND2_FILEWRITER)	+= suspend_block_io.o suspend_file.o
+
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o swap.o user.o
+
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o

--
Nigel Cunningham		nigel at suspend2 dot net
