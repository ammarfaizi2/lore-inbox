Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWIOQub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWIOQub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIOQub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:50:31 -0400
Received: from server6.greatnet.de ([83.133.96.26]:40623 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750754AbWIOQua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:50:30 -0400
Message-ID: <450AD9DA.7030105@nachtwindheim.de>
Date: Fri, 15 Sep 2006 18:50:34 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] scsi: remove seagate.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Removes seagate.h from the kerneltree.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6.18-rc7-git1/drivers/scsi/Kconfig devel/drivers/scsi/Kconfig
--- linux-2.6.18-rc7-git1/drivers/scsi/Kconfig	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/Kconfig	2006-09-15 18:03:12.000000000 +0200
@@ -1368,8 +1368,8 @@
 	  These are 8-bit SCSI controllers; the ST-01 is also supported by
 	  this driver.  It is explained in section 3.9 of the SCSI-HOWTO,
 	  available from <http://www.tldp.org/docs.html#howto>.  If it
-	  doesn't work out of the box, you may have to change some settings in
-	  <file:drivers/scsi/seagate.h>.
+	  doesn't work out of the box, you may have to change some macros at
+	  compiletime, which are described in <file:drivers/scsi/seagate.c>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called seagate.
diff -ruN linux-2.6.18-rc7-git1/drivers/scsi/seagate.c devel/drivers/scsi/seagate.c
--- linux-2.6.18-rc7-git1/drivers/scsi/seagate.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/seagate.c	2006-09-15 17:49:44.000000000 +0200
@@ -106,7 +106,6 @@
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_host.h>
-#include "seagate.h"
 
 #include <scsi/scsi_ioctl.h>
 
@@ -322,6 +321,7 @@
 static int hostno = -1;
 static void seagate_reconnect_intr (int, void *, struct pt_regs *);
 static irqreturn_t do_seagate_reconnect_intr (int, void *, struct pt_regs *);
+static int seagate_st0x_bus_reset(Scsi_Cmnd *);
 
 #ifdef FAST
 static int fast = 1;
diff -ruN linux-2.6.18-rc7-git1/drivers/scsi/seagate.h devel/drivers/scsi/seagate.h
--- linux-2.6.18-rc7-git1/drivers/scsi/seagate.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/seagate.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,19 +0,0 @@
-/*
- *	seagate.h Copyright (C) 1992 Drew Eckhardt 
- *	low level scsi driver header for ST01/ST02 by
- *		Drew Eckhardt 
- *
- *	<drew@colorado.edu>
- */
-
-#ifndef _SEAGATE_H
-#define SEAGATE_H
-
-static int seagate_st0x_detect(struct scsi_host_template *);
-static int seagate_st0x_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-
-static int seagate_st0x_abort(Scsi_Cmnd *);
-static const char *seagate_st0x_info(struct Scsi_Host *);
-static int seagate_st0x_bus_reset(Scsi_Cmnd *);
-
-#endif /* _SEAGATE_H */


