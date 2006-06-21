Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWFUOdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWFUOdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWFUOdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:33:23 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:57321
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751629AbWFUOdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:33:17 -0400
Subject: [PATCH] fix synclink_gt diagnostics error reporting
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:33:09 -0500
Message-Id: <1150900389.3708.8.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix diagnostics error reporting that was being
overwritten by incorrect use of return codes from
individual diagnostic functions.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/synclink_gt.c	2006-06-21 09:04:11.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-06-21 09:24:51.000000000 -0500
@@ -4671,13 +4671,13 @@ static int loopback_test(struct slgt_inf
 static int adapter_test(struct slgt_info *info)
 {
 	DBGINFO(("testing %s\n", info->device_name));
-	if ((info->init_error = register_test(info)) < 0) {
+	if (register_test(info) < 0) {
 		printk("register test failure %s addr=%08X\n",
 			info->device_name, info->phys_reg_addr);
-	} else if ((info->init_error = irq_test(info)) < 0) {
+	} else if (irq_test(info) < 0) {
 		printk("IRQ test failure %s IRQ=%d\n",
 			info->device_name, info->irq_level);
-	} else if ((info->init_error = loopback_test(info)) < 0) {
+	} else if (loopback_test(info) < 0) {
 		printk("loopback test failure %s\n", info->device_name);
 	}
 	return info->init_error;



