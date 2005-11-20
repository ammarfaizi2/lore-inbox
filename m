Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVKTCrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVKTCrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 21:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKTCrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 21:47:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60167 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751161AbVKTCrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 21:47:18 -0500
Date: Sun, 20 Nov 2005 03:47:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/: small cleanups
Message-ID: <20051120024717.GX16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- every file should #include the headers containing the prototypes for
  it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/scsi_sysctl.c       |    1 +
 drivers/scsi/scsi_sysfs.c        |    3 ++-
 drivers/scsi/scsi_transport_fc.c |    2 +-
 drivers/scsi/sr.c                |    2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/scsi/scsi_sysfs.c.old	2005-11-20 03:09:18.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/scsi_sysfs.c	2005-11-20 03:14:13.000000000 +0100
@@ -17,6 +17,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_transport.h>
+#include <scsi/scsi_driver.h>
 
 #include "scsi_priv.h"
 #include "scsi_logging.h"
@@ -720,7 +721,7 @@
 }
 EXPORT_SYMBOL(scsi_remove_device);
 
-void __scsi_remove_target(struct scsi_target *starget)
+static void __scsi_remove_target(struct scsi_target *starget)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	unsigned long flags;
--- linux-2.6.15-rc1-mm2-full/drivers/scsi/scsi_sysctl.c.old	2005-11-20 03:10:57.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/scsi_sysctl.c	2005-11-20 03:11:08.000000000 +0100
@@ -9,6 +9,7 @@
 #include <linux/sysctl.h>
 
 #include "scsi_logging.h"
+#include "scsi_priv.h"
 
 
 static ctl_table scsi_table[] = {
--- linux-2.6.15-rc1-mm2-full/drivers/scsi/scsi_transport_fc.c.old	2005-11-20 03:11:38.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/scsi_transport_fc.c	2005-11-20 03:11:50.000000000 +0100
@@ -1274,7 +1274,7 @@
  * Notes:
  *	This routine assumes no locks are held on entry.
  **/
-struct fc_rport *
+static struct fc_rport *
 fc_rport_create(struct Scsi_Host *shost, int channel,
 	struct fc_rport_identifiers  *ids)
 {
--- linux-2.6.15-rc1-mm2-full/drivers/scsi/sr.c.old	2005-11-20 03:18:12.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/sr.c	2005-11-20 03:18:21.000000000 +0100
@@ -170,7 +170,7 @@
  * an inode for that to work, and we do not always have one.
  */
 
-int sr_media_change(struct cdrom_device_info *cdi, int slot)
+static int sr_media_change(struct cdrom_device_info *cdi, int slot)
 {
 	struct scsi_cd *cd = cdi->handle;
 	int retval;

