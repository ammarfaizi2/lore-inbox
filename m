Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbUBZDSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbUBZDSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:18:13 -0500
Received: from palrel12.hp.com ([156.153.255.237]:60544 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262667AbUBZDR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:17:29 -0500
Date: Wed, 25 Feb 2004 19:17:28 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] static_taskkick
Message-ID: <20040226031728.GJ32263@bougret.hpl.hp.com>
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

irXXX_static_taskkick.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)


diff -Nru a/include/net/irda/irda_device.h b/include/net/irda/irda_device.h
--- a/include/net/irda/irda_device.h	Mon Feb 16 10:34:17 2004
+++ b/include/net/irda/irda_device.h	Mon Feb 16 10:34:17 2004
@@ -237,7 +237,6 @@
 #endif
 
 void irda_task_delete(struct irda_task *task);
-int  irda_task_kick(struct irda_task *task);
 struct irda_task *irda_task_execute(void *instance, 
 				    IRDA_TASK_CALLBACK function, 
 				    IRDA_TASK_CALLBACK finished, 
diff -Nru a/net/irda/irda_device.c b/net/irda/irda_device.c
--- a/net/irda/irda_device.c	Mon Feb 16 10:34:17 2004
+++ b/net/irda/irda_device.c	Mon Feb 16 10:34:17 2004
@@ -248,7 +248,7 @@
  *    processing, and notify the parent task, that is waiting for this task
  *    to complete.
  */
-int irda_task_kick(struct irda_task *task)
+static int irda_task_kick(struct irda_task *task)
 {
 	int finished = TRUE;
 	int count = 0;
diff -Nru a/net/irda/irsyms.c b/net/irda/irsyms.c
--- a/net/irda/irsyms.c	Mon Feb 16 10:34:17 2004
+++ b/net/irda/irsyms.c	Mon Feb 16 10:34:17 2004
@@ -159,7 +159,6 @@
 EXPORT_SYMBOL(irda_device_register_dongle);
 EXPORT_SYMBOL(irda_device_unregister_dongle);
 EXPORT_SYMBOL(irda_task_execute);
-EXPORT_SYMBOL(irda_task_kick);
 EXPORT_SYMBOL(irda_task_next_state);
 EXPORT_SYMBOL(irda_task_delete);
 
