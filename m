Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTFCW0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFCW0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:26:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26265 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261702AbTFCW0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:26:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kill recreate_proc_ide_device()
Date: Wed, 4 Jun 2003 00:39:49 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306040039.49395.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just tiny cleanup, please apply.
--
Bartlomiej

[ide] kill recreate_proc_ide_device(), it is unused and not needed

 drivers/ide/ide-proc.c |   28 ----------------------------
 include/linux/ide.h    |    1 -
 2 files changed, 29 deletions(-)

diff -puN drivers/ide/ide-proc.c~recreate_proc_ide_device drivers/ide/ide-proc.c
--- linux-2.5.70-bk8/drivers/ide/ide-proc.c~recreate_proc_ide_device	Wed Jun  4 00:06:42 2003
+++ linux-2.5.70-bk8-root/drivers/ide/ide-proc.c	Wed Jun  4 00:06:42 2003
@@ -729,34 +729,6 @@ void create_proc_ide_drives(ide_hwif_t *
 
 EXPORT_SYMBOL(create_proc_ide_drives);
 
-void recreate_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct proc_dir_entry *ent;
-	struct proc_dir_entry *parent = hwif->proc;
-	char name[64];
-
-	if (drive->present && !drive->proc) {
-		drive->proc = proc_mkdir(drive->name, parent);
-		if (drive->proc)
-			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-
-/*
- * assume that we have these already, however, should test FIXME!
- * if (driver) {
- *      ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
- *      ide_add_proc_entries(drive->proc, driver->proc, drive);
- * }
- *
- */
-		sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2, drive->name);
-		ent = proc_symlink(drive->name, proc_ide_root, name);
-		if (!ent)
-			return;
-	}
-}
-
-EXPORT_SYMBOL(recreate_proc_ide_device);
-
 void destroy_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	ide_driver_t *driver = drive->driver;
diff -puN include/linux/ide.h~recreate_proc_ide_device include/linux/ide.h
--- linux-2.5.70-bk8/include/linux/ide.h~recreate_proc_ide_device	Wed Jun  4 00:06:42 2003
+++ linux-2.5.70-bk8-root/include/linux/ide.h	Wed Jun  4 00:06:42 2003
@@ -1115,7 +1115,6 @@ typedef struct {
 #ifdef CONFIG_PROC_FS
 extern void proc_ide_create(void);
 extern void proc_ide_destroy(void);
-extern void recreate_proc_ide_device(ide_hwif_t *, ide_drive_t *);
 extern void destroy_proc_ide_device(ide_hwif_t *, ide_drive_t *);
 extern void destroy_proc_ide_drives(ide_hwif_t *);
 extern void create_proc_ide_interfaces(void);

_

