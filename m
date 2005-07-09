Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVGINTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVGINTK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVGINTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:19:10 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:43464 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261382AbVGINTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:19:08 -0400
Date: Sat, 9 Jul 2005 22:18:56 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc2-mm1] add PCI IRQ initialization to TB0219
Message-Id: <20050709221856.535dc779.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch had added PCI IRQ initialization to TB0219 driver.
Please apply.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/drivers/char/tb0219.c mm1/drivers/char/tb0219.c
--- mm1-orig/drivers/char/tb0219.c	2005-07-06 12:46:33.000000000 +0900
+++ mm1/drivers/char/tb0219.c	2005-07-09 17:26:34.395047032 +0900
@@ -24,6 +24,8 @@
 
 #include <asm/io.h>
 #include <asm/reboot.h>
+#include <asm/vr41xx/giu.h>
+#include <asm/vr41xx/tb0219.h>
 
 MODULE_AUTHOR("Yoichi Yuasa <yuasa@hh.iij4u.or.jp>");
 MODULE_DESCRIPTION("TANBAC TB0219 base board driver");
@@ -266,6 +268,21 @@
 	tb0219_write(TB0219_RESET, 0);
 }
 
+static void tb0219_pci_irq_init(void)
+{
+	/* PCI Slot 1 */
+	vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN, IRQ_TRIGGER_LEVEL, IRQ_SIGNAL_THROUGH);
+	vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN, IRQ_LEVEL_LOW);
+
+	/* PCI Slot 2 */
+	vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN, IRQ_TRIGGER_LEVEL, IRQ_SIGNAL_THROUGH);
+	vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN, IRQ_LEVEL_LOW);
+
+	/* PCI Slot 3 */
+	vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN, IRQ_TRIGGER_LEVEL, IRQ_SIGNAL_THROUGH);
+	vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, IRQ_LEVEL_LOW);
+}
+
 static int tb0219_probe(struct device *dev)
 {
 	int retval;
@@ -292,6 +309,8 @@
 	old_machine_restart = _machine_restart;
 	_machine_restart = tb0219_restart;
 
+	tb0219_pci_irq_init();
+
 	if (major == 0) {
 		major = retval;
 		printk(KERN_INFO "TB0219: major number %d\n", major);

