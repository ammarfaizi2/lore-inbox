Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVJZJlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVJZJlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVJZJlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:41:36 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:15844 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751297AbVJZJlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:41:36 -0400
X-Mailbox-Line: From laurent@antares.localdomain mer oct 26 11:38:47 2005
Message-Id: <20051026093816.661471000@antares.localdomain>
Date: Wed, 26 Oct 2005 11:38:16 +0200
From: Laurent riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Paul Bristow <paul@paulbristow.net>,
       Gadi Oxman <gadio@netvision.net.il>
Subject: [patch] remove ide_driver_t.owner field
Content-Disposition: inline; filename=remove_ide_driver_t_owner.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The structure ide_driver_t have a .owner field which is a duplicate
of .gendriver.owner field (.gen_driver is a struct device_driver).

This patch remove ide_driver_t's owner field.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/ide/ide-cd.c     |    2 +-
 drivers/ide/ide-disk.c   |    2 +-
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 drivers/scsi/ide-scsi.c  |    2 +-
 include/linux/ide.h      |    4 +++-
 6 files changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6-stable/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6-stable.orig/drivers/ide/ide-disk.c
+++ linux-2.6-stable/drivers/ide/ide-disk.c
@@ -1089,8 +1089,8 @@
 }
 
 static ide_driver_t idedisk_driver = {
-	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.owner		= THIS_MODULE,
 		.name		= "ide-disk",
 		.bus		= &ide_bus_type,
 		.probe		= ide_disk_probe,
Index: linux-2.6-stable/include/linux/ide.h
===================================================================
--- linux-2.6-stable.orig/include/linux/ide.h
+++ linux-2.6-stable/include/linux/ide.h
@@ -1084,9 +1084,11 @@
 
 /*
  * Subdrivers support.
+ *
+ * The gendriver.owner field should be set to the module owner of this driver.
+ * The gendriver.name field should be set to the name of this driver
  */
 typedef struct ide_driver_s {
-	struct module			*owner;
 	const char			*version;
 	u8				media;
 	unsigned supports_dsc_overlap	: 1;
Index: linux-2.6-stable/drivers/ide/ide-cd.c
===================================================================
--- linux-2.6-stable.orig/drivers/ide/ide-cd.c
+++ linux-2.6-stable/drivers/ide/ide-cd.c
@@ -3325,8 +3325,8 @@
 #endif
 
 static ide_driver_t ide_cdrom_driver = {
-	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.owner		= THIS_MODULE,
 		.name		= "ide-cdrom",
 		.bus		= &ide_bus_type,
 		.probe		= ide_cd_probe,
Index: linux-2.6-stable/drivers/scsi/ide-scsi.c
===================================================================
--- linux-2.6-stable.orig/drivers/scsi/ide-scsi.c
+++ linux-2.6-stable/drivers/scsi/ide-scsi.c
@@ -777,8 +777,8 @@
 #endif
 
 static ide_driver_t idescsi_driver = {
-	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.owner		= THIS_MODULE,
 		.name		= "ide-scsi",
 		.bus		= &ide_bus_type,
 		.probe		= ide_scsi_probe,
Index: linux-2.6-stable/drivers/ide/ide-floppy.c
===================================================================
--- linux-2.6-stable.orig/drivers/ide/ide-floppy.c
+++ linux-2.6-stable/drivers/ide/ide-floppy.c
@@ -1925,8 +1925,8 @@
 static int ide_floppy_probe(struct device *);
 
 static ide_driver_t idefloppy_driver = {
-	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.owner		= THIS_MODULE,
 		.name		= "ide-floppy",
 		.bus		= &ide_bus_type,
 		.probe		= ide_floppy_probe,
Index: linux-2.6-stable/drivers/ide/ide-tape.c
===================================================================
--- linux-2.6-stable.orig/drivers/ide/ide-tape.c
+++ linux-2.6-stable/drivers/ide/ide-tape.c
@@ -4743,8 +4743,8 @@
 static int ide_tape_probe(struct device *);
 
 static ide_driver_t idetape_driver = {
-	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.owner		= THIS_MODULE,
 		.name		= "ide-tape",
 		.bus		= &ide_bus_type,
 		.probe		= ide_tape_probe,

--

