Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268009AbTBRSVj>; Tue, 18 Feb 2003 13:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268005AbTBRSUd>; Tue, 18 Feb 2003 13:20:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267997AbTBRSS7>; Tue, 18 Feb 2003 13:18:59 -0500
Subject: PATCH: use ide_execute_command for CD
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:29:16 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCUW-0006D4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only user I'll feed you this time. As with 2.4 I want it to
run for a bit on read only media first 8)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-cd.c linux-2.5.61-ac2/drivers/ide/ide-cd.c
--- linux-2.5.61/drivers/ide/ide-cd.c	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-cd.c	2003-02-18 18:06:17.000000000 +0000
@@ -854,13 +855,10 @@
 	HWIF(drive)->OUTB(xferlen >> 8  , IDE_BCOUNTH_REG);
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
-
+ 
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
-		ide_set_handler (drive, handler, WAIT_CMD, cdrom_timer_expiry);
 		/* packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		ide_execute_command(drive, WIN_PACKETCMD, handler, WAIT_CMD, cdrom_timer_expiry);
 		return ide_started;
 	} else {
 		/* packet command */
