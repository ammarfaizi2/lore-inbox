Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTBNU6w>; Fri, 14 Feb 2003 15:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTBNU4g>; Fri, 14 Feb 2003 15:56:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267546AbTBNUzx>; Fri, 14 Feb 2003 15:55:53 -0500
Subject: PATCH: fix sym53c416 for new scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:05:43 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn1j-0005gi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/sym53c416.c linux-2.5.60-ac1/drivers/scsi/sym53c416.c
--- linux-2.5.60-ref/drivers/scsi/sym53c416.c	2003-02-14 21:45:55.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/sym53c416.c	2003-02-14 20:19:29.000000000 +0000
@@ -1,4 +1,4 @@
-/* 
+/*
  *  sym53c416.c
  *  Low-level SCSI driver for sym53c416 chip.
  *  Copyright (C) 1998 Lieven Willems (lw_linux@hotmail.com)
@@ -763,7 +763,7 @@
 	int i;
 
 	/* Store base register as we can have more than one controller in the system */
-	base = SCpnt->host->io_port;
+	base = SCpnt->device->host->io_port;
 	current_command = SCpnt;                  /* set current command                */
 	current_command->scsi_done = done;        /* set ptr to done function           */
 	current_command->SCp.phase = command_ph;  /* currect phase is the command phase */
@@ -771,7 +771,7 @@
 	current_command->SCp.Message = 0;
 
 	spin_lock_irqsave(&sym53c416_lock, flags);
-	outb(SCpnt->target, base + DEST_BUS_ID); /* Set scsi id target        */
+	outb(SCpnt->device->id, base + DEST_BUS_ID); /* Set scsi id target        */
 	outb(FLUSH_FIFO, base + COMMAND_REG);    /* Flush SCSI and PIO FIFO's */
 	/* Write SCSI command into the SCSI fifo */
 	for(i = 0; i < SCpnt->cmd_len; i++)
@@ -819,7 +819,7 @@
 	int i;
 
 	/* printk("sym53c416_reset\n"); */
-	base = SCpnt->host->io_port;
+	base = SCpnt->device->host->io_port;
 	/* search scsi_id - fixme, we shouldnt need to iterate for this! */
 	for(i = 0; i < host_index && scsi_id != -1; i++)
 		if(hosts[i].base == base)
