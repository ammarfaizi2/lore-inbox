Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVBTLod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVBTLod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 06:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVBTLod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 06:44:33 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:33250 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261816AbVBTLo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 06:44:27 -0500
Date: Sun, 20 Feb 2005 12:34:14 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: axboe@suse.de
Subject: [patch ide] fix ide_get_error_location() for LBA28
Message-ID: <Pine.GSO.4.58.0502201230250.5252@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Higher bits (16-23) of the address were ignored

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-19 17:38:53 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-19 17:38:53 +01:00
@@ -238,9 +238,10 @@
 		high = ide_read_24(drive);
 	} else {
 		u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
-		if (cur & 0x40)
+		if (cur & 0x40) {
+			high = cur & 0xf;
 			low = (hcyl << 16) | (lcyl << 8) | sect;
-		else {
+		} else {
 			low = hcyl * drive->head * drive->sect;
 			low += lcyl * drive->sect;
 			low += sect - 1;
