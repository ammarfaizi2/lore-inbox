Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUIQQmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUIQQmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUIQPcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:32:14 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:33777 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S268844AbUIQO5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:57:13 -0400
Date: Fri, 17 Sep 2004 23:57:06 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed undeclared giu_cascade
Message-Id: <20040917235706.799a2ffc.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change had fixed undeclared identifier in arch/mips/vr41xx/common/giu.c

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff vr-orig/arch/mips/vr41xx/common/giu.c vr/arch/mips/vr41xx/common/giu.c
--- vr-orig/arch/mips/vr41xx/common/giu.c	2004-09-13 14:31:30.000000000 +0900
+++ vr/arch/mips/vr41xx/common/giu.c	2004-09-17 17:15:30.000000000 +0900
@@ -63,6 +63,12 @@
 
 static uint32_t giu_base;
 
+static struct irqaction giu_cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 #define read_giuint(offset)		readw(giu_base + (offset))
 #define write_giuint(val, offset)	writew((val), giu_base + (offset))
 
@@ -303,7 +309,6 @@
 };
 
 static struct vr41xx_giuint_cascade giuint_cascade[GIUINT_NR_IRQS];
-static struct irqaction giu_cascade = {no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 static int no_irq_number(int irq)
 {
