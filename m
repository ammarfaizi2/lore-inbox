Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTJTFcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 01:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTJTFcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 01:32:33 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:13751 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262286AbTJTFc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 01:32:27 -0400
Date: Sun, 19 Oct 2003 22:32:23 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: [PATCH] Fix drivers/ide/pci/siimage.c for PROC_FS=n
Message-ID: <Pine.GSO.4.58.0310171451240.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Bartlomiej,

I'm sending this patch to you as the IDE maintainer; please let me know if one
of the authors of the driver in question should take it instead.

The Silicon Image SATA driver is not building properly when CONFIG_PROC_FS is
unset.  This patch corrects that problem.  It appears as though several utility
functions at the top of drivers/ide/pci/siimage.c that the driver always needs
accidentally fell within an #ifdef CONFIG_PROC_FS.  I also removed an excess
include while I noticed it.

The patch applies to linux-2.5 BK as of 0400 UTC 10/20/2003.  I successfully
compiled the driver without PROC_FS and also did a successful allyesconfig build
on i386 with this change applied.  Since I do not have this hardware, I could
not test the driver in operation, but I think the change is straightforward.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1346  -> 1.1347
#	drivers/ide/pci/siimage.c	1.16    -> 1.17
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/16	noah@caltech.edu	1.1347
# Make several functions in drivers/ide/pci/siimage.c compile regardless
# of CONFIG_PROC_FS.  They are generally applicable, and leaving them out
# prevents building the driver without CONFIG_PROC_FS.
# --------------------------------------------
#
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	Thu Oct 16 19:44:07 2003
+++ b/drivers/ide/pci/siimage.c	Thu Oct 16 19:44:07 2003
@@ -35,13 +35,13 @@
 #include "siimage.h"

 #if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
 #include <linux/proc_fs.h>

 static u8 siimage_proc = 0;
 #define SIIMAGE_MAX_DEVS		16
 static struct pci_dev *siimage_devs[SIIMAGE_MAX_DEVS];
 static int n_siimage_devs;
+#endif /* defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS) */

 /**
  *	pdev_is_sata		-	check if device is SATA
@@ -120,6 +120,8 @@
 	base |= drive->select.b.unit << drive->select.b.unit;
 	return base;
 }
+
+#if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)

 /**
  *	print_siimage_get_info	-	print minimal proc information

