Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWIWPoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWIWPoT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIWPoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:44:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5854 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751249AbWIWPoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:44:19 -0400
Date: Sat, 23 Sep 2006 16:44:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org
Subject: [PATCH] missing includes from infiniband merge
Message-ID: <20060923154416.GH29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

indirect chains of includes are arch-specific and can't
be relied upon...  (hell, even attempt to build it for
itanic would trigger vmalloc.h ones; err.h triggers
on e.g. alpha).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/core/mad_priv.h           |    1 +
 drivers/infiniband/hw/amso1100/c2_provider.c |    1 +
 drivers/infiniband/hw/amso1100/c2_rnic.c     |    1 +
 drivers/infiniband/hw/ipath/ipath_diag.c     |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 1da9adb..d06b590 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -38,6 +38,7 @@ #ifndef __IB_MAD_PRIV_H__
 #define __IB_MAD_PRIV_H__
 
 #include <linux/completion.h>
+#include <linux/err.h>
 #include <linux/pci.h>
 #include <linux/workqueue.h>
 #include <rdma/ib_mad.h>
diff --git a/drivers/infiniband/hw/amso1100/c2_provider.c b/drivers/infiniband/hw/amso1100/c2_provider.c
index 8fddc8c..dd6af55 100644
--- a/drivers/infiniband/hw/amso1100/c2_provider.c
+++ b/drivers/infiniband/hw/amso1100/c2_provider.c
@@ -49,6 +49,7 @@ #include <linux/tcp.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/if_arp.h>
+#include <linux/vmalloc.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/drivers/infiniband/hw/amso1100/c2_rnic.c b/drivers/infiniband/hw/amso1100/c2_rnic.c
index 1c3c9d6..f49a32b 100644
--- a/drivers/infiniband/hw/amso1100/c2_rnic.c
+++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
@@ -50,6 +50,7 @@ #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/inet.h>
+#include <linux/vmalloc.h>
 
 #include <linux/route.h>
 
diff --git a/drivers/infiniband/hw/ipath/ipath_diag.c b/drivers/infiniband/hw/ipath/ipath_diag.c
index 28b6b46..29958b6 100644
--- a/drivers/infiniband/hw/ipath/ipath_diag.c
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c
@@ -43,6 +43,7 @@
 
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/vmalloc.h>
 #include <asm/uaccess.h>
 
 #include "ipath_kernel.h"
-- 
1.4.2.GIT

