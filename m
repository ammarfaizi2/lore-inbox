Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVADAPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVADAPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVADAMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:12:08 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:47335 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261993AbVADAHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:07:16 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: rmk+lkml@arm.linux.org.uk, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104000735.17524.96005.71130@localhost.localdomain>
Subject: [PATCH] mach-ixp2000: remove cli()/sti()
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Mon, 3 Jan 2005 18:07:15 -0600
Date: Mon, 3 Jan 2005 18:07:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace to-be-deprecated functions in arch/arm/mach-ixp2000/pci.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/arm/mach-ixp2000/pci.c linux-2.6.10-mm1/arch/arm/mach-ixp2000/pci.c
--- linux-2.6.10-mm1-original/arch/arm/mach-ixp2000/pci.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-mm1/arch/arm/mach-ixp2000/pci.c	2005-01-03 18:58:52.648191137 -0500
@@ -145,7 +145,7 @@
 
 	pci_master_aborts = 1;
 
-	cli();
+	local_irq_disable();
 	temp = *(IXP2000_PCI_CONTROL);
 	if (temp & ((1 << 8) | (1 << 5))) {
 		ixp2000_reg_write(IXP2000_PCI_CONTROL, temp);
@@ -158,7 +158,7 @@
 			temp = *(IXP2000_PCI_CMDSTAT);
 		}
 	}
-	sti();
+	local_irq_enable();
 
 	/*
 	 * If it was an imprecise abort, then we need to correct the
@@ -175,7 +175,7 @@
 {
 	volatile u32 temp;
 
-	cli();
+	local_irq_disable();
 	temp = *(IXP2000_PCI_CONTROL);
 	if (temp & ((1 << 8) | (1 << 5))) {	
 		ixp2000_reg_write(IXP2000_PCI_CONTROL, temp);
@@ -188,7 +188,7 @@
 			temp = *(IXP2000_PCI_CMDSTAT);
 		}
 	}
-	sti();
+	local_irq_enable();
 
 	return 0;
 }
