Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVCANuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVCANuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCANuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:50:46 -0500
Received: from mail.mplayerhq.hu ([192.190.173.45]:50329 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP id S261902AbVCANu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:50:26 -0500
Date: Tue, 1 Mar 2005 14:50:18 +0100 (CET)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide_init_disk
Message-ID: <Pine.LNX.4.58.0503011443330.26569@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DCC-sgs-Metrics: mail 1199; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My /dev/hdb showed up as /dev/hdq

The bug was introduced with bk-ide-dev.patch

Bye,
Szabi

--- linux-2.6.11-rc4-mm1/drivers/ide/ide-probe.c.orig	2005-02-24 20:04:03.000000000 +0100
+++ linux-2.6.11-rc4-mm1/drivers/ide/ide-probe.c	2005-02-27 23:52:54.000000000 +0100
@@ -1269,7 +1269,7 @@
 void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	unsigned int unit = drive->select.all & (1 << 4);
+	unsigned int unit = drive->select.b.unit;

 	disk->major = hwif->major;
 	disk->first_minor = unit << PARTN_BITS;

