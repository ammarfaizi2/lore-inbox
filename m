Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVBDDBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVBDDBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVBDCyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:54:54 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:28340 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263226AbVBDCxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:53:34 -0500
Date: Fri, 4 Feb 2005 03:50:04 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 4/9] destroy_proc_ide_device() cleanup
Message-ID: <Pine.GSO.4.58.0502040349370.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When this function is called device is already unbinded from a
driver so there are no driver /proc entries to remove.

diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2005-02-04 03:31:24 +01:00
+++ b/drivers/ide/ide-proc.c	2005-02-04 03:31:24 +01:00
@@ -421,10 +421,7 @@

 static void destroy_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	ide_driver_t *driver = drive->driver;
-
 	if (drive->proc) {
-		ide_remove_proc_entries(drive->proc, driver->proc);
 		ide_remove_proc_entries(drive->proc, generic_drive_entries);
 		remove_proc_entry(drive->name, proc_ide_root);
 		remove_proc_entry(drive->name, hwif->proc);
