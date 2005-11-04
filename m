Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbVKDAyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVKDAyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVKDAyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:54:35 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:26260
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161034AbVKDAya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:30 -0500
Date: Thu, 3 Nov 2005 18:54:29 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 34/42]: ppc64: Remove duplicate code
Message-ID: <20051104005429.GA27114@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

234-eeh-find-pe.patch

The find_device_pe() routine is duplicated in two files. Remove one of the two
copies, declare the other extern.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2005-11-02 14:41:18.435451353 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_driver.c	2005-11-02 14:45:43.638259683 -0600
@@ -42,19 +42,6 @@
 	return "";
 }
 
-/**
- * Return the "partitionable endpoint" (pe) under which this device lies
- */
-static struct device_node * find_device_pe(struct device_node *dn)
-{
-	while ((dn->parent) && PCI_DN(dn->parent) &&
-	      (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
-		dn = dn->parent;
-	}
-	return dn;
-}
-
-
 #ifdef DEBUG
 static void print_device_node_tree (struct pci_dn *pdn, int dent)
 {
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:45:00.429319560 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:45:43.651257860 -0600
@@ -172,7 +172,7 @@
 /** 
  * Return the "partitionable endpoint" (pe) under which this device lies
  */
-static struct device_node * find_device_pe(struct device_node *dn)
+struct device_node * find_device_pe(struct device_node *dn)
 {
 	while ((dn->parent) && PCI_DN(dn->parent) &&
 	      (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
Index: linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-powerpc/ppc-pci.h	2005-11-02 14:42:38.998153856 -0600
+++ linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h	2005-11-02 14:45:43.656257159 -0600
@@ -110,6 +110,9 @@
 void eeh_mark_slot (struct device_node *dn, int mode_flag);
 void eeh_clear_slot (struct device_node *dn, int mode_flag);
 
+/* Find the associated "Partiationable Endpoint" PE */
+struct device_node * find_device_pe(struct device_node *dn);
+
 #endif
 
 #endif /* _ASM_POWERPC_PPC_PCI_H */
