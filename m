Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTEKKcs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTEKKYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:24:23 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:61775 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261243AbTEKKVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:39 -0400
Date: Sun, 11 May 2003 12:31:04 +0200
Message-Id: <200305111031.h4BAV4Pg019718@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k wd33c93_{abort,host_reset}()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use new wd33c93_{abort,host_reset}() routines introduced in 2.5.67 in the m68k
wd33c93-based SCSI host adapter drivers:
  - Amiga A2091 SCSI
  - Amiga A3000 SCSI
  - Amiga GVP Series II SCSI
  - MVME147 SCSI

These drivers still have to implement their own adapter-specific bus_reset()
routines!

--- linux-2.5.x/drivers/scsi/a2091.c	Fri Feb 14 13:25:53 2003
+++ linux-m68k-2.5.x/drivers/scsi/a2091.c	Tue Apr  8 14:30:24 2003
@@ -229,6 +229,13 @@
     return num_a2091;
 }
 
+static int a2091_bus_reset(Scsi_Cmnd *cmd)
+{
+	/* FIXME perform bus-specific reset */
+	wd33c93_host_reset(cmd);
+	return SUCCESS;
+}
+
 #define HOSTS_C
 
 static Scsi_Host_Template driver_template = {
@@ -237,8 +244,9 @@
 	.detect			= a2091_detect,
 	.release		= a2091_release,
 	.queuecommand		= wd33c93_queuecommand,
-	.abort			= wd33c93_abort,
-	.reset			= wd33c93_reset,
+	.eh_abort_handler	= wd33c93_abort,
+	.eh_bus_reset_handler	= a2091_bus_reset,
+	.eh_host_reset_handler	= wd33c93_host_reset,
 	.can_queue		= CAN_QUEUE,
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
--- linux-2.5.x/drivers/scsi/a3000.c	Thu Feb 27 22:19:56 2003
+++ linux-m68k-2.5.x/drivers/scsi/a3000.c	Tue Apr  8 14:29:16 2003
@@ -205,6 +205,13 @@
     return 0;
 }
 
+static int a3000_bus_reset(Scsi_Cmnd *cmd)
+{
+	/* FIXME perform bus-specific reset */
+	wd33c93_host_reset(cmd);
+	return SUCCESS;
+}
+
 #define HOSTS_C
 
 static Scsi_Host_Template driver_template = {
@@ -213,8 +220,9 @@
 	.detect			= a3000_detect,
 	.release		= a3000_release,
 	.queuecommand		= wd33c93_queuecommand,
-	.abort			= wd33c93_abort,
-	.reset			= wd33c93_reset,
+	.eh_abort_handler	= wd33c93_abort,
+	.eh_bus_reset_handler	= a3000_bus_reset,
+	.eh_host_reset_handler	= wd33c93_host_reset,
 	.can_queue		= CAN_QUEUE,
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
--- linux-2.5.x/drivers/scsi/gvp11.c	Fri Feb 14 13:25:54 2003
+++ linux-m68k-2.5.x/drivers/scsi/gvp11.c	Tue Apr  8 14:31:34 2003
@@ -352,6 +352,13 @@
     return num_gvp11;
 }
 
+static int gvp11_bus_reset(Scsi_Cmnd *cmd)
+{
+	/* FIXME perform bus-specific reset */
+	wd33c93_host_reset(cmd);
+	return SUCCESS;
+}
+
 
 #define HOSTS_C
 
@@ -363,8 +370,9 @@
 	.detect			= gvp11_detect,
 	.release		= gvp11_release,
 	.queuecommand		= wd33c93_queuecommand,
-	.abort			= wd33c93_abort,
-	.reset			= wd33c93_reset,
+	.eh_abort_handler	= wd33c93_abort,
+	.eh_bus_reset_handler	= gvp11_bus_reset,
+	.eh_host_reset_handler	= wd33c93_host_reset,
 	.can_queue		= CAN_QUEUE,
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,
--- linux-2.5.x/drivers/scsi/mvme147.c	Wed Nov 20 11:36:30 2002
+++ linux-m68k-2.5.x/drivers/scsi/mvme147.c	Tue Apr  8 14:32:35 2003
@@ -112,6 +112,13 @@
     return 0;
 }
 
+static int mvme147_bus_reset(Scsi_Cmnd *cmd)
+{
+	/* FIXME perform bus-specific reset */
+	wd33c93_host_reset(cmd);
+	return SUCCESS;
+}
+
 #define HOSTS_C
 
 #include "mvme147.h"
@@ -122,8 +129,9 @@
 	.detect			= mvme147_detect,
 	.release		= mvme147_release,
 	.queuecommand		= wd33c93_queuecommand,
-	.abort			= wd33c93_abort,
-	.reset			= wd33c93_reset,
+	.eh_abort_handler	= wd33c93_abort,
+	.eh_bus_reset_handler	= mvme147_bus_reset,
+	.eh_host_reset_handler	= wd33c93_host_reset,
 	.can_queue		= CAN_QUEUE,
 	.this_id		= 7,
 	.sg_tablesize		= SG_ALL,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
