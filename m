Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUIXA21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUIXA21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIXAXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:23:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:52448 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267619AbUIXAVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:21:54 -0400
Subject: [PATCH] ppc32: Fix potentially uninitialized var in chrp_setup.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095985302.3830.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 10:21:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

In chrp_setup.c, chrp_int_ack could be left uninitialized and passed
"as-is" to i8259_init() if the OF node for the 8259 wasn't found. I
don't know if that should happen, but the i8259 code can deal with
int_ack beeing 0, so let's be safe, initialize it, and remove a
warning at the same time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/platforms/chrp_setup.c 1.34 vs edited =====
--- 1.34/arch/ppc/platforms/chrp_setup.c	2004-08-17 02:04:08 +10:00
+++ edited/arch/ppc/platforms/chrp_setup.c	2004-09-24 10:19:34 +10:00
@@ -375,7 +375,7 @@
 {
 	struct device_node *np;
 	int i;
-	unsigned long chrp_int_ack;
+	unsigned long chrp_int_ack = 0;
 	unsigned char init_senses[NR_IRQS - NUM_8259_INTERRUPTS];
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
 	struct device_node *kbd;


