Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVI1Xeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVI1Xeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVI1Xeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:34:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45499 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751238AbVI1Xeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:34:31 -0400
Date: Thu, 29 Sep 2005 00:34:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] mv64x60 iomem annotations
Message-ID: <20050928233430.GK7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-n_r3964/arch/ppc/syslib/mv64x60.c RC14-rc2-git6-mv64x60/arch/ppc/syslib/mv64x60.c
--- RC14-rc2-git6-n_r3964/arch/ppc/syslib/mv64x60.c	2005-09-28 13:01:59.000000000 -0400
+++ RC14-rc2-git6-mv64x60/arch/ppc/syslib/mv64x60.c	2005-09-28 13:02:22.000000000 -0400
@@ -34,7 +34,7 @@
 DEFINE_SPINLOCK(mv64x60_lock);
 
 static phys_addr_t 	mv64x60_bridge_pbase;
-static void 		*mv64x60_bridge_vbase;
+static void 		__iomem *mv64x60_bridge_vbase;
 static u32		mv64x60_bridge_type = MV64x60_TYPE_INVALID;
 static u32		mv64x60_bridge_rev;
 #if defined(CONFIG_SYSFS) && !defined(CONFIG_GT64260)
@@ -938,7 +938,7 @@
  *
  * Return the virtual address of the bridge's registers.
  */
-void *
+void __iomem *
 mv64x60_get_bridge_vbase(void)
 {
 	return mv64x60_bridge_vbase;
diff -urN RC14-rc2-git6-n_r3964/include/asm-ppc/mv64x60.h RC14-rc2-git6-mv64x60/include/asm-ppc/mv64x60.h
--- RC14-rc2-git6-n_r3964/include/asm-ppc/mv64x60.h	2005-09-22 01:17:31.000000000 -0400
+++ RC14-rc2-git6-mv64x60/include/asm-ppc/mv64x60.h	2005-09-28 13:02:22.000000000 -0400
@@ -233,7 +233,7 @@
 struct mv64x60_handle {
 	u32		type;		/* type of bridge */
 	u32		rev;		/* revision of bridge */
-	void		*v_base;	/* virtual base addr of bridge regs */
+	void		__iomem *v_base;/* virtual base addr of bridge regs */
 	phys_addr_t	p_base;		/* physical base addr of bridge regs */
 
 	u32		pci_mode_a;	/* pci 0 mode: conventional pci, pci-x*/
@@ -303,7 +303,7 @@
 	u32 cfg_data, struct pci_controller **hose);
 int mv64x60_get_type(struct mv64x60_handle *bh);
 int mv64x60_setup_for_chip(struct mv64x60_handle *bh);
-void *mv64x60_get_bridge_vbase(void);
+void __iomem *mv64x60_get_bridge_vbase(void);
 u32 mv64x60_get_bridge_type(void);
 u32 mv64x60_get_bridge_rev(void);
 void mv64x60_get_mem_windows(struct mv64x60_handle *bh,
