Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVADVrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVADVrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVADVqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:46:48 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:53453 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262337AbVADVl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:41:27 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214144.21749.45711.82235@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 7/7] ppc: remove cli()/sti() in arch/ppc/syslib/qspan_pci.c
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:41:23 -0600
Date: Tue, 4 Jan 2005 15:41:26 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/syslib/qspan_pci.c linux-2.6.10-mm1/arch/ppc/syslib/qspan_pci.c
--- linux-2.6.10-mm1-original/arch/ppc/syslib/qspan_pci.c	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/syslib/qspan_pci.c	2005-01-03 19:13:30.256710849 -0500
@@ -109,8 +109,7 @@
 	}
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -124,7 +123,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 
 	offset ^= 0x03;
@@ -148,8 +147,7 @@
 	}
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -164,7 +162,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 
 	sp = ((ushort *)&temp) + ((offset >> 1) & 1);
@@ -185,8 +183,7 @@
 	}
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -200,7 +197,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
@@ -225,8 +222,7 @@
 	*cp = val;
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -240,7 +236,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
@@ -265,8 +261,7 @@
 	*sp = val;
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -280,7 +275,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
@@ -297,8 +292,7 @@
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 #ifdef CONFIG_RPXCLASSIC
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	*((uint *)RPX_CSR_ADDR) &= ~BCSR2_QSPACESEL;
 	eieio();
 #endif
@@ -312,7 +306,7 @@
 #ifdef CONFIG_RPXCLASSIC
 	*((uint *)RPX_CSR_ADDR) |= BCSR2_QSPACESEL;
 	eieio();
-	restore_flags(flags);
+	local_irq_restore(flags);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
