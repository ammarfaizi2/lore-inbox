Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUIQQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUIQQmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUIQPcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:32:52 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:40166 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S268812AbUIQPAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:00:24 -0400
Date: Sat, 18 Sep 2004 00:00:14 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed initialization error
Message-Id: <20040918000014.346b48ea.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change had fixed initialization error in arch/mips/vr41xx/common/icu.c

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff vr-orig/arch/mips/vr41xx/common/icu.c vr/arch/mips/vr41xx/common/icu.c
--- vr-orig/arch/mips/vr41xx/common/icu.c	2004-09-13 14:31:27.000000000 +0900
+++ vr/arch/mips/vr41xx/common/icu.c	2004-09-17 17:15:30.000000000 +0900
@@ -51,6 +51,12 @@
 static uint32_t icu1_base;
 static uint32_t icu2_base;
 
+static struct irqaction icu_cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 static unsigned char sysint1_assign[16] = {
 	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 static unsigned char sysint2_assign[16] = {
@@ -674,8 +680,6 @@
 
 /*=======================================================================*/
 
-static struct irqaction icu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
-
 static inline void init_vr41xx_icu_irq(void)
 {
 	int i;
