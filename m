Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVBXOvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVBXOvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVBXOsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:48:45 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51105 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262360AbVBXOsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:03 -0500
Date: Thu, 24 Feb 2005 15:44:34 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 6/9] check capacity in ide_task_init_flush()
Message-ID: <Pine.GSO.4.58.0502241544040.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use WIN_FLUSH_CACHE_EXT only if disk requires LBA48.

diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-23 20:58:16 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-23 20:58:16 +01:00
@@ -61,7 +61,8 @@

 	memset(task, 0, sizeof(*task));

-	if (ide_id_has_flush_cache_ext(drive->id)) {
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28))) {
 		tf->command = WIN_FLUSH_CACHE_EXT;
 		tf->flags |= ATA_TFLAG_LBA48;
 	} else
