Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbTFWXBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbTFWW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:59:18 -0400
Received: from palrel12.hp.com ([156.153.255.237]:22997 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265546AbTFWW55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:57:57 -0400
Date: Mon, 23 Jun 2003 16:12:00 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4 IrDA]  Static init fixes
Message-ID: <20030623231200.GJ12593@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo,

	This make the static initialisation of some IrDA driver a bit
less broken.
	Please apply ;-)

	Jean


ir241_static_init.diff :
----------------------
	o [CORRECT] fix some obvious static init bugs.


diff -u -p linux/net/irda/irda_device.d0.c linux/net/irda/irda_device.c
--- linux/net/irda/irda_device.d0.c	Mon Jun 16 16:57:31 2003
+++ linux/net/irda/irda_device.c	Mon Jun 16 17:06:46 2003
@@ -68,6 +68,7 @@ extern int actisys_init(void);
 extern int girbil_init(void);
 extern int sa1100_irda_init(void);
 extern int ep7211_ir_init(void);
+extern int mcp2120_init(void);
 
 static void __irda_task_delete(struct irda_task *task);
 
@@ -122,6 +123,9 @@ int __init irda_device_init( void)
 	/* 
 	 * Call the init function of the device drivers that has not been
 	 * compiled as a module 
+	 * Note : non-modular IrDA is not supported in 2.4.X, so don't
+	 * waste too much time fixing this code. If you require it, please
+	 * upgrade to the IrDA stack in 2.5.X. Jean II
 	 */
 #ifdef CONFIG_IRTTY_SIR
 	irtty_init();
@@ -135,7 +139,7 @@ int __init irda_device_init( void)
 #ifdef CONFIG_NSC_FIR
 	nsc_ircc_init();
 #endif
-#ifdef CONFIG_TOSHIBA_FIR
+#ifdef CONFIG_TOSHIBA_OLD
 	toshoboe_init();
 #endif
 #ifdef CONFIG_SMC_IRCC_FIR
@@ -161,6 +165,9 @@ int __init irda_device_init( void)
 #endif
 #ifdef CONFIG_EP7211_IR
  	ep7211_ir_init();
+#endif
+#ifdef CONFIG_MCP2120_DONGLE
+	mcp2120_init();
 #endif
 	return 0;
 }

