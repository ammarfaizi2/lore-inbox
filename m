Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTESEuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 00:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTESEuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 00:50:32 -0400
Received: from dp.samba.org ([66.70.73.150]:53406 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262126AbTESEub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 00:50:31 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16072.25976.912797.769942@argo.ozlabs.ibm.com>
Date: Mon, 19 May 2003 15:02:48 +1000
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, jgarzik@pobox.com
Subject: [PATCH] module refcounts for airport driver
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch takes out the MOD_INC/DEC_USE_COUNT in the airport (Apple
wireless ethernet) driver.  The driver already does SET_MODULE_OWNER
on the netdevice, so the MOD_INC/DEC_USE_COUNT are unnecessary and
just cause warnings.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/net/wireless/airport.c pmac-2.5/drivers/net/wireless/airport.c
--- linux-2.5/drivers/net/wireless/airport.c	2003-02-21 09:48:09.000000000 +1100
+++ pmac-2.5/drivers/net/wireless/airport.c	2003-04-23 22:04:33.000000000 +1000
@@ -275,15 +275,11 @@
 
 	printk(KERN_DEBUG "%s\n", version);
 
-	MOD_INC_USE_COUNT;
-
 	/* Lookup card in device tree */
 	airport_node = find_devices("radio");
 	if (airport_node && !strcmp(airport_node->parent->name, "mac-io"))
 		airport_dev = airport_attach(airport_node);
 
-	MOD_DEC_USE_COUNT;
-
 	return airport_dev ? 0 : -ENODEV;
 }
 
