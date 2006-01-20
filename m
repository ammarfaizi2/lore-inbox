Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161496AbWATE10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161496AbWATE10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWATE10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:27:26 -0500
Received: from xenotime.net ([66.160.160.81]:12735 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161496AbWATE1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:27:25 -0500
Date: Thu, 19 Jan 2006 20:27:20 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, kjhall@us.ibm.com
Subject: [PATCH] tpm_bios: needs more securityfs_ functions
Message-Id: <20060119202720.3b3d5b90.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

tpm_bios.c needs securityfs_xyz() functions.

Does include/linux/security.h need stubs for these, or should
char/tpm/Makefile just be modified to say:

ifdef CONFIG_ACPI
ifdef CONFIG_SECURITY
	obj-$(CONFIG_TCG_TPM) += tpm_bios.o
endif
endif

drivers/char/tpm/tpm_bios.c:494: warning: implicit declaration of function 'securityfs_create_dir'
drivers/char/tpm/tpm_bios.c:494: warning: assignment makes pointer from integer without a cast
drivers/char/tpm/tpm_bios.c:499: warning: implicit declaration of function 'securityfs_create_file'
drivers/char/tpm/tpm_bios.c:501: warning: assignment makes pointer from integer without a cast
drivers/char/tpm/tpm_bios.c:508: warning: assignment makes pointer from integer without a cast
drivers/char/tpm/tpm_bios.c:523: warning: implicit declaration of function 'securityfs_remove'
*** Warning: "securityfs_create_file" [drivers/char/tpm/tpm_bios.ko] undefined!
*** Warning: "securityfs_create_dir" [drivers/char/tpm/tpm_bios.ko] undefined!
*** Warning: "securityfs_remove" [drivers/char/tpm/tpm_bios.ko] undefined!

There are also some gcc and sparse warnings that could be fixed.
(see http://www.xenotime.net/linux/doc/build-tpm.out)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/security.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)

--- linux-2616-rc1-secur.orig/include/linux/security.h
+++ linux-2616-rc1-secur/include/linux/security.h
@@ -2617,6 +2617,25 @@ static inline int security_netlink_recv 
 	return cap_netlink_recv (skb);
 }
 
+static inline struct dentry *securityfs_create_dir(const char *name,
+					struct dentry *parent)
+{
+	return NULL;
+}
+
+static inline struct dentry *securityfs_create_file(const char *name,
+						mode_t mode,
+						struct dentry *parent,
+						void *data,
+						struct file_operations *fops)
+{
+	return NULL;
+}
+
+static inline void securityfs_remove(struct dentry *dentry)
+{
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK


---
