Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWHNRxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWHNRxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHNRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:53:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:24247 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932576AbWHNRxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:53:01 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:51:52 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 7/8] ieee1394: sbp2: update includes
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.68c328e68f736b14@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused includes.  Add missing includes, i.e. explicitly include
all used headers.  Sort includes alphabetically.  Replace one call to
signal_pending(current) to avoid to include headers just for this line.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   49 ++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 22 deletions(-)

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-08-14 00:27:43.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-14 00:28:25.000000000 +0200
@@ -38,31 +38,36 @@
  *	  but the code needs additional debugging.
  */
 
+#include <linux/blkdev.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/string.h>
-#include <linux/stringify.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/blkdev.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/stringify.h>
+#include <linux/types.h>
 #include <linux/wait.h>
 
-#include <asm/current.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
 #include <asm/byteorder.h>
-#include <asm/system.h>
+#include <asm/errno.h>
+#include <asm/param.h>
 #include <asm/scatterlist.h>
+#include <asm/system.h>
+#include <asm/types.h>
+
+#ifdef CONFIG_IEEE1394_SBP2_PHYS_DMA
+#include <asm/io.h> /* for bus_to_virt */
+#endif
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -71,13 +76,14 @@
 #include <scsi/scsi_host.h>
 
 #include "csr1212.h"
+#include "highlevel.h"
+#include "hosts.h"
 #include "ieee1394.h"
-#include "ieee1394_types.h"
 #include "ieee1394_core.h"
-#include "nodemgr.h"
-#include "hosts.h"
-#include "highlevel.h"
+#include "ieee1394_hotplug.h"
 #include "ieee1394_transactions.h"
+#include "ieee1394_types.h"
+#include "nodemgr.h"
 #include "sbp2.h"
 
 /*
@@ -1021,8 +1027,7 @@ static int sbp2_start_device(struct scsi
 	 * connected to the sbp2 device being removed. That host would
 	 * have a certain amount of time to relogin before the sbp2 device
 	 * allows someone else to login instead. One second makes sense. */
-	msleep_interruptible(1000);
-	if (signal_pending(current)) {
+	if (msleep_interruptible(1000)) {
 		sbp2_remove_device(scsi_id);
 		return -EINTR;
 	}


