Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278385AbRJSM7a>; Fri, 19 Oct 2001 08:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278386AbRJSM7V>; Fri, 19 Oct 2001 08:59:21 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:27108 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S278385AbRJSM7M>; Fri, 19 Oct 2001 08:59:12 -0400
Date: Fri, 19 Oct 2001 05:59:44 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: linux-2.4.13-pre5/drivers/message/i2o directory adjustments
Message-ID: <20011019055944.A9176@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Some files in linux-2.4.13-pre5 were not updated to reflect
the fact that drivers/i2o was moved to drivers/message/i2o, so the
kernel will not compile.  Also, it looks like the code expects
the "pdev" field to be part of struct i2o_pci, but the .h file
was not updated.  I have included a possible patch to fix that
problem too, although perhaps the i2o maintainers may wish to
propose a different patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- linux-2.4.13-pre5/drivers/Makefile	Fri Oct 19 00:58:41 2001
+++ linux/drivers/Makefile	Fri Oct 19 05:52:10 2001
@@ -7,7 +7,7 @@
 
 
 mod-subdirs :=	dio mtd sbus video macintosh usb input telephony sgi ide \
-		i2o message/fusion scsi md ieee1394 pnp isdn atm \
+		message/fusion message/i2o scsi md ieee1394 pnp isdn atm \
 		fc4 net/hamradio i2c acpi bluetooth
 
 subdir-y :=	parport char block net sound misc media cdrom
--- linux-2.4.13-pre5/drivers/message/i2o/i2o_scsi.c	Fri Oct 19 00:58:41 2001
+++ linux/drivers/message/i2o/i2o_scsi.c	Fri Oct 19 05:52:44 2001
@@ -48,9 +48,9 @@
 #include <linux/blk.h>
 #include <linux/version.h>
 #include <linux/i2o.h>
-#include "../scsi/scsi.h"
-#include "../scsi/hosts.h"
-#include "../scsi/sd.h"
+#include "../../scsi/scsi.h"
+#include "../../scsi/hosts.h"
+#include "../../scsi/sd.h"
 #include "i2o_scsi.h"
 
 #define VERSION_STRING        "Version 0.0.1"
@@ -909,4 +909,4 @@
 
 static Scsi_Host_Template driver_template = I2OSCSI;
 
-#include "../scsi/scsi_module.c"
+#include "../../scsi/scsi_module.c"
--- /tmp/adam/linux-2.4.13-pre5/include/linux/i2o.h	Fri Oct 19 00:58:42 2001
+++ /tmp/adam/linux/include/linux/i2o.h	Fri Oct 19 05:56:16 2001
@@ -88,6 +89,7 @@
 	int		mtrr_reg0;
 	int		mtrr_reg1;
 #endif
+	struct pci_dev *pdev;		/* PCI device */
 };
 
 /*
@@ -101,8 +103,6 @@
  */
 struct i2o_controller
 {
-	struct pci_dev *pdev;		/* PCI device */
-
 	char name[16];
 	int unit;
 	int type;

--ew6BAiZeqk4r7MaW--
