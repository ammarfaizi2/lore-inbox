Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbTGLOka (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbTGLOka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:40:30 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:5291 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265823AbTGLOk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:40:28 -0400
Subject: [PATCH] parport_pc.c compile warning
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-thWQqjGHmCx12OwszLJF"
Organization: 
Message-Id: <1058021712.10870.19.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jul 2003 10:55:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-thWQqjGHmCx12OwszLJF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes the following warning:

drivers/parport/parport_pc.c:98: warning: `verbose_probing' defined but
not used

Compile tested only. Also included as an attachment.

--- linux-2.5.75-mm1/drivers/parport/parport_pc.c.orig  Sat Jul 12
09:22:36 2003
+++ linux-2.5.75-mm1/drivers/parport/parport_pc.c       Sat Jul 12
10:18:03 2003
@@ -94,7 +94,8 @@
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
 static int user_specified __devinitdata = 0;
-#if defined(CONFIG_PARPORT_PC_FIFO) ||
defined(CONFIG_PARPORT_PC_SUPERIO)
+#if defined(CONFIG_PARPORT_PC_SUPERIO) || \
+       (defined(CONFIG_PARPORT_1284) &&
defined(CONFIG_PARPORT_PC_FIFO))
 static int verbose_probing;
 #endif
 static int registered_parport;
@@ -3116,7 +3117,8 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(PARPORT_PC_MAX_PORTS) "s");
 MODULE_PARM_DESC(dma, "DMA channel");
 MODULE_PARM(dma, "1-" __MODULE_STRING(PARPORT_PC_MAX_PORTS) "s");
-#if defined(CONFIG_PARPORT_PC_FIFO) ||
defined(CONFIG_PARPORT_PC_SUPERIO)
+#if defined(CONFIG_PARPORT_PC_SUPERIO) || \
+       (defined(CONFIG_PARPORT_1284) &&
defined(CONFIG_PARPORT_PC_FIFO))
 MODULE_PARM_DESC(verbose_probing, "Log chit-chat during
initialisation");
 MODULE_PARM(verbose_probing, "i");
 #endif

Regards,

shane

--=-thWQqjGHmCx12OwszLJF
Content-Disposition: attachment; filename=parport_pc.compile.warning.diff
Content-Type: text/x-diff; name=parport_pc.compile.warning.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.75-mm1/drivers/parport/parport_pc.c.orig	Sat Jul 12 09:22:36 2003
+++ linux-2.5.75-mm1/drivers/parport/parport_pc.c	Sat Jul 12 10:18:03 2003
@@ -94,7 +94,8 @@
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
 static int user_specified __devinitdata = 0;
-#if defined(CONFIG_PARPORT_PC_FIFO) || defined(CONFIG_PARPORT_PC_SUPERIO)
+#if defined(CONFIG_PARPORT_PC_SUPERIO) || \
+	(defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
 static int verbose_probing;
 #endif
 static int registered_parport;
@@ -3116,7 +3117,8 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(PARPORT_PC_MAX_PORTS) "s");
 MODULE_PARM_DESC(dma, "DMA channel");
 MODULE_PARM(dma, "1-" __MODULE_STRING(PARPORT_PC_MAX_PORTS) "s");
-#if defined(CONFIG_PARPORT_PC_FIFO) || defined(CONFIG_PARPORT_PC_SUPERIO)
+#if defined(CONFIG_PARPORT_PC_SUPERIO) || \
+	(defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
 MODULE_PARM_DESC(verbose_probing, "Log chit-chat during initialisation");
 MODULE_PARM(verbose_probing, "i");
 #endif

--=-thWQqjGHmCx12OwszLJF--

