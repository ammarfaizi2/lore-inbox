Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUBIX06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUBIX0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:26:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:4541 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265464AbUBIXWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:50 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689421189@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:23 -0800
Message-Id: <1076368943895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.21, 2004/02/09 11:03:22-08:00, greg@kroah.com

PCI: remove stupid MSI debugging code that was never used.


 drivers/pci/msi.c       |    1 -
 include/linux/pci_msi.h |   29 +++--------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	Mon Feb  9 14:58:21 2004
+++ b/drivers/pci/msi.c	Mon Feb  9 14:58:21 2004
@@ -21,7 +21,6 @@
 
 #include <linux/pci_msi.h>
 
-_DEFINE_DBG_BUFFER
 
 static spinlock_t msi_lock = SPIN_LOCK_UNLOCKED;
 static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
diff -Nru a/include/linux/pci_msi.h b/include/linux/pci_msi.h
--- a/include/linux/pci_msi.h	Mon Feb  9 14:58:21 2004
+++ b/include/linux/pci_msi.h	Mon Feb  9 14:58:21 2004
@@ -3,8 +3,8 @@
  *
  */
 
-#ifndef _ASM_PCI_MSI_H
-#define _ASM_PCI_MSI_H
+#ifndef PCI_MSI_H
+#define PCI_MSI_H
 
 #include <linux/pci.h>
 
@@ -82,29 +82,6 @@
 #define msix_mask(address)		(address | PCI_MSIX_FLAGS_BITMASK)
 #define msix_is_pending(address) 	(address & PCI_MSIX_FLAGS_PENDMASK)
 
-extern char __dbg_str_buf[256];
-#define _DEFINE_DBG_BUFFER	char __dbg_str_buf[256];
-#define _DBG_K_TRACE_ENTRY	((unsigned int)0x00000001)
-#define _DBG_K_TRACE_EXIT	((unsigned int)0x00000002)
-#define _DBG_K_INFO		((unsigned int)0x00000004)
-#define _DBG_K_ERROR		((unsigned int)0x00000008)
-#define _DBG_K_TRACE	(_DBG_K_TRACE_ENTRY | _DBG_K_TRACE_EXIT)
-
-#define _DEBUG_LEVEL	(_DBG_K_INFO | _DBG_K_ERROR | _DBG_K_TRACE)
-#define _DBG_PRINT( dbg_flags, args... )		\
-if ( _DEBUG_LEVEL & (dbg_flags) )			\
-{							\
-	int len;					\
-	len = sprintf(__dbg_str_buf, "%s:%d: %s ", 	\
-		__FILE__, __LINE__, __FUNCTION__ ); 	\
-	sprintf(__dbg_str_buf + len, args);		\
-	printk(KERN_INFO "%s\n", __dbg_str_buf);	\
-}
-
-#define MSI_FUNCTION_TRACE_ENTER	\
-	_DBG_PRINT (_DBG_K_TRACE_ENTRY, "%s", "[Entry]");
-#define MSI_FUNCTION_TRACE_EXIT		\
-	_DBG_PRINT (_DBG_K_TRACE_EXIT, "%s", "[Entry]");
 
 /*
  * MSI Defined Data Structures
@@ -190,4 +167,4 @@
 	struct pci_dev *dev;
 };
 
-#endif /* _ASM_PCI_MSI_H */
+#endif /* PCI_MSI_H */

