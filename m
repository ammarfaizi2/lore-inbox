Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVJBOjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVJBOjM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVJBOjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 10:39:12 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:61931 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751097AbVJBOjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 10:39:11 -0400
Date: Sun, 2 Oct 2005 23:39:04 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: fix build error about TANBAC TB0226
Message-Id: <20051002233904.7d297203.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed the following build error about TANBAC TB0226.
Please apply.

arch/mips/pci/fixup-tb0226.c: In function `pcibios_map_irq':
arch/mips/pci/fixup-tb0226.c:31: warning: implicit declaration of function `vr41xx_set_irq_trigger'
arch/mips/pci/fixup-tb0226.c:32: error: `TRIGGER_LEVEL' undeclared (first use in this function)
arch/mips/pci/fixup-tb0226.c:32: error: (Each undeclared identifier is reported only once
arch/mips/pci/fixup-tb0226.c:32: error: for each function it appears in.)
arch/mips/pci/fixup-tb0226.c:33: error: `SIGNAL_THROUGH' undeclared (first use in this function)
arch/mips/pci/fixup-tb0226.c:34: warning: implicit declaration of function `vr41xx_set_irq_level'
arch/mips/pci/fixup-tb0226.c:34: error: `LEVEL_LOW' undeclared (first use in this function)
make[1]: *** [arch/mips/pci/fixup-tb0226.o] Error 1
make: *** [arch/mips/pci] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc3-orig/arch/mips/pci/fixup-tb0226.c rc3/arch/mips/pci/fixup-tb0226.c
--- rc3-orig/arch/mips/pci/fixup-tb0226.c	2005-10-01 06:17:35.000000000 +0900
+++ rc3/arch/mips/pci/fixup-tb0226.c	2005-10-02 22:50:42.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  *  fixup-tb0226.c, The TANBAC TB0226 specific PCI fixups.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
+#include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/tb0226.h>
 
 int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
@@ -29,42 +30,42 @@
 	switch (slot) {
 	case 12:
 		vr41xx_set_irq_trigger(GD82559_1_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(GD82559_1_PIN, LEVEL_LOW);
+				       IRQ_TRIGGER_LEVEL,
+				       IRQ_SIGNAL_THROUGH);
+		vr41xx_set_irq_level(GD82559_1_PIN, IRQ_LEVEL_LOW);
 		irq = GD82559_1_IRQ;
 		break;
 	case 13:
 		vr41xx_set_irq_trigger(GD82559_2_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(GD82559_2_PIN, LEVEL_LOW);
+				       IRQ_TRIGGER_LEVEL,
+				       IRQ_SIGNAL_THROUGH);
+		vr41xx_set_irq_level(GD82559_2_PIN, IRQ_LEVEL_LOW);
 		irq = GD82559_2_IRQ;
 		break;
 	case 14:
 		switch (pin) {
 		case 1:
 			vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
+					       IRQ_TRIGGER_LEVEL,
+					       IRQ_SIGNAL_THROUGH);
 			vr41xx_set_irq_level(UPD720100_INTA_PIN,
-					     LEVEL_LOW);
+					     IRQ_LEVEL_LOW);
 			irq = UPD720100_INTA_IRQ;
 			break;
 		case 2:
 			vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
+					       IRQ_TRIGGER_LEVEL,
+					       IRQ_SIGNAL_THROUGH);
 			vr41xx_set_irq_level(UPD720100_INTB_PIN,
-					     LEVEL_LOW);
+					     IRQ_LEVEL_LOW);
 			irq = UPD720100_INTB_IRQ;
 			break;
 		case 3:
 			vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
+					       IRQ_TRIGGER_LEVEL,
+					       IRQ_SIGNAL_THROUGH);
 			vr41xx_set_irq_level(UPD720100_INTC_PIN,
-					     LEVEL_LOW);
+					     IRQ_LEVEL_LOW);
 			irq = UPD720100_INTC_IRQ;
 			break;
 		default:


