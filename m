Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267901AbTBNU6u>; Fri, 14 Feb 2003 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbTBNU4y>; Fri, 14 Feb 2003 15:56:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267505AbTBNUy7>; Fri, 14 Feb 2003 15:54:59 -0500
Subject: PATCH: fix NCR53c406a for new scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:04:58 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn10-0005gE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/NCR53c406a.c linux-2.5.60-ac1/drivers/scsi/NCR53c406a.c
--- linux-2.5.60-ref/drivers/scsi/NCR53c406a.c	2003-02-14 21:21:36.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/NCR53c406a.c	2003-02-14 20:18:25.000000000 +0000
@@ -697,7 +697,7 @@
 
 	/* We are locked here already by the mid layer */
 	REG0;
-	outb(SCpnt->target, DEST_ID);	/* set destination */
+	outb(SCpnt->device->id, DEST_ID);	/* set destination */
 	outb(FLUSH_FIFO, CMD_REG);	/* reset the fifos */
 
 	for (i = 0; i < SCpnt->cmd_len; i++) {
