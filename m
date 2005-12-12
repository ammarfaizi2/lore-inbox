Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVLLBgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVLLBgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLLBfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:35:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17680 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750995AbVLLBfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:35:53 -0500
Date: Mon, 12 Dec 2005 02:35:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/: small cleanups
Message-ID: <20051212013553.GK23349@stusta.de>
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

This patch was already sent on:
- 20 Nov 2005

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

