Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTBNU6v>; Fri, 14 Feb 2003 15:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTBNU4k>; Fri, 14 Feb 2003 15:56:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267529AbTBNUzY>; Fri, 14 Feb 2003 15:55:24 -0500
Subject: PATCH: Fix seagate for new scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:05:23 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn1P-0005gY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/seagate.c linux-2.5.60-ac1/drivers/scsi/seagate.c
--- linux-2.5.60-ref/drivers/scsi/seagate.c	2003-02-14 21:21:36.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/seagate.c	2003-02-14 20:26:43.000000000 +0000
@@ -683,8 +683,8 @@
 
 	DANY ("seagate: que_command");
 	done_fn = done;
-	current_target = SCpnt->target;
-	current_lun = SCpnt->lun;
+	current_target = SCpnt->device->id;
+	current_lun = SCpnt->device->lun;
 	current_cmnd = SCpnt->cmnd;
 	current_data = (unsigned char *) SCpnt->request_buffer;
 	current_bufflen = SCpnt->request_bufflen;
@@ -713,7 +713,7 @@
 #endif				/* LINKED */
 			reconnect = CAN_RECONNECT;
 
-		result = internal_command(SCint->target, SCint->lun, SCint->cmnd,
+		result = internal_command(SCint->device->id, SCint->device->lun, SCint->cmnd,
 				      SCint->request_buffer, SCint->request_bufflen, reconnect);
 		if (msg_byte(result) == DISCONNECT)
 			break;
@@ -729,7 +729,7 @@
 
 static int seagate_st0x_command(Scsi_Cmnd * SCpnt)
 {
-	return internal_command (SCpnt->target, SCpnt->lun, SCpnt->cmnd,
+	return internal_command (SCpnt->device->id, SCpnt->device->lun, SCpnt->cmnd,
 				 SCpnt->request_buffer, SCpnt->request_bufflen,
 				 (int) NO_RECONNECT);
 }
