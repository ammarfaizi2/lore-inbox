Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRAAGO5>; Mon, 1 Jan 2001 01:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131517AbRAAGOs>; Mon, 1 Jan 2001 01:14:48 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:54950 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131496AbRAAGO2>; Mon, 1 Jan 2001 01:14:28 -0500
Date: Sun, 31 Dec 2000 21:44:01 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: langa2@kph.uni-mainz.de
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.0-prerelease/drivers/scsi/ibmmca.c module fixes
Message-ID: <20001231214401.A17659@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.0-prerelease/drivers/scsi/ibmmca.c does not link
as a module because some necessary code is bracketed in 
"#ifdef CONFIG_SCSI_IBMMCA", when it should be brakceted in
"#if defined(CONFIG_SCSI_IBMMCA) || defined(CONFIG_SCSI_IBMMCA_MODULE)".

	The driver also had a symbol versioning problem a while ago,
which was somehow related to the fact that it included <linux/module.h>
pretty late in the source code.  I am not sure if that problem still
exists, but putting "#include <linux/module.h>" in the initial block of
includes without any ifdefs seems to be the standard, so this change
should be regarded as a stylistic cleanup even if we are not forced
to make the change.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ibmmca.diffs"

--- linux-2.4.0-prerelease/drivers/scsi/ibmmca.c	Sun Dec 31 09:36:15 2000
+++ linux/drivers/scsi/ibmmca.c	Sun Dec 31 21:21:20 2000
@@ -16,6 +16,8 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
 #error "This driver works only with kernel 2.4.0 or higher!"
 #endif
+
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/ctype.h>
@@ -443,7 +445,6 @@
    (that is kernel version 2.1.x) */
 #if defined(MODULE)
 static char *boot_options = NULL;
-#include <linux/module.h>
 MODULE_PARM(boot_options, "s");
 MODULE_PARM(io_port, "1-" __MODULE_STRING(IM_MAX_HOSTS) "i");
 MODULE_PARM(scsi_id, "1-" __MODULE_STRING(IM_MAX_HOSTS) "i");
@@ -1399,7 +1400,7 @@
    return 0;
 }
 
-#ifdef CONFIG_SCSI_IBMMCA
+#if defined(CONFIG_SCSI_IBMMCA) || defined(CONFIG_SCSI_IBMMCA_MODULE)
 void internal_ibmmca_scsi_setup (char *str, int *ints)
 {
    int i, j, io_base, id_base;

--+HP7ph2BbKc20aGI--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
